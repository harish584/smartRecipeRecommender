<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nutrition Calculator</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: url('images/background.webp') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background: rgba(255, 255, 255, 0.9);
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            width: 420px;
            text-align: center;
        }
        
        h2 {
            color: #333;
        }

        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }

        /* Flex row styling for ingredient pairs */
        .ingredient-row {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: 10px;
        }

        /* Adjust input size for side layout */
        .ingredient-row input {
            width: 48%;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        button {
            background: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-bottom: 10px;
        }

        button:hover {
            background: #45a049;
        }

        .back-btn {
            background: #d9534f;
        }

        .back-btn:hover {
            background: #c9302c;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>Nutrition Calculator</h2>
        <form action="CalculateNutritionServlet" method="post">
            <div id="ingredients-container">
                <!-- First ingredient row -->
                <div class="ingredient-row">
                    <input type="text" name="ingredient" placeholder="e.g. Rice, Chicken" required>
                    <input type="number" name="quantity" placeholder="e.g. 100 (grams)" required>
                </div>
            </div>

            <!-- Button to add more ingredients -->
            <button type="button" onclick="addIngredient()">+ Add More Ingredients</button>

            <!-- Calculate nutrition button -->
            <button type="submit">Calculate Nutrition</button>
        </form>

        <!-- Back button to homepage -->
        <button class="back-btn" onclick="window.location.href='index.jsp'">Back to Home</button>
    </div>

    <script>
        function addIngredient() {
            const container = document.getElementById("ingredients-container");
            const newIngredientRow = `
                <div class="ingredient-row">
                    <input type="text" name="ingredient" placeholder="e.g. Rice, Chicken" required>
                    <input type="number" name="quantity" placeholder="e.g. 100 (grams)" required>
                </div>
            `;
            container.insertAdjacentHTML("beforeend", newIngredientRow);
        }
    </script>
</body>
</html>
