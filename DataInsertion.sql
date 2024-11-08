-- Import Ingredient
BULK INSERT Ingredient
FROM '.\data\Ingredient.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Import Step
BULK INSERT Step
FROM '.\data\Step.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Import Tag
BULK INSERT Tag
FROM '.\data\Tag.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Import Allergen
BULK INSERT Allergen
FROM '.\data\Allergen.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Import RecipeIngredients
BULK INSERT RecipeIngredients
FROM '.\data\RecipeIngredients.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Import RecipeSteps
BULK INSERT RecipeSteps
FROM '.\data\RecipeSteps.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Import RecipeTags
BULK INSERT RecipeTags
FROM '.\data\RecipeTags.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Import RecipeAllergens
BULK INSERT RecipeAllergens
FROM '.\data\RecipeAllergens.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

--Manual Insert User
INSERT INTO Users (username, email, password) VALUES ('chef_master', 'chef_master@example.com', 'hashed_password_1');
INSERT INTO Users (username, email, password) VALUES ('foodie123', 'foodie123@example.com', 'hashed_password_2');
INSERT INTO Users (username, email, password) VALUES ('spicy_lover', 'spicy_lover@example.com', 'hashed_password_3');
INSERT INTO Users (username, email, password) VALUES ('vegan_vibes', 'vegan_vibes@example.com', 'hashed_password_4');
INSERT INTO Users (username, email, password) VALUES ('pasta_queen', 'pasta_queen@example.com', 'hashed_password_5');
INSERT INTO Users (username, email, password) VALUES ('salad_king', 'salad_king@example.com', 'hashed_password_6');
INSERT INTO Users (username, email, password) VALUES ('grill_guru', 'grill_guru@example.com', 'hashed_password_7');
INSERT INTO Users (username, email, password) VALUES ('soup_savant', 'soup_savant@example.com', 'hashed_password_8');
INSERT INTO Users (username, email, password) VALUES ('dessert_diva', 'dessert_diva@example.com', 'hashed_password_9');
INSERT INTO Users (username, email, password) VALUES ('healthy_hiker', 'healthy_hiker@example.com', 'hashed_password_10');
INSERT INTO Users (username, email, password) VALUES ('taco_titan', 'taco_titan@example.com', 'hashed_password_11');
INSERT INTO Users (username, email, password) VALUES ('noodles_ninja', 'noodles_ninja@example.com', 'hashed_password_12');
INSERT INTO Users (username, email, password) VALUES ('curry_connoisseur', 'curry_connoisseur@example.com', 'hashed_password_13');
INSERT INTO Users (username, email, password) VALUES ('smoothie_star', 'smoothie_star@example.com', 'hashed_password_14');
INSERT INTO Users (username, email, password) VALUES ('baking_boss', 'baking_boss@example.com', 'hashed_password_15');
INSERT INTO Users (username, email, password) VALUES ('quick_meals', 'quick_meals@example.com', 'hashed_password_16');
INSERT INTO Users (username, email, password) VALUES ('snack_sensei', 'snack_sensei@example.com', 'hashed_password_17');
INSERT INTO Users (username, email, password) VALUES ('protein_pro', 'protein_pro@example.com', 'hashed_password_18');
INSERT INTO Users (username, email, password) VALUES ('veggie_voyager', 'veggie_voyager@example.com', 'hashed_password_19');
INSERT INTO Users (username, email, password) VALUES ('gourmet_gal', 'gourmet_gal@example.com', 'hashed_password_20');
INSERT INTO Users (username, email, password) VALUES ('budget_bites', 'budget_bites@example.com', 'hashed_password_21');
INSERT INTO Users (username, email, password) VALUES ('meal_prepper', 'meal_prepper@example.com', 'hashed_password_22');
INSERT INTO Users (username, email, password) VALUES ('plant_based', 'plant_based@example.com', 'hashed_password_23');
INSERT INTO Users (username, email, password) VALUES ('meat_feaster', 'meat_feaster@example.com', 'hashed_password_24');
INSERT INTO Users (username, email, password) VALUES ('choco_addict', 'choco_addict@example.com', 'hashed_password_25');
INSERT INTO Users (username, email, password) VALUES ('gluten_free_gal', 'gluten_free_gal@example.com', 'hashed_password_26');
INSERT INTO Users (username, email, password) VALUES ('spoon_samurai', 'spoon_samurai@example.com', 'hashed_password_27');
INSERT INTO Users (username, email, password) VALUES ('home_cook', 'home_cook@example.com', 'hashed_password_28');
INSERT INTO Users (username, email, password) VALUES ('breakfast_bae', 'breakfast_bae@example.com', 'hashed_password_29');
INSERT INTO Users (username, email, password) VALUES ('dinner_dynamo', 'dinner_dynamo@example.com', 'hashed_password_30');
INSERT INTO Users (username, email, password) VALUES ('lunch_lady', 'lunch_lady@example.com', 'hashed_password_31');
INSERT INTO Users (username, email, password) VALUES ('flavor_finder', 'flavor_finder@example.com', 'hashed_password_32');
INSERT INTO Users (username, email, password) VALUES ('pizza_pal', 'pizza_pal@example.com', 'hashed_password_33');
INSERT INTO Users (username, email, password) VALUES ('sushi_senpai', 'sushi_senpai@example.com', 'hashed_password_34');
INSERT INTO Users (username, email, password) VALUES ('sous_chef', 'sous_chef@example.com', 'hashed_password_35');

--Manual Insert Pantry
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 1), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 123), 5.50);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 1), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 234), 2.00);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 1), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 345), 1.00);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 2), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 456), 3.75);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 2), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 567), 2.25);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 3), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 178), 4.00);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 3), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 289), 1.50);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 4), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 390), 2.00);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 5), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 432), 3.00);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 5), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 543), 1.75);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 6), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 156), 4.25);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 7), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 267), 2.50);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 8), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 378), 1.25);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 9), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 489), 3.50);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 10), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 590), 2.75);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 11), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 167), 4.50);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 12), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 278), 1.75);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 13), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 389), 3.25);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 14), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 490), 2.00);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 15), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 123), 5.00);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 16), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 234), 3.50);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 17), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 345), 2.25);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 18), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 456), 4.75);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 19), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 567), 1.50);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 20), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 178), 3.25);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 21), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 289), 2.50);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 22), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 390), 4.00);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 23), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 432), 1.75);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 24), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 543), 3.50);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 25), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 156), 2.25);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 26), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 267), 4.50);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 27), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 378), 1.25);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 28), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 489), 3.75);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 29), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 590), 2.00);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 30), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 167), 5.25);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 31), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 278), 1.50);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 32), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 389), 3.75);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 33), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 490), 2.25);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 34), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 123), 4.50);
INSERT INTO Pantry (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 35), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 234), 1.75);

--Manual Insert Recipe
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (1, 'Slow Cooker Chicken and Dumplings', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (2, 'Awesome Slow Cooker Pot Roast', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (3, 'Brown Sugar Meatloaf', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (4, 'Best Chocolate Chip Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (5, 'Homemade Mac and Cheese Casserole', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (6, 'Banana Banana Bread', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (7, 'Chef John''s Fisherman''s Pie', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (8, 'Mom''s Zucchini Bread', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (9, 'The Best Rolled Sugar Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (10, 'Singapore Chili Crabs', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (11, 'Downeast Maine Pumpkin Bread', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (12, 'Best Big, Fat, Chewy Chocolate Chip Cookie', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (13, 'Aimee''s Mashed Cauliflower ''Potatoes''', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (14, 'Irish Lamb Stew', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (15, 'To Die For Blueberry Muffins', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (16, 'Broiled Tilapia Parmesan', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (17, 'Award Winning Soft Chocolate Chip Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (18, 'World''s Best Lasagna', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (19, 'Best Brownies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (20, 'Irish Soda Bread', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (21, 'Delicious Ham and Potato Soup', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (22, 'Chicken Pot Pie IX', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (23, 'Fluffy Pancakes', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (24, 'Good Old Fashioned Pancakes', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (25, 'Banana Crumb Muffins', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (26, 'Bailey''s Irish Cream Brownies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (27, 'Apple Pie by Grandma Ople', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (28, 'Easy Irish Colcannon', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (29, 'Ang''s Balsamic Maple Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (30, 'Zesty Slow Cooker Chicken Barbecue', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (31, 'Chicken Cordon Bleu II', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (32, 'Chantal''s New York Cheesecake', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (33, 'Baked Teriyaki Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (34, 'Guacamole', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (35, 'Boilermaker Tailgate Chili', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (36, 'Baked Pork Chops I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (37, 'Easy Sugar Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (38, 'Slow Cooker Chicken Taco Soup', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (39, 'Grandmother''s Buttermilk Cornbread', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (40, 'Baked Ziti I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (41, 'Janet''s Rich Banana Bread', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (42, 'Big Soft Ginger Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (43, 'Mrs. Sigg''s Snickerdoodles', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (44, 'Taco Seasoning I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (45, 'Sloppy Joes II', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (46, 'Clone of a Cinnabon', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (47, 'Too Much Chocolate Cake', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (48, 'Carrot Cake III', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (49, 'Apple Crisp II', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (50, 'Amish White Bread', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (51, 'Creamy Au Gratin Potatoes', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (52, 'Garlic Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (53, 'Grilled Salmon I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (54, 'Buffalo Chicken Dip', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (55, 'Salsa Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (56, 'Quick and Easy Alfredo Sauce', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (57, 'Chewy Chocolate Chip Oatmeal Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (58, 'Chicken Marsala', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (59, 'Slow-Cooker Chicken Tortilla Soup', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (60, 'Creamy Rice Pudding', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (61, 'Banana Sour Cream Bread', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (62, 'Quinoa and Black Beans', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (63, 'Easy Meatloaf', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (64, 'Annie''s Fruit Salsa and Cinnamon Chips', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (65, 'Chicken Enchiladas II', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (66, 'Slow Cooker Pulled Pork', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (67, 'Cream Cheese Frosting II', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (68, 'Beth''s Spicy Oatmeal Raisin Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (69, 'Maple Salmon', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (70, 'Slow Cooker Beef Stew I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (71, 'Brooke''s Best Bombshell Brownies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (72, 'Fluffy French Toast', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (73, 'Slow Cooker Beef Stroganoff I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (74, 'Soft Oatmeal Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (75, 'Roast Sticky Chicken-Rotisserie Style', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (76, 'Salisbury Steak', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (77, 'Braised Balsamic Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (78, 'Jamie''s Cranberry Spinach Salad', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (79, 'Mouth-Watering Stuffed Mushrooms', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (80, 'Rosemary Ranch Chicken Kabobs', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (81, 'J.P.''s Big Daddy Biscuits', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (82, 'Slow Cooker Chicken Stroganoff', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (83, 'Easy Slow Cooker French Dip', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (84, 'Peanut Butter Cup Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (85, 'Iced Pumpkin Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (86, 'Burrito Pie', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (87, 'Sweet, Sticky and Spicy Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (88, 'Jay''s Signature Pizza Crust', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (89, 'Angel Chicken Pasta', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (90, 'Jalapeno Popper Spread', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (91, 'Buttermilk Pancakes II', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (92, 'Chocolate Chocolate Chip Cookies I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (93, 'Bow Ties with Sausage, Tomatoes and Cream', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (94, 'Roasted Brussels Sprouts', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (95, 'Waffles I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (96, 'Alfredo Sauce', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (97, 'Restaurant-Style Buffalo Chicken Wings', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (98, 'Sugar Cookie Icing', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (99, 'Meatball Nirvana', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (100, 'Double Layer Pumpkin Cheesecake', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (101, 'Awesome and Easy Creamy Corn Casserole', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (102, 'Chuck''s Favorite Mac and Cheese', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (103, 'Italian Spaghetti Sauce with Meatballs', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (104, 'BBQ Pork for Sandwiches', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (105, 'Eggplant Parmesan II', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (106, 'Curried Coconut Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (107, 'Simple White Cake', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (108, 'Banana Muffins II', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (109, 'Marinated Grilled Shrimp', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (110, 'Chicken Breasts with Balsamic Vinegar and Garlic', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (111, 'Country Apple Dumplings', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (112, 'Slow-Cooker Pepper Steak', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (113, 'Anniversary Chicken I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (114, 'Best Steak Marinade in Existence', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (115, 'Key Lime Pie VII', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (116, 'Debdoozie''s Blue Ribbon Chili', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (117, 'Double Tomato Bruschetta', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (118, 'Basic Crepes', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (119, 'Bread Pudding II', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (120, 'Famous Butter Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (121, 'White Chocolate Raspberry Cheesecake', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (122, 'Yummy Sweet Potato Casserole', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (123, 'Baked Dijon Salmon', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (124, 'Amazing Pork Tenderloin in the Slow Cooker', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (125, 'Banana Pudding IV', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (126, 'Fresh Southern Peach Cobbler', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (127, 'Ultimate Twice Baked Potatoes', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (128, 'Homemade Black Bean Veggie Burgers', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (129, 'Best Bread Machine Bread', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (130, 'Easy OREO Truffles', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (131, 'Szechwan Shrimp', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (132, 'Baked Salmon II', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (133, 'Grandma''s Green Bean Casserole', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (134, 'Shepherd''s Pie VI', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (135, 'Zucchini Brownies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (136, 'Spicy Garlic Lime Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (137, 'Awesome Sausage, Apple and Cranberry Stuffing', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (138, 'It''s Chili by George!!', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (139, 'Juicy Roasted Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (140, 'Artichoke & Spinach Dip Restaurant Style', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (141, 'Baked Garlic Parmesan Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (142, 'Rempel Family Meatloaf', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (143, 'Sweet Restaurant Slaw', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (144, 'Sweet Dinner Rolls', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (145, 'Italian Sausage Soup', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (146, 'Classic Peanut Butter Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (147, 'Aussie Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (148, 'Garlic Cheddar Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (149, 'Butternut Squash Soup', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (150, 'Yummy Honey Chicken Kabobs', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (151, 'Pizza Dough I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (152, 'Pumpkin Pancakes', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (153, 'Beef Stew VI', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (154, 'Marinated Baked Pork Chops', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (155, 'Chicken Enchiladas I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (156, 'Perfect Pumpkin Pie', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (157, 'Mexican Rice II', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (158, 'One Bowl Chocolate Cake III', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (159, 'Chicken Tikka Masala', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (160, 'Roasted Garlic Cauliflower', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (161, 'Cajun Chicken Pasta', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (162, 'Strawberry Spinach Salad I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (163, 'Stuffed Green Peppers I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (164, 'Hot Artichoke and Spinach Dip II', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (165, 'Peanut Butter Bars I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (166, 'Quick and Easy Pizza Crust', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (167, 'Baked Honey Mustard Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (168, 'Quick and Easy Chicken Noodle Soup', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (169, 'Golden Sweet Cornbread', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (170, 'American Lasagna', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (171, 'Broccoli Cheese Soup', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (172, 'Artichoke Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (173, 'Blueberry Zucchini Bread', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (174, 'Hamburger Steak with Onions and Gravy', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (175, 'Sam''s Famous Carrot Cake', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (176, 'Oatmeal Peanut Butter Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (177, 'Black Magic Cake', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (178, 'Flourless Peanut Butter Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (179, 'Seven Layer Taco Dip', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (180, 'Ginger Glazed Mahi Mahi', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (181, 'Gourmet Mushroom Risotto', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (182, 'Sweet Potato Pie I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (183, 'Creamy Chicken and Wild Rice Soup', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (184, 'Grandma Ople''s Apple Pie', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (185, 'Sarah''s Applesauce', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (186, 'Angela''s Awesome Enchiladas', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (187, 'Chicken Florentine Casserole', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (188, 'Addictive Sweet Potato Burritos', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (189, 'Exquisite Pizza Sauce', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (190, 'Super-Delicious Zuppa Toscana', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (191, 'Brown Sugar Smokies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (192, 'Donut Muffins', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (193, 'Lime Chicken Soft Tacos', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (194, 'Fish Tacos', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (195, 'Caramelized Baked Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (196, 'Pecan Pie V', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (197, 'Slow Cooker Italian Beef for Sandwiches', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (198, 'Slow Cooker Buffalo Chicken Sandwiches', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (199, 'Chicken Milano', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (200, 'Classic Waffles', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (201, 'Cheesy Ham and Hash Brown Casserole', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (202, 'Grandma Johnson''s Scones', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (203, 'Baked Asparagus with Balsamic Butter Sauce', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (204, 'Honey Mustard Grilled Chicken', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (205, 'Beef Stroganoff III', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (206, 'Mini Meatloaves', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (207, 'Shrimp Scampi Bake', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (208, 'Best Spanish Rice', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (209, 'Crustless Spinach Quiche', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (210, 'Homesteader Cornbread', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (211, 'Jamie''s Minestrone', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (212, 'The Best Lemon Bars', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (213, 'Cake Balls', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (214, 'Outrageous Chocolate Chip Cookies', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (215, 'Chicken Cordon Bleu I', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (216, 'Best Lemonade Ever', NULL, NULL);
INSERT INTO Recipe (recipe_id, recipe_name, prep_time, servings) VALUES (217, 'Baked Kale Chips', NULL, NULL);

--Manual Insert Favorite Recipes
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 1), (SELECT recipe_id FROM Recipe WHERE recipe_id = 18));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 1), (SELECT recipe_id FROM Recipe WHERE recipe_id = 159));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 2), (SELECT recipe_id FROM Recipe WHERE recipe_id = 4));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 3), (SELECT recipe_id FROM Recipe WHERE recipe_id = 120));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 4), (SELECT recipe_id FROM Recipe WHERE recipe_id = 27));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 5), (SELECT recipe_id FROM Recipe WHERE recipe_id = 35));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 6), (SELECT recipe_id FROM Recipe WHERE recipe_id = 181));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 7), (SELECT recipe_id FROM Recipe WHERE recipe_id = 149));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 8), (SELECT recipe_id FROM Recipe WHERE recipe_id = 69));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 9), (SELECT recipe_id FROM Recipe WHERE recipe_id = 217));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 10), (SELECT recipe_id FROM Recipe WHERE recipe_id = 54));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 11), (SELECT recipe_id FROM Recipe WHERE recipe_id = 121));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 12), (SELECT recipe_id FROM Recipe WHERE recipe_id = 128));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 13), (SELECT recipe_id FROM Recipe WHERE recipe_id = 139));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 14), (SELECT recipe_id FROM Recipe WHERE recipe_id = 156));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 15), (SELECT recipe_id FROM Recipe WHERE recipe_id = 190));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 16), (SELECT recipe_id FROM Recipe WHERE recipe_id = 46));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 17), (SELECT recipe_id FROM Recipe WHERE recipe_id = 115));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 18), (SELECT recipe_id FROM Recipe WHERE recipe_id = 183));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 19), (SELECT recipe_id FROM Recipe WHERE recipe_id = 66));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 20), (SELECT recipe_id FROM Recipe WHERE recipe_id = 162));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 21), (SELECT recipe_id FROM Recipe WHERE recipe_id = 34));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 22), (SELECT recipe_id FROM Recipe WHERE recipe_id = 177));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 23), (SELECT recipe_id FROM Recipe WHERE recipe_id = 136));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 24), (SELECT recipe_id FROM Recipe WHERE recipe_id = 194));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 25), (SELECT recipe_id FROM Recipe WHERE recipe_id = 171));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 26), (SELECT recipe_id FROM Recipe WHERE recipe_id = 180));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 27), (SELECT recipe_id FROM Recipe WHERE recipe_id = 140));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 28), (SELECT recipe_id FROM Recipe WHERE recipe_id = 203));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 29), (SELECT recipe_id FROM Recipe WHERE recipe_id = 15));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 30), (SELECT recipe_id FROM Recipe WHERE recipe_id = 93));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 31), (SELECT recipe_id FROM Recipe WHERE recipe_id = 160));
INSERT INTO FavoriteRecipes (user_id, recipe_id) VALUES ((SELECT user_id FROM Users WHERE user_id = 32), (SELECT recipe_id FROM Recipe WHERE recipe_id = 216));

--Manual Insert Shopping List
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 1), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 45), 2.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 1), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 123), 1.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 2), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 234), 3.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 3), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 567), 1.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 4), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 89), 2.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 5), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 432), 4.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 6), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 156), 1.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 7), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 378), 2.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 8), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 245), 1.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 9), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 590), 3.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 10), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 167), 2.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 11), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 445), 1.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 12), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 289), 4.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 13), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 534), 2.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 14), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 178), 1.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 15), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 623), 3.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 16), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 345), 2.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 17), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 456), 1.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 18), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 278), 4.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 19), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 567), 2.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 20), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 189), 1.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 21), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 678), 3.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 22), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 234), 2.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 23), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 445), 1.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 24), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 167), 4.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 25), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 589), 2.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 26), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 123), 1.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 27), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 456), 3.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 28), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 278), 2.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 29), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 345), 1.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 30), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 590), 4.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 31), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 178), 2.00);
INSERT INTO ShoppingList (user_id, ingredient_id, quantity) VALUES ((SELECT user_id FROM Users WHERE user_id = 32), (SELECT ingredient_id FROM Ingredient WHERE ingredient_id = 623), 1.00);