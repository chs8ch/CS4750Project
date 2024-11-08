DROP TABLE IF EXISTS ShoppingList;
DROP TABLE IF EXISTS FavoriteRecipes;
DROP TABLE IF EXISTS Pantry;
DROP TABLE IF EXISTS RecipeAllergens;
DROP TABLE IF EXISTS RecipeTags;
DROP TABLE IF EXISTS RecipeSteps;
DROP TABLE IF EXISTS RecipeIngredients;

DROP TABLE IF EXISTS Allergen;
DROP TABLE IF EXISTS Tag;
DROP TABLE IF EXISTS Step;
DROP TABLE IF EXISTS Ingredient;
DROP TABLE IF EXISTS Recipe;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    user_id int IDENTITY(1, 1) PRIMARY KEY,
    username nvarchar(20) NOT NULL UNIQUE,
    email nvarchar(50) NOT NULL UNIQUE,
    password nvarchar(255) NOT NULL
);

CREATE TABLE Recipe (
    recipe_id int NOT NULL PRIMARY KEY,
    recipe_name nvarchar(100) NOT NULL,
    prep_time int,
    servings int,
    CONSTRAINT CHECK_Recipe_PrepTime CHECK (prep_time > 0),
    CONSTRAINT CHECK_Recipe_Servings CHECK (servings > 0)
);

CREATE TABLE Ingredient (
    ingredient_id int IDENTITY(1, 1) PRIMARY KEY,
    ingredient_name nvarchar(100) NOT NULL,
    measurement_unit nvarchar(20) NOT NULL,
    category nvarchar(30)
);

CREATE TABLE Step (
    step_id int IDENTITY(1, 1) PRIMARY KEY,
    description TEXT NOT NULL
);

CREATE TABLE Tag (
    tag_id int IDENTITY(1, 1) PRIMARY KEY,
    tag_name nvarchar(30) NOT NULL UNIQUE
);

CREATE TABLE Allergen (
    allergen_id int IDENTITY(1, 1) PRIMARY KEY,
    allergen_type nvarchar(30) NOT NULL UNIQUE
);

CREATE TABLE RecipeIngredients (
    recipe_id int NOT NULL,
    ingredient_id int NOT NULL,
    quantity decimal(10,2) NOT NULL,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipe(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(ingredient_id)
);

CREATE TABLE RecipeSteps (
    recipe_id int NOT NULL,
    step_id int NOT NULL,
    step_number int NOT NULL,
    PRIMARY KEY (recipe_id, step_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipe(recipe_id),
    FOREIGN KEY (step_id) REFERENCES Step(step_id),
    CONSTRAINT StepNumber_Constraint UNIQUE (recipe_id, step_number)
);

CREATE TABLE RecipeTags (
    recipe_id int NOT NULL,
    tag_id int NOT NULL,
    PRIMARY KEY (recipe_id, tag_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipe(recipe_id),
    FOREIGN KEY (tag_id) REFERENCES Tag(tag_id)
);

CREATE TABLE RecipeAllergens (
    recipe_id int NOT NULL,
    allergen_id int NOT NULL,
    PRIMARY KEY (recipe_id, allergen_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipe(recipe_id),
    FOREIGN KEY (allergen_id) REFERENCES Allergen(allergen_id)
);

CREATE TABLE Pantry (
    user_id int NOT NULL,
    ingredient_id int NOT NULL,
    PRIMARY KEY (user_id, ingredient_id),
    quantity decimal(10,2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(ingredient_id),
    CONSTRAINT Pantry_Constraint UNIQUE (user_id, ingredient_id)
);

CREATE TABLE FavoriteRecipes (
    user_id int NOT NULL,
    recipe_id int NOT NULL,
    PRIMARY KEY (user_id, recipe_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipe(recipe_id)
);

CREATE TABLE ShoppingList (
    user_id int NOT NULL,
    ingredient_id int NOT NULL,
    quantity decimal(10,2) NOT NULL,
    PRIMARY KEY (user_id, ingredient_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(ingredient_id)
);