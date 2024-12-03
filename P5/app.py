import streamlit as st
import requests
import pandas as pd
import datetime

API_BASE_URL = "http://localhost:5000/api"
#https://docs.streamlit.io/develop/concepts/architecture/caching
@st.cache_data(ttl=300)
def get_data(endpoint):
    try:
        response = requests.get(f"{API_BASE_URL}/{endpoint}", timeout=5)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.ConnectionError:
        st.error(
            "Cannot connect to API server."
        )
        return []
    except requests.exceptions.RequestException as e:
        st.error(f"API Error: {str(e)}")
        return []

def get_statistics():
    recipes = get_data("recipes")
    ingredients = get_data("ingredients")
    users = get_data("users")
    
    if not isinstance(recipes, list) or not isinstance(ingredients, list) or not isinstance(users, list):
        return {
            "recipes": "?",
            "ingredients": "?",
            "users": "?",
            "last_updated": "Error fetching data"
        }
        
    return {
        "recipes": len(recipes),
        "ingredients": len(ingredients), 
        "users": len(users),
        "last_updated": datetime.datetime.now().strftime("%H:%M:%S"),
    }

if "last_update" not in st.session_state:
    st.session_state.last_update = datetime.datetime.now()

def clear_cache():
    get_data.clear()

def create_item(endpoint, data):
    try:
        response = requests.post(f"{API_BASE_URL}/{endpoint}", json=data, timeout=5)
        response.raise_for_status()
        clear_cache()
        return response.json()
    except requests.exceptions.RequestException as e:
        st.error(f"API Error: {str(e)}")
        return None

def update_item(endpoint, data):
    try:
        print(f"Sending PUT to {API_BASE_URL}/{endpoint} with data: {data}")
        response = requests.put(f"{API_BASE_URL}/{endpoint}", json=data, timeout=5)
        response.raise_for_status()
        clear_cache()
        return response.json()
    except requests.exceptions.RequestException as e:
        st.error(f"API Error: {str(e)}")
        return None

def delete_item(endpoint):
    try:
        response = requests.delete(f"{API_BASE_URL}/{endpoint}", timeout=5)
        response.raise_for_status()
        clear_cache()
        return response.json()
    except requests.exceptions.RequestException as e:
        st.error(f"API Error: {str(e)}")
        return None

st.set_page_config(page_title="Recipe Database", layout="wide")
st.title("Recipe Database")

page = st.sidebar.selectbox(
    "Select Page", ["Recipes", "Ingredients", "Users", "Pantry", "Favorites"]
)

if page == "Recipes":
    st.header("Recipe Management")

    col1, col2 = st.columns([2, 3])

    with col1:
        st.subheader("Recipe List")
        recipes = get_data("recipes")
        if recipes:
            df = pd.DataFrame(recipes)
            recipe_options = {f"{recipe["recipe_id"]}: {recipe['recipe_name']}": recipe["recipe_id"] for recipe in recipes}
            selected_recipe = st.selectbox(
                "Select a recipe to view details", options=list(recipe_options.keys())
            )
            if selected_recipe:
                st.session_state.current_recipe_id = recipe_options[selected_recipe]

    with col2:
        if "current_recipe_id" in st.session_state:
            recipe_details = get_data(f"recipes/{st.session_state.current_recipe_id}")
            if recipe_details:
                st.subheader(recipe_details["recipe_name"])
                if recipe_details["prep_time"]:
                    st.write(f"Prep Time: {recipe_details['prep_time']} minutes")
                if recipe_details["servings"]:
                    st.write(f"Servings: {recipe_details['servings']}")

                st.subheader("Ingredients")
                ingredients_df = pd.DataFrame(recipe_details["ingredients"])
                st.dataframe(
                    ingredients_df[["name", "quantity", "unit"]],
                    hide_index=True,
                    column_config={
                        "name": "Name",
                        "quantity": "Quantity",
                        "unit": "Unit",
                    },
                    use_container_width=True,
                )

                st.subheader("Steps")
                steps_df = pd.DataFrame(recipe_details["steps"]).sort_values("number")
                for _, step in steps_df.iterrows():
                    st.markdown(f"**{step['number']}.** {step['description']}")

                if recipe_details.get("tags"):
                    st.write("**Tags:**", ", ".join(recipe_details["tags"]))

    st.markdown("---")
    action = st.radio("Action", ["Add", "Edit", "Delete"])

    if action == "Add":
        st.subheader("Add New Recipe")
        
        if "ingredients" not in st.session_state:
            st.session_state.ingredients = []
        if "steps" not in st.session_state:
            st.session_state.steps = []
        if "tags" not in st.session_state:
            st.session_state.tags = []
        if "allergens" not in st.session_state:
            st.session_state.allergens = []

        with st.form("new_recipe"):
            name = st.text_input("Name")
            prep = st.number_input("Prep Time (mins)", min_value=1)
            servings = st.number_input("Servings", min_value=1)

            st.subheader("Current Ingredients")
            if st.session_state.ingredients:
                for i, ing in enumerate(st.session_state.ingredients):
                    st.write(f"- {ing['name']}: {ing['quantity']}")
                    if st.form_submit_button(f"Remove #{i}"):
                        st.session_state.ingredients.pop(i)
                        st.rerun()

            st.subheader("Current Steps")
            if st.session_state.steps:
                for i, step in enumerate(st.session_state.steps):
                    st.write(f"{i + 1}. {step['description']}")
                    if st.form_submit_button(f"Remove Step #{i}"):
                        st.session_state.steps.pop(i)
                        st.rerun()

            st.subheader("Current Tags")
            if st.session_state.tags:
                for i, tag in enumerate(st.session_state.tags):
                    st.write(f"- {tag['name']}")
                    if st.form_submit_button(f"Remove Tag #{i}"):
                        st.session_state.tags.pop(i)
                        st.rerun()

            st.subheader("Current Allergens")
            if st.session_state.allergens:
                for i, allergen in enumerate(st.session_state.allergens):
                    st.write(f"- {allergen['type']}")
                    if st.form_submit_button(f"Remove Allergen #{i}"):
                        st.session_state.allergens.pop(i)
                        st.rerun()

            if st.form_submit_button("Save Recipe") and name:
                result = create_item(
                    "recipes",
                    {
                        "recipe_name": name,
                        "prep_time": prep,
                        "servings": servings,
                        "ingredients": st.session_state.ingredients,
                        "steps": st.session_state.steps,
                        "tags": [tag['id'] for tag in st.session_state.tags],
                        "allergens": [allergen['id'] for allergen in st.session_state.allergens]
                    },
                )
                if result:
                    st.session_state.ingredients = []
                    st.session_state.steps = []
                    st.session_state.tags = []
                    st.session_state.allergens = []
                    st.success("Recipe Added")
                    st.rerun()

        with st.form("add_ingredients_form"):
            ingredients = get_data("ingredients")
            if ingredients:
                ingredients_list = {
                    ingredient["ingredient_name"]: ingredient["ingredient_id"] 
                    for ingredient in ingredients
                }
                selected_ingredient = st.selectbox(
                    "Select Ingredient",
                    options=list(ingredients_list.keys())
                )
                quantity = st.number_input("Quantity", min_value=0.1, step=0.1, value=0.1)
                
                if st.form_submit_button("Add"):
                    st.session_state.ingredients.append({
                        "id": ingredients_list[selected_ingredient],
                        "name": selected_ingredient,
                        "quantity": quantity
                    })
                    st.rerun()

        with st.form("add_step"):
            step_description = st.text_area("Step")
            if st.form_submit_button("Add Step"):
                if step_description:
                    st.session_state.steps.append({
                        "number": len(st.session_state.steps) + 1,
                        "description": step_description
                    })
                    st.rerun()

        with st.form("add_tag"):
            tags = get_data("tags")
            if tags:
                tag_options = {
                    tag["tag_name"]: tag["tag_id"]
                    for tag in tags
                }
                selected_tag = st.selectbox(
                    "Select Tag",
                    options=list(tag_options.keys())
                )
                
                if st.form_submit_button("Add Tag"):
                    tag_to_add = {
                        "id": tag_options[selected_tag],
                        "name": selected_tag
                    }
                    if not any(tag["id"] == tag_to_add["id"] for tag in st.session_state.tags):
                        st.session_state.tags.append(tag_to_add)
                        st.rerun()

        with st.form("add_allergen"):
            allergens = get_data("allergens")
            if allergens:
                allergen_options = {
                    allergen["allergen_type"]: allergen["allergen_id"]
                    for allergen in allergens
                }
                selected_allergen = st.selectbox(
                    "Select Allergen",
                    options=list(allergen_options.keys())
                )
                
                if st.form_submit_button("Add Allergen"):
                    allergen_to_add = {
                        "id": allergen_options[selected_allergen],
                        "type": selected_allergen
                    }
                    if not any(allergen["id"] == allergen_to_add["id"] for allergen in st.session_state.allergens):
                        st.session_state.allergens.append(allergen_to_add)
                        st.rerun()

    elif action == "Edit":
        st.subheader("Edit Recipe")
        recipe_id = st.number_input("Recipe ID", min_value=1)
        current_recipe = get_data(f"recipes/{recipe_id}")
        if current_recipe:
            with st.form("edit_recipe"):
                recipe_name = st.text_input(
                    "New Recipe Name", value=current_recipe["recipe_name"]
                )
                prep_time = st.number_input(
                    "New Prep Time (minutes)",
                    min_value=1,
                    value=current_recipe["prep_time"],
                )
                servings = st.number_input(
                    "New Servings", min_value=1, value=current_recipe["servings"]
                )

                if st.form_submit_button("Update Recipe"):
                    result = update_item(
                        f"recipes/{recipe_id}",
                        {
                            "recipe_name": recipe_name,
                            "prep_time": prep_time,
                            "servings": servings,
                        },
                    )
                    if result:
                        st.success("Recipe updated")
                        st.rerun()

    else:
        st.subheader("Delete Recipe")
        recipe_id = st.number_input("Recipe ID to Delete", min_value=1)
        if st.button("Delete Recipe"):
            result = delete_item(f"recipes/{recipe_id}")
            if result:
                st.success("Recipe deleted")
                st.rerun()

elif page == "Ingredients":
    st.header("Ingredient Management")
    ingredients = get_data("ingredients")
    if ingredients:
        df = pd.DataFrame(ingredients)
        st.dataframe(
            df[["ingredient_id", "ingredient_name", "measurement_unit"]],
            hide_index=True,
        )

        action = st.radio("Action", ["Add", "Edit", "Delete"])

        if action == "Add":
            with st.form("add_ingredient"):
                ingredient_name = st.text_input("Ingredient Name")
                measurement_unit = st.text_input("Measurement Unit")

                if st.form_submit_button("Add Ingredient"):
                    result = create_item(
                        "ingredients",
                        {"ingredient_name": ingredient_name, "measurement_unit": measurement_unit},
                    )
                    if result:
                        st.success("Ingredient added")
                        st.rerun()

        elif action == "Edit":
            ingredient_id = st.number_input("Ingredient ID", min_value=1)
            with st.form("edit_ingredient"):
                ingredient_name = st.text_input("New Ingredient Name")
                measurement_unit = st.text_input("New Measurement Unit")

                if st.form_submit_button("Update Ingredient"):
                    result = update_item(
                        f"ingredients/{ingredient_id}",
                        {"ingredient_name": ingredient_name, "measurement_unit": measurement_unit},
                    )
                    if result:
                        st.success("Ingredient updated")
                        st.rerun()

        else:
            ingredient_id = st.number_input("Ingredient ID to Delete", min_value=1)
            if st.button("Delete Ingredient"):
                result = delete_item(f"ingredients/{ingredient_id}")
                if result:
                    st.success("Ingredient deleted")
                    st.rerun()

elif page == "Users":
    st.header("User Management")
    users = get_data("users")
    if users:
        df = pd.DataFrame(users)
        st.dataframe(df[["user_id", "username", "email"]], hide_index=True)

        action = st.radio("Action", ["Add", "Edit", "Delete"])

        if action == "Add":
            with st.form("add_user"):
                username = st.text_input("Username")
                email = st.text_input("Email")
                password = st.text_input("Password", type="password")

                if st.form_submit_button("Add User"):
                    result = create_item(
                        "users",
                        {"username": username, "email": email, "password": password},
                    )
                    print(result)
                    if result:
                        st.success("User added")
                        st.rerun()

        elif action == "Edit":
            user_id = st.number_input("User ID", min_value=0)
            with st.form("edit_user"):
                username = st.text_input("New Username")
                email = st.text_input("New Email")
                password = st.text_input("New Password")

                if st.form_submit_button("Update User"):
                    result = update_item(
                        f"users/{user_id}",
                        {"username": username, "email": email, "password": password},
                    )
                    if result:
                        st.success("User updated")
                        st.rerun()

        else:
            user_id = st.number_input("User ID to Delete", min_value=1)
            if st.button("Delete User"):
                result = delete_item(f"users/{user_id}")
                if result:
                    st.success("User deleted")
                    st.rerun()

elif page == "Pantry":
    st.header("Pantry Management")
    users = get_data("users")
    if users:
        user_options = {
            f"{user['username']} ({user['email']})": user["user_id"] for user in users
        }
        selected_user = st.selectbox("Select User", options=list(user_options.keys()))
        user_id = user_options[selected_user]

        pantry = get_data(f"pantry/{user_id}")
        if pantry is not None:
            if len(pantry) > 0:
                df = pd.DataFrame(pantry)
                st.dataframe(df[["ingredient_name", "quantity"]], hide_index=True)

            action = st.radio("Action", ["Add", "Edit", "Delete"])

            if action == "Add":
                ingredients = get_data("ingredients")
                if ingredients:
                    with st.form("add_pantry"):
                        ingredient_options = {
                            ingredient["ingredient_name"]: ingredient["ingredient_id"]
                            for ingredient in ingredients
                        }
                        selected_ingredient = st.selectbox(
                            "Select Ingredient", options=list(ingredient_options.keys())
                        )
                        quantity = st.number_input("Quantity", min_value=0.1)

                        if st.form_submit_button("Add to Pantry"):
                            result = create_item(
                                f"pantry/{user_id}",
                                {
                                    "ingredient_id": ingredient_options[selected_ingredient],
                                    "quantity": quantity,
                                },
                            )
                            if result:
                                st.success("Item added to pantry")
                                st.rerun()

            elif action == "Edit":
                if len(pantry) > 0:
                    with st.form("edit_pantry"):
                        ingredient_options = {
                            item["ingredient_name"]: item["ingredient_id"]
                            for item in pantry
                        }
                        selected_ingredient = st.selectbox(
                            "Select Ingredient", options=list(ingredient_options.keys())
                        )
                        quantity = st.number_input("New Quantity", min_value=0.1)

                        if st.form_submit_button("Update Quantity"):
                            result = update_item(
                                f"pantry/{user_id}/{ingredient_options[selected_ingredient]}",
                                {"quantity": quantity},
                            )
                            if result:
                                st.success("Quantity updated")
                                st.rerun()

            else:
                if len(pantry) > 0:
                    ingredient_options = {
                        item["ingredient_name"]: item["ingredient_id"]
                        for item in pantry
                    }
                    selected_ingredient = st.selectbox(
                        "Select Ingredient to Remove", options=list(ingredient_options.keys())
                    )

                    if st.button("Remove from Pantry"):
                        result = delete_item(
                            f"pantry/{user_id}/{ingredient_options[selected_ingredient]}"
                        )
                        if result:
                            st.success("Item removed from pantry")
                            st.rerun()

elif page == "Favorites":
    st.header("Favorite Recipes Management")
    users = get_data("users")
    if users:
        user_options = {
            f"{user['username']} ({user['email']})": user["user_id"] for user in users
        }
        selected_user = st.selectbox("Select User", options=list(user_options.keys()))
        user_id = user_options[selected_user]

        favorites = get_data(f"favorites/{user_id}")
        if favorites is not None:
            if len(favorites) > 0:
                df = pd.DataFrame(favorites)
                st.dataframe(df[["recipe_name"]], hide_index=True)

            action = st.radio("Action", ["Add", "Edit", "Remove"])

            if action == "Add":
                recipes = get_data("recipes")
                if recipes:
                    recipe_options = {recipe["recipe_name"]: recipe["recipe_id"] for recipe in recipes}
                    selected_recipe = st.selectbox(
                        "Select Recipe", options=list(recipe_options.keys())
                    )

                    if st.button("Add to Favorites"):
                        result = create_item(
                            f"favorites/{user_id}/{recipe_options[selected_recipe]}", {}
                        )
                        if result:
                            st.success("Recipe added to favorites")
                            st.rerun()

            elif action == "Edit":
                if len(favorites) > 0:
                    with st.form("edit_favorite"):
                        current_recipe_options = {
                            recipe["recipe_name"]: recipe["recipe_id"] for recipe in favorites
                        }
                        selected_current = st.selectbox(
                            "Select Current Recipe",
                            options=list(current_recipe_options.keys()),
                        )

                        other_recipes = get_data("recipes")
                        new_recipe_options = {
                            recipe["recipe_name"]: recipe["recipe_id"]
                            for recipe in other_recipes
                            if recipe["recipe_id"] != current_recipe_options[selected_current]
                        }
                        selected_new = st.selectbox(
                            "Select New Recipe", options=list(new_recipe_options.keys())
                        )

                        if st.form_submit_button("Update Favorite"):
                            result = update_item(
                                f"favorites/{user_id}/{current_recipe_options[selected_current]}",
                                {"new_recipe_id": new_recipe_options[selected_new]},
                            )
                            if result:
                                st.success("Favorite updated")
                                st.rerun()

            else:
                if len(favorites) > 0:
                    recipe_options = {
                        recipe["recipe_name"]: recipe["recipe_id"] for recipe in favorites
                    }
                    selected_recipe = st.selectbox(
                        "Select Recipe to Remove", options=list(recipe_options.keys())
                    )

                    if st.button("Remove from Favorites"):
                        result = delete_item(
                            f"favorites/{user_id}/{recipe_options[selected_recipe]}"
                        )
                        if result:
                            st.success("Recipe removed from favorites")
                            st.rerun()

st.sidebar.markdown("---")
st.sidebar.markdown("### System Statistics")
stats = get_statistics()
st.sidebar.write(f"Total Recipes: {stats['recipes']}")
st.sidebar.write(f"Total Ingredients: {stats['ingredients']}")
st.sidebar.write(f"Total Users: {stats['users']}")
st.sidebar.write(f"Last Updated: {stats['last_updated']}")

if st.sidebar.button("Refresh Cache"):
    clear_cache()
    st.session_state.last_update = datetime.datetime.now()
    st.rerun()