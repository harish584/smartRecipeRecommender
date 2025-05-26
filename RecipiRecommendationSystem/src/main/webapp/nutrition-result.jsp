<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nutrition Results</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: url('images/background.webp') no-repeat center center/cover; /* Same background */
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
            width: 320px;
            text-align: center;
        }
        

        h2 {
            color: #333;
            margin-bottom: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #4CAF50;
            color: white;
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
        <h2>Nutrition Breakdown</h2>
        <table>
            <tr><th>Calories</th><td>${calories} kcal</td></tr>
            <tr><th>Protein</th><td>${protein} g</td></tr>
            <tr><th>Carbs</th><td>${carbs} g</td></tr>
            <tr><th>Fats</th><td>${fats} g</td></tr>
        </table>

        <!-- Calculate Again button -->
        <button onclick="window.location.href='nutrition-calculator.jsp'">Calculate Again</button>

        <!-- Back to homepage button -->
        <button class="back-btn" onclick="window.location.href='index.jsp'">Back to Home</button>
    </div>
</body>
</html>
