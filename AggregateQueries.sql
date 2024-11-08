-- Check number of items users have in the Pantry and Shopping List
SELECT u.username, (
    SELECT COUNT(*) FROM Pantry WHERE user_id = u.user_id) as pantry_items, (
        SELECT COUNT(*) FROM ShoppingList WHERE user_id = u.user_id) as shopping_list_items FROM Users u ORDER BY pantry_items DESC;

-- Check Number of Favorites a user has
SELECT u.username, COUNT(fr.recipe_id) as num_favorites FROM Users u JOIN FavoriteRecipes fr ON u.user_id = fr.user_id GROUP BY u.user_id, u.username ORDER BY u.user_id;

-- Check number of unique ingredients
SELECT COUNT(DISTINCT ingredient_id) AS unique_ingredients FROM RecipeIngredients;

-- Checks what the most common allergens are.
SELECT a.allergen_type, COUNT(ra.recipe_id) as recipe_count, ROUND(COUNT(ra.recipe_id) * 100.0 / (
    SELECT COUNT(*) FROM Recipe), 2) as percentage FROM Allergen a JOIN RecipeAllergens ra ON a.allergen_id = ra.allergen_id GROUP BY a.allergen_id, a.allergen_type ORDER BY recipe_count DESC;

-- List Recipes with their Ingredient Quantities
SELECT r.recipe_name, i.ingredient_name, ri.quantity, i.measurement_unit FROM Recipe r JOIN RecipeIngredients ri ON r.recipe_id = ri.recipe_id JOIN Ingredient i ON ri.ingredient_id = i.ingredient_id;

-- List of recipes with no Allergens
SELECT r.recipe_name, STRING_AGG(i.ingredient_name, ', ') AS ingredient_list FROM Recipe r JOIN RecipeIngredients ri ON r.recipe_id = ri.recipe_id JOIN Ingredient i ON ri.ingredient_id = i.ingredient_id  WHERE r.recipe_id NOT IN (
    SELECT DISTINCT recipe_id FROM RecipeAllergens) GROUP BY r.recipe_name;

-- Recipes with total ingredients + step number
SELECT r.recipe_name, COUNT(DISTINCT ri.ingredient_id) as ingredient_count, COUNT(rs.step_id) AS step_count FROM Recipe r JOIN RecipeIngredients ri ON r.recipe_id = ri.recipe_id JOIN RecipeSteps rs ON r.recipe_id = rs.recipe_id GROUP BY r.recipe_id, r.recipe_name ORDER BY ingredient_count DESC;

-- Total ingredients owned by all users
SELECT i.ingredient_name, SUM(p.quantity) AS total_quantity FROM Ingredient i JOIN Pantry p ON i.ingredient_id = p.ingredient_id GROUP BY i.ingredient_name ORDER BY total_quantity DESC;

-- Ingredient Usage Stats
SELECT i.ingredient_name, COUNT(DISTINCT ri.recipe_id) as recipe_count FROM RecipeIngredients ri JOIN Ingredient i ON ri.ingredient_id = i.ingredient_id GROUP BY i.ingredient_id, i.ingredient_name HAVING COUNT(DISTINCT ri.recipe_id) > 1 ORDER BY recipe_count DESC;

-- User's favorite food tags
SELECT u.username, t.tag_name, COUNT(*) as num_favorited FROM Users u JOIN FavoriteRecipes fr ON u.user_id = fr.user_id JOIN RecipeTags rt ON fr.recipe_id = rt.recipe_id JOIN Tag t ON rt.tag_id = t.tag_id GROUP BY u.username, t.tag_name ORDER BY u.username DESC;
