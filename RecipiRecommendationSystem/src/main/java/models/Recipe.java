package models;

import java.util.Set;

public class Recipe {
    private String name;
    private Set<String> ingredients;
    private int calories;
    private int protein;
    private int fat;
    private int carbs;
    private String cookingTime;
    private String servingSize;
    private String steps;
    private Set<String> missingIngredients; // Optional

    // ✅ Constructor matching the one expected in RecipeServlet
    public Recipe(String name, Set<String> ingredients, int calories, int protein, int fat, int carbs, 
                  String cookingTime, String servingSize, String steps) {
        this.name = name;
        this.ingredients = ingredients;
        this.calories = calories;
        this.protein = protein;
        this.fat = fat;
        this.carbs = carbs;
        this.cookingTime = cookingTime;
        this.servingSize = servingSize;
        this.steps = steps;
        this.missingIngredients = null; // Default to null
    }

    // ✅ Overloaded constructor (if needed)
    public Recipe(String name, Set<String> ingredients, int calories, int protein, int fat, int carbs, 
                  String cookingTime, String servingSize, String steps, Set<String> missingIngredients) {
        this.name = name;
        this.ingredients = ingredients;
        this.calories = calories;
        this.protein = protein;
        this.fat = fat;
        this.carbs = carbs;
        this.cookingTime = cookingTime;
        this.servingSize = servingSize;
        this.steps = steps;
        this.missingIngredients = missingIngredients;
    }

    // Getters
    public String getName() { return name; }
    public Set<String> getIngredients() { return ingredients; }
    public int getCalories() { return calories; }
    public int getProtein() { return protein; }
    public int getFat() { return fat; }
    public int getCarbs() { return carbs; }
    public String getCookingTime() { return cookingTime; }
    public String getServingSize() { return servingSize; }
    public String getSteps() { return steps; }
    public Set<String> getMissingIngredients() { return missingIngredients; }

    // Setter for missingIngredients (if needed)
    public void setMissingIngredients(Set<String> missingIngredients) {
        this.missingIngredients = missingIngredients;
    }
}

