from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
from flask_cors import CORS
from werkzeug.security import generate_password_hash

app = Flask(__name__)
CORS(app)

app.config["SQLALCHEMY_DATABASE_URI"] = (
    "mssql+pyodbc://DESKTOP-8FISMU6\\SQLEXPRESS01/ProjectTest?driver=ODBC Driver 17 for SQL Server&trusted_connection=yes"
)
db = SQLAlchemy(app)


# Users Api ----------------------------------------------------------
@app.route("/api/users", methods=["GET"])
def get_users():
    try:
        users = db.session.execute(text("SELECT * FROM Users")).fetchall()
        return jsonify(
            [
                {"user_id": u.user_id, "username": u.username, "email": u.email}
                for u in users
            ]
        )
    except Exception as e:
        return jsonify({"error": "Could not get users"}), 500


@app.route("/api/users", methods=["POST"])
def add_user():
    try:
        data = request.json
        db.session.execute(
            text(
                "INSERT INTO Users (username, email, password) VALUES (:username, :email, :password)"
            ),
            {
                "username": data["username"],
                "email": data["email"],
                "password": generate_password_hash(data["password"]),
            },
        )
        db.session.commit()
        return jsonify({"message": "User added"}), 201
    except Exception as e:
        return jsonify({"error": f"Could not add user: {str(e)}"}), 500


@app.route("/api/users/<int:id>", methods=["PUT"])
def update_user(id):
    try:
        data = request.json
        db.session.execute(
            text(
                "UPDATE Users SET username = :username, email = :email, password = :password WHERE user_id = :user_id"
            ),
            {
                "username": data["username"],
                "email": data["email"],
                "password": data["password"],
                "user_id": id,
            },
        )
        db.session.commit()
        return jsonify({"message": "User updated"})
    except Exception as e:
        return jsonify({"error": f"Could not update user: {str(e)}"}), 500


@app.route("/api/users/<int:id>", methods=["DELETE"])
def delete_user(id):
    try:
        db.session.execute(
            text("DELETE FROM Users WHERE user_id = :user_id"), {"user_id": id}
        )
        db.session.commit()
        return jsonify({"message": "User deleted"})
    except Exception as e:
        return jsonify({"error": "Could not delete user"}), 500


# Recipes Api ------------------------------------------------------
@app.route("/api/recipes", methods=["GET"])
def get_recipes():
    try:
        recipes = db.session.execute(text("SELECT * FROM Recipe")).fetchall()
        return jsonify(
            [
                {
                    "recipe_id": r.recipe_id,
                    "recipe_name": r.recipe_name,
                    "prep_time": r.prep_time,
                    "servings": r.servings,
                }
                for r in recipes
            ]
        )
    except Exception as e:
        return jsonify({"error": "Could not get recipes"}), 500


@app.route("/api/recipes/<int:id>", methods=["GET"])
def get_recipe(id):
    try:
        recipe = db.session.execute(
            text("SELECT * FROM Recipe WHERE recipe_id = :recipe_id"), {"recipe_id": id}
        ).fetchone()
        if not recipe:
            return jsonify({"error": "Recipe not found"}), 404

        ingredients = db.session.execute(
            text(
                "SELECT i.ingredient_id, i.ingredient_name, ri.quantity, i.measurement_unit FROM RecipeIngredients ri JOIN Ingredient i ON ri.ingredient_id = i.ingredient_id WHERE recipe_id = :recipe_id"
            ),
            {"recipe_id": id},
        ).fetchall()
        steps = db.session.execute(
            text(
                "SELECT s.description, rs.step_number FROM RecipeSteps rs JOIN Step s ON rs.step_id = s.step_id WHERE recipe_id = :recipe_id ORDER BY step_number"
            ),
            {"recipe_id": id},
        ).fetchall()
        tags = db.session.execute(
            text(
                "SELECT t.tag_name FROM RecipeTags rt JOIN Tag t ON rt.tag_id = t.tag_id WHERE recipe_id = :recipe_id"
            ),
            {"recipe_id": id},
        ).fetchall()

        return jsonify(
            {
                "recipe_id": recipe.recipe_id,
                "recipe_name": recipe.recipe_name,
                "prep_time": recipe.prep_time,
                "servings": recipe.servings,
                "ingredients": [
                    {
                        "id": i.ingredient_id,
                        "name": i.ingredient_name,
                        "quantity": float(i.quantity),
                        "unit": i.measurement_unit,
                    }
                    for i in ingredients
                ],
                "steps": [
                    {"number": s.step_number, "description": s.description}
                    for s in steps
                ],
                "tags": [t.tag_name for t in tags],
            }
        )
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/api/recipes", methods=["POST"])
def create_recipe():
    try:
        data = request.json
        result = db.session.execute(
            text(
                "INSERT INTO Recipe (recipe_name, prep_time, servings) OUTPUT INSERTED.recipe_id VALUES (:recipe_name, :prep_time, :servings);"
            ),
            {
                "recipe_name": data["recipe_name"],
                "prep_time": data["prep_time"],
                "servings": data["servings"],
            },
        )
        recipe_id = result.scalar()

        for ingredient in data.get("ingredients", []):
            db.session.execute(
                text(
                    "INSERT INTO RecipeIngredients (recipe_id, ingredient_id, quantity) VALUES (:recipe_id, :ingredient_id, :quantity)"
                ),
                {
                    "recipe_id": recipe_id,
                    "ingredient_id": ingredient["id"],
                    "quantity": ingredient["quantity"],
                },
            )

        for i, step in enumerate(data.get("steps", []), 1):
            step_result = db.session.execute(
                text(
                    "INSERT INTO Step (description) OUTPUT INSERTED.step_id VALUES (:description);"
                ),
                {"description": step["description"]},
            )

            step_id = step_result.scalar()
            db.session.execute(
                text(
                    "INSERT INTO RecipeSteps (recipe_id, step_id, step_number) VALUES (:recipe_id, :step_id, :step_number)"
                ),
                {"recipe_id": recipe_id, "step_id": step_id, "step_number": i},
            )

        for tag_id in data.get("tags", []):
            db.session.execute(
                text(
                    """INSERT INTO RecipeTags (recipe_id, tag_id) VALUES (:recipe_id, :tag_id)"""
                ),
                {"recipe_id": recipe_id, "tag_id": tag_id},
            )

        for allergen_id in data.get("allergens", []):
            db.session.execute(
                text(
                    """INSERT INTO RecipeAllergens (recipe_id, allergen_id) VALUES (:recipe_id, :allergen_id)"""
                ),
                {"recipe_id": recipe_id, "allergen_id": allergen_id},
            )

        db.session.commit()
        return jsonify({"message": "Recipe created", "recipe_id": recipe_id}), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500


@app.route("/api/recipes/<int:id>", methods=["PUT"])
def update_recipe(id):
    try:
        data = request.json
        db.session.execute(
            text(
                "UPDATE Recipe SET recipe_name = :recipe_name, prep_time = :prep_time, servings = :servings WHERE recipe_id = :recipe_id"
            ),
            {
                "recipe_name": data["recipe_name"],
                "prep_time": data["prep_time"],
                "servings": data["servings"],
                "recipe_id": id,
            },
        )
        db.session.commit()
        return jsonify({"message": "Recipe updated"})
    except Exception as e:
        return jsonify({"error": f"Could not update recipe: {str(e)}"}), 500


@app.route("/api/recipes/<int:id>", methods=["DELETE"])
def delete_recipe(id):
    try:
        db.session.execute(
            text("DELETE FROM RecipeTags WHERE recipe_id = :recipe_id"),
            {"recipe_id": id},
        )

        db.session.execute(
            text("DELETE FROM RecipeAllergens WHERE recipe_id = :recipe_id"),
            {"recipe_id": id},
        )

        db.session.execute(
            text("DELETE FROM RecipeIngredients WHERE recipe_id = :recipe_id"),
            {"recipe_id": id},
        )

        steps = db.session.execute(
            text("SELECT step_id FROM RecipeSteps WHERE recipe_id = :recipe_id"),
            {"recipe_id": id},
        ).fetchall()

        db.session.execute(
            text("DELETE FROM RecipeSteps WHERE recipe_id = :recipe_id"),
            {"recipe_id": id},
        )

        for step in steps:
            db.session.execute(
                text("DELETE FROM Step WHERE step_id = :step_id"),
                {"step_id": step.step_id},
            )

        db.session.execute(
            text("DELETE FROM FavoriteRecipes WHERE recipe_id = :recipe_id"),
            {"recipe_id": id},
        )

        db.session.execute(
            text("DELETE FROM Recipe WHERE recipe_id = :recipe_id"), {"recipe_id": id}
        )
        db.session.commit()
        return jsonify({"message": "Recipe deleted"})
    except Exception as e:
        return jsonify({"error": f"Could not delete recipe: {str(e)}"}), 500


# Ingredients Api ----------------------------------------------
@app.route("/api/ingredients", methods=["GET"])
def get_ingredients():
    try:
        ingredients = db.session.execute(text("SELECT * FROM Ingredient")).fetchall()
        return jsonify(
            [
                {
                    "ingredient_id": i.ingredient_id,
                    "ingredient_name": i.ingredient_name,
                    "measurement_unit": i.measurement_unit,
                }
                for i in ingredients
            ]
        )
    except Exception as e:
        return jsonify({"error": "Could not get ingredients"}), 500


@app.route("/api/ingredients", methods=["POST"])
def add_ingredient():
    try:
        data = request.json
        result = db.session.execute(
            text(
                "INSERT INTO Ingredient (ingredient_name, measurement_unit) VALUES (:ingredient_name, :measurement_unit);"
            ),
            {
                "ingredient_name": data["ingredient_name"],
                "measurement_unit": data["measurement_unit"],
            },
        )
        db.session.commit()
        return (
            jsonify({"message": "Ingredient added"}),
            201,
        )
    except Exception as e:
        return jsonify({"error": f"Could not add ingredient: {str(e)}"}), 500


@app.route("/api/ingredients/<int:id>", methods=["PUT"])
def update_ingredient(id):
    try:
        data = request.json
        db.session.execute(
            text(
                "UPDATE Ingredient SET ingredient_name = :ingredient_name, measurement_unit = :measurement_unit WHERE ingredient_id = :ingredient_id"
            ),
            {
                "ingredient_name": data["ingredient_name"],
                "measurement_unit": data["measurement_unit"],
                "ingredient_id": id,
            },
        )
        db.session.commit()
        return jsonify({"message": "Ingredient updated"})
    except Exception as e:
        return jsonify({"error": "Could not update ingredient"}), 500


@app.route("/api/ingredients/<int:id>", methods=["DELETE"])
def delete_ingredient(id):
    try:
        db.session.execute(
            text("DELETE FROM Ingredient WHERE ingredient_id = :ingredient_id"),
            {"ingredient_id": id},
        )
        db.session.commit()
        return jsonify({"message": "Ingredient deleted"})
    except Exception as e:
        return jsonify({"error": "Could not delete ingredient"}), 500


# Pantry Api ---------------------------------------------------------
@app.route("/api/pantry/<int:user_id>", methods=["GET"])
def get_pantry(user_id):
    try:
        items = db.session.execute(
            text(
                "SELECT p.*, i.ingredient_name FROM Pantry p JOIN Ingredient i ON p.ingredient_id = i.ingredient_id WHERE user_id = :user_id"
            ),
            {"user_id": user_id},
        ).fetchall()
        return jsonify(
            [
                {
                    "ingredient_id": item.ingredient_id,
                    "ingredient_name": item.ingredient_name,
                    "quantity": float(item.quantity),
                }
                for item in items
            ]
        )
    except Exception as e:
        return jsonify({"error": "Could not get pantry"}), 500


@app.route("/api/pantry/<int:user_id>", methods=["POST"])
def add_to_pantry(user_id):
    try:
        data = request.json
        db.session.execute(
            text(
                "INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES (:user_id, :ingredient_id, :quantity)"
            ),
            {
                "user_id": user_id,
                "ingredient_id": data["ingredient_id"],
                "quantity": data["quantity"],
            },
        )
        db.session.commit()
        return jsonify({"message": "Added to pantry"}), 201
    except Exception as e:
        return jsonify({"error": "Could not add to pantry"}), 500


@app.route("/api/pantry/<int:user_id>/<int:ingredient_id>", methods=["PUT"])
def update_pantry(user_id, ingredient_id):
    try:
        data = request.json
        db.session.execute(
            text(
                "UPDATE Pantry SET quantity = :quantity WHERE user_id = :user_id AND ingredient_id = :ingredient_id"
            ),
            {
                "quantity": data["quantity"],
                "user_id": user_id,
                "ingredient_id": ingredient_id,
            },
        )
        db.session.commit()
        return jsonify({"message": "Updated pantry"})
    except Exception as e:
        return jsonify({"error": "Could not update pantry"}), 500


@app.route("/api/pantry/<int:user_id>/<int:ingredient_id>", methods=["DELETE"])
def remove_from_pantry(user_id, ingredient_id):
    try:
        db.session.execute(
            text(
                "DELETE FROM Pantry WHERE user_id = :user_id AND ingredient_id = :ingredient_id"
            ),
            {"user_id": user_id, "ingredient_id": ingredient_id},
        )
        db.session.commit()
        return jsonify({"message": "Removed from pantry"})
    except Exception as e:
        return jsonify({"error": "Could not remove from pantry"}), 500


# Favorite Recipes Api ---------------------------------------------
@app.route("/api/favorites/<int:user_id>", methods=["GET"])
def get_favorites(user_id):
    try:
        favorites = db.session.execute(
            text(
                "SELECT f.*, r.recipe_name FROM FavoriteRecipes f JOIN Recipe r ON f.recipe_id = r.recipe_id WHERE user_id = :user_id"
            ),
            {"user_id": user_id},
        ).fetchall()
        return jsonify(
            [
                {"recipe_id": f.recipe_id, "recipe_name": f.recipe_name}
                for f in favorites
            ]
        )
    except Exception as e:
        return jsonify({"error": "Could not get favorites"}), 500


@app.route("/api/favorites/<int:user_id>/<int:recipe_id>", methods=["POST"])
def add_favorite(user_id, recipe_id):
    try:
        db.session.execute(
            text(
                "INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES (:user_id, :recipe_id)"
            ),
            {"user_id": user_id, "recipe_id": recipe_id},
        )
        db.session.commit()
        return jsonify({"message": "Added to favorites"}), 201
    except Exception as e:
        return jsonify({"error": "Could not add to favorites"}), 500


@app.route("/api/favorites/<int:user_id>/<int:recipe_id>", methods=["PUT"])
def update_favorite(user_id, recipe_id):
    try:
        data = request.json
        db.session.execute(
            text(
                "UPDATE FavoriteRecipes SET recipe_id = :new_recipe_id WHERE user_id = :user_id AND recipe_id = :old_recipe_id"
            ),
            {
                "user_id": user_id,
                "old_recipe_id": recipe_id,
                "new_recipe_id": data["new_recipe_id"],
            },
        )
        db.session.commit()
        return jsonify({"message": "Updated favorite"})
    except Exception as e:
        return jsonify({"error": "Could not update favorite"}), 500


@app.route("/api/favorites/<int:user_id>/<int:recipe_id>", methods=["DELETE"])
def remove_favorite(user_id, recipe_id):
    try:
        db.session.execute(
            text(
                "DELETE FROM FavoriteRecipes WHERE user_id = :user_id AND recipe_id = :recipe_id"
            ),
            {"user_id": user_id, "recipe_id": recipe_id},
        )
        db.session.commit()
        return jsonify({"message": "Removed from favorites"})
    except Exception as e:
        return jsonify({"error": "Could not remove from favorites"}), 500

#Tags Api -----------------------------------------
@app.route("/api/tags", methods=["GET"])
def get_tags():
    try:
        tags = db.session.execute(text("SELECT * FROM Tag")).fetchall()
        return jsonify(
            [{"tag_id": tag.tag_id, "tag_name": tag.tag_name} for tag in tags]
        )
    except Exception as e:
        return jsonify({"error": "Could not get tags"}), 500

#Allerges Api -----------------------------------
@app.route("/api/allergens", methods=["GET"])
def get_allergens():
    try:
        allergens = db.session.execute(text("SELECT * FROM Allergen")).fetchall()
        return jsonify(
            [
                {
                    "allergen_id": allergen.allergen_id,
                    "allergen_type": allergen.allergen_type,
                }
                for allergen in allergens
            ]
        )
    except Exception as e:
        return jsonify({"error": "Could not get allergens"}), 500


if __name__ == "__main__":
    app.run(debug=True)
