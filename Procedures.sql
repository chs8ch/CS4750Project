-- Add Ingredient to Shopping List from a recipe. Really helpful for planning out shopping trips
CREATE PROCEDURE AddRecipeIngredientsToShoppingList (@user_id int, @recipe_id int)
AS
BEGIN
    MERGE INTO ShoppingList AS list
    USING (
        SELECT @user_id AS user_id, ri.ingredient_id, ri.quantity FROM RecipeIngredients ri WHERE ri.recipe_id = @recipe_id) AS recipe
    ON list.user_id = recipe.user_id 
    AND list.ingredient_id = recipe.ingredient_id
    WHEN MATCHED THEN
        UPDATE SET quantity = list.quantity + recipe.quantity
    WHEN NOT MATCHED THEN
        INSERT (user_id, ingredient_id, quantity)
        VALUES (recipe.user_id, recipe.ingredient_id, recipe.quantity);
END;
GO

-- Update pantry after cooking. Conveneint for automatically tracking ingredients.
CREATE PROCEDURE UpdatePantry(@user_id int, @recipe_id int)
AS
BEGIN
    UPDATE p SET p.quantity = p.quantity - ri.quantity FROM Pantry p JOIN RecipeIngredients ri ON p.ingredient_id = ri.ingredient_id WHERE p.user_id = @user_id AND ri.recipe_id = @recipe_id
END;
GO

--Remove All Recipes from Favorites with Tag. Mainly used so people can quickly clean up their favorites in the event they no longer enjoy a certain type of meal.
CREATE PROCEDURE RemoveFavoriteTag(@user_id int, @tag_id int)
AS
BEGIN
    DELETE fr FROM FavoriteRecipes fr JOIN RecipeTags rt ON fr.recipe_id = rt.recipe_id WHERE fr.user_id = @user_id AND rt.tag = @tag_id;
END;
GO


-- Check recipe for allergen. Helpful for quickly seeing if you will be allergic to it or not.
CREATE FUNCTION HasAllergen (@recipe_id int, @allergen_id int)
RETURNS BIT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM RecipeAllergens WHERE recipe_id = @recipe_id AND allergen_id = @allergen_id) RETURN 1;
    RETURN 0;
END;
GO

-- Get all recipes with a specific tag. Nice if you're looking for something specific.
CREATE FUNCTION GetRecipeWithTag (@tag_id int)
RETURNS TABLE
AS
RETURN (
    SELECT r.recipe_name FROM Recipe r JOIN RecipeTags rt ON r.recipe_id = rt.recipe_id WHERE rt.tag_id = @tag_id
);
GO

-- Get all recipes without a specific allergen. Good for people who want to filter out specific allergens.
CREATE FUNCTION GetRecipeWithoutAllergen (@allergen_id int)
RETURNS TABLE
AS
RETURN (
    SELECT r.recipe_name, STRING_AGG(a.allergen_type, ', ') as other_allergens FROM Recipe r LEFT JOIN RecipeAllergens ra ON r.recipe_id = ra.recipe_id LEFT JOIN Allergen a ON ra.allergen_id = a.allergen_id WHERE r.recipe_id NOT IN (
        Select DISTINCT r.recipe_id FROM Recipe r JOIN RecipeAllergens ra ON r.recipe_id = ra.recipe_id WHERE ra.allergen_id = @allergen_id) GROUP BY r.recipe_id, r.recipe_name
);
GO

-- View for looking at a recipe with details
CREATE VIEW view_RecipeDetails AS
SELECT
    r.recipe_id, r.recipe_name, r.prep_time, r.servings, i.ingredient_name, ri.quantity, i.measurement_unit FROM Recipe r JOIN RecipeIngredients ri ON r.recipe_id = ri.recipe_id JOIN Ingredient i ON ri.ingredient_id = i.ingredient_id;
GO

-- View for looking at a shopping list with details
CREATE VIEW view_ShoppingListDetails AS
SELECT
    u.username, i.ingredient_name, sl.quantity, i.measurement_unit, i.category FROM ShoppingList sl JOIN Users u ON sl.user_id = u.user_id JOIN Ingredient i ON sl.ingredient_id = i.ingredient_id;
GO

-- View for looking at the pantry with details
CREATE VIEW view_PantryDetails AS
SELECT
    u.username, i.ingredient_name, p.quantity, i.measurement_unit, i.category FROM Pantry p JOIN Ingredient i ON p.ingredient_id = i.ingredient_id JOIN Users u ON p.user_id = u.user_id;
GO

-- Trigger that adds the ingredient into the shopping cart when you run low
CREATE TRIGGER trigger_LowStock
ON Pantry
AFTER UPDATE
AS
BEGIN
    DECLARE @minimum DECIMAL(6, 2) = 1.0;
    INSERT INTO ShoppingList (user_id, ingredient_id, quantity) SELECT i.user_id, i.ingredient_id, 2.5 - i.quantity AS quantity FROM inserted i WHERE i.quantity < @minimum AND NOT EXISTS (SELECT 1 FROM ShoppingList sl WHERE sl.user_id = i.user_id AND sl.ingredient_id = i.ingredient_id);
END;


-- Encryption for password
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'password'
CREATE CERTIFICATE Certificate WITH SUBJECT = 'Certificate';
CREATE SYMMETRIC KEY SymKey WITH ALGORITHM = AES_256 ENCRYPTION BY CERTIFICATE Certificate;
ALTER TABLE Users ADD encrypted_password VARBINARY(256)
UPDATE Users SET encrypted_password = ENCRYPTBYKEY(KEY_GUID('SymKey'), CONVERT(varbinary, password));

-- Index for recipe names
CREATE NONCLUSTERED INDEX index_Recipe_Name ON Recipe(recipe_name);

-- Index for ingredient category
CREATE NONCLUSTERED INDEX index_Ingredient_Category ON Ingredient(category, ingredient_name);

-- Index for pantry by quantity
CREATE NONCLUSTERED INDEX index_Pantry_Quantity ON Pantry(quantity) INCLUDE (ingredient_id, user_id);

