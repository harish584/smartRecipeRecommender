package controllers;

import models.Recipe;
import java.io.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RecipeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final double MATCH_THRESHOLD = 0.7; // 70% match required

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("RecipeServlet is called...");
 
        // Get user ingredients
        String userIngredients = request.getParameter("ingredients");
        if (userIngredients == null || userIngredients.trim().isEmpty()) {
            request.setAttribute("recipes", Collections.emptyList());
            request.setAttribute("errorMessage", "Please enter ingredients!");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        Set<String> inputIngredients = normalizeIngredients(userIngredients);
        System.out.println("User entered ingredients: " + inputIngredients);

        // Path to CSV file
        String filePath = getServletContext().getRealPath("/WEB-INF/lib/recipes.csv");
        System.out.println("Reading recipes from: " + filePath);

        List<Recipe> matchingRecipes = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            boolean firstLine = true;

            while ((line = br.readLine()) != null) {
                if (firstLine) { // Skip header row
                    firstLine = false;
                    continue;
                }

                String[] data = parseCSVLine(line);
                if (data.length < 9) continue;

                try {
                    String name = data[0].trim();
                    Set<String> ingredients = normalizeIngredients(data[1]);
                    int calories = Integer.parseInt(data[2].trim());
                    int protein = Integer.parseInt(data[3].trim());
                    int fat = Integer.parseInt(data[4].trim());
                    int carbs = Integer.parseInt(data[5].trim());
                    String cookingTime = data[6].trim();
                    String servingSize = data[7].trim();
                    String steps = formatRecipeSteps(data[8].trim());

                    // Calculate match percentage
                    double matchPercentage = calculateMatchPercentage(inputIngredients, ingredients);
                    if (matchPercentage >= MATCH_THRESHOLD) {
                        Recipe recipe = new Recipe(name, ingredients, calories, protein, fat, carbs, cookingTime, servingSize, steps);
                        
                        // Identify missing ingredients
                        Set<String> missingIngredients = new HashSet<>(ingredients);
                        missingIngredients.removeAll(inputIngredients);
                        recipe.setMissingIngredients(missingIngredients);
                        
                        matchingRecipes.add(recipe);
                    }
                } catch (NumberFormatException e) {
                    System.err.println("Skipping invalid numeric data in line: " + line);
                }
            }
        } catch (FileNotFoundException e) {
            System.err.println("Error: Recipe file not found at " + filePath);
            request.setAttribute("errorMessage", "Error: Recipe file not found!");
        } catch (IOException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error reading the recipe file!");
        }

        // Send data to JSP
        request.setAttribute("recipes", matchingRecipes);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    // Normalize ingredients by trimming and converting to lowercase
    private Set<String> normalizeIngredients(String ingredientsStr) {
        Set<String> ingredientsSet = new HashSet<>();
        for (String ingredient : ingredientsStr.toLowerCase().split("[,;]")) {
            ingredient = ingredient.trim().replaceAll("\\s+", " ");
            if (!ingredient.isEmpty()) {
                ingredientsSet.add(ingredient);
            }
        }
        return ingredientsSet;
    }

    // Calculate match percentage between user ingredients and recipe ingredients
    private double calculateMatchPercentage(Set<String> inputIngredients, Set<String> recipeIngredients) {
        int matched = 0;
        for (String recipeIngredient : recipeIngredients) {
            if (inputIngredients.contains(recipeIngredient)) {
                matched++;
            }
        }
        return recipeIngredients.isEmpty() ? 0 : (double) matched / recipeIngredients.size();
    }

    // Format recipe steps for better readability
    private String formatRecipeSteps(String steps) {
        steps = steps.replaceAll("\"", "").trim();
        String[] stepArray = steps.split("\\|\\s*"); // Split at "|"
        StringBuilder formattedSteps = new StringBuilder();
        for (int i = 0; i < stepArray.length; i++) {
            if (!stepArray[i].trim().isEmpty()) {
                formattedSteps.append((i + 1)).append(". ").append(stepArray[i].trim()).append("<br>");
            }
        }
        return formattedSteps.toString();
    }

    // Improved CSV parsing to handle quoted fields correctly
    private String[] parseCSVLine(String line) {
        List<String> values = new ArrayList<>();
        StringBuilder current = new StringBuilder();
        boolean inQuotes = false;

        for (char ch : line.toCharArray()) {
            if (ch == '"') {
                inQuotes = !inQuotes;
            } else if (ch == ',' && !inQuotes) {
                values.add(current.toString().trim());
                current.setLength(0);
            } else {
                current.append(ch);
            }
        }
        values.add(current.toString().trim());
        return values.toArray(new String[0]);
    }
}
