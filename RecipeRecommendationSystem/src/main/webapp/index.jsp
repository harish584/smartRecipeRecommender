<%@ page import="java.util.List" %>
<%@ page import="models.Recipe" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recipe Recommendation</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        /* General page styling */
        body {
    		font-family: 'Arial', sans-serif;
    		background: url('images/background.webp') no-repeat center center/cover;
    		display: flex;
    		justify-content: center;
    		align-items: flex-start; /* Changed from center */
    		min-height: 100vh; /* Changed from height: 100vh */
    		margin: 0;
		}
		.tips-section {
    		background: rgba(0, 0, 0, 0.7);
    		color: #fff;
    		padding: 20px;
   			border-radius: 10px;
    		width: 300px;
    		position: absolute;
    		top: 20%;
    		right: 10%;
    		transform: translateY(-50%);
    		text-align: center;
   			box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
		}
		.tips-left {
    		left: 10%;
		}

		.tips-section h2 {
    		color: #ff7043;
    		margin-bottom: 10px;
    		font-size: 24px;
		}

		.tips-section p {
    		font-size: 16px;
    		line-height: 1.4;
		}
		

		.container {
    		background: rgba(0, 0, 0, 0.8);
    		padding: 30px;
    		border-radius: 15px;
    		box-shadow: 0 5px 20px rgba(0, 0, 0, 0.6);
    		width: 450px;
    		color: #fff;
    		text-align: center;
    		margin-top: 120px;
    		margin-bottom: 20px; /* Added to avoid cut-off */
		}

        h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            color: #ff6347;
            letter-spacing: 2px;
        }

        /* Input and form styling */
        input[type="text"] {
            width: 80%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            margin-bottom: 15px;
            font-size: 16px;
            text-align: center;
        }

        button {
            background: #4CAF50;
            color: white;
            padding: 12px;
            border: none;
            width: 80%;
            border-radius: 8px;
            margin: 10px auto;
            font-size: 18px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background: #45a049;
        }

        /* Alternate button style */
        .nutrition-calc-btn {
            background: #3498db;
        }

        .nutrition-calc-btn:hover {
            background: #2980b9;
        }

        .error-message {
            color: #ff4c4c;
            font-weight: bold;
            text-align: center;
            right: 10px;
        }

        /* Recipe container updated for 2 rows & 2 columns */
        .recipes-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-template-rows: repeat(2, auto);
            gap: 15px;
            margin-top: 20px;
            justify-content: center;
        }

        /* Each recipe card styling improved for grid layout */
        .recipe-item {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.5);
            transition: transform 0.3s ease;
            text-align: center;
        }

        /* Hover animation for smooth interaction */
        .recipe-item:hover {
            transform: scale(1.05);
        }

        /* Modal styling */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            width: 60%;
            text-align: center;
            color: #333;
        }

        .close {
            position: absolute;
            top: 10px;
            right: 20px;
            font-size: 20px;
            cursor: pointer;
            font-weight: bold;
            color: #333;
        }

        .close:hover {
            color: #ff4c4c;
        }

        /* Responsive layout for smaller screens */
        @media (max-width: 600px) {
            .recipes-container {
                grid-template-columns: 1fr;
                grid-template-rows: auto;
            }

            .container {
                width: 90%;
            }
        }
    </style>
</head>

<body>

    <div class="container">
        <div class="tips-section">
    <h2>Quick Tips</h2>
    <p id="tip-text"></p> <!-- No static content -->
</div>

<div class="tips-section tips-left">
    <h2>Pro Tips</h2>
    <p id="pro-tip-text"></p> <!-- No static content -->
</div>
		
			
        <h1>Recipe Recommendation System</h1>

        <!-- Nutrition Calculator Button -->
        <button class="nutrition-calc-btn" onclick="window.location.href='nutrition-calculator.jsp'">
            Nutrition Calculator
        </button>

        <!-- Ingredients input form -->
        <form action="RecipeServlet" method="GET">
            <input type="text" name="ingredients" placeholder="Enter ingredients - separate using commas...">
            <button type="submit">Find Recipes</button>
        </form>
        	<% 	List<Recipe> recipes = (List<Recipe>) request.getAttribute("recipes");
                String errorMessage = (String) request.getAttribute("errorMessage");
            %>
        <!-- Error message now properly placed after the form -->
		<% if (errorMessage != null) { %>
    		<p class="error-message"><%= errorMessage %></p>
		<% } %>
        <!-- Recipe Results Section -->
        <div class="recipes-container">
            <% 
            	if (recipes != null && !recipes.isEmpty()) { 
                    for (Recipe recipe : recipes) { 
            %>
                <div class="recipe-item">
                    <h3><%= recipe.getName() %></h3>

                    <!-- View Nutrition Button -->
                    <button class="nutrition-btn" 
                        onclick="openNutritionPopup(
                            '<%= recipe.getName() %>', 
                            '<%= recipe.getCalories() %>', 
                            '<%= recipe.getProtein() %>', 
                            '<%= recipe.getFat() %>', 
                            '<%= recipe.getCarbs() %>')">
                        View Nutrition
                    </button>

                    <!-- View Recipe Button -->
                    <button class="steps-btn" 
                        onclick="openRecipePopup(
                            '<%= recipe.getName() %>', 
                            `<%= recipe.getSteps().replace("\n", "<br>") %>`)">
                        View Recipe
                    </button>
                </div>
            <% 
                    }
                } 
               	else { 
    		%> 		<p class="error-message">No Recipes Found!</p>
			<% } %>
            
        </div>
    </div>

    <!-- Nutrition Modal -->
    <div id="nutritionModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closePopup('nutritionModal')">&times;</span>
            <h2 id="nutritionTitle"></h2>
            <p id="nutritionDetails"></p>
        </div>
    </div>

    <!-- Recipe Modal -->
    <div id="recipeModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closePopup('recipeModal')">&times;</span>
            <h2 id="recipeTitle"></h2>
            <p id="recipeDetails"></p>
        </div>
    </div>

    <script src="js/scripts.js"></script>
</body>
</html>
