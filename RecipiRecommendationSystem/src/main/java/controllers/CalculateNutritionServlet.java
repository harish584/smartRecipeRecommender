package controllers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CalculateNutritionServlet")
public class CalculateNutritionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ingredients = request.getParameterValues("ingredient");
        String[] quantities = request.getParameterValues("quantity");

        double totalCalories = 0, totalProtein = 0, totalCarbs = 0, totalFats = 0;

        // Simulated nutrition data (can be replaced with a database or API)
        for (int i = 0; i < ingredients.length; i++) {
            String ingredient = ingredients[i].toLowerCase();
            int quantity = Integer.parseInt(quantities[i]);

            switch (ingredient) {
                case "rice":
                    totalCalories += 130 * (quantity / 100.0);
                    totalProtein += 2.7 * (quantity / 100.0);
                    totalCarbs += 28 * (quantity / 100.0);
                    totalFats += 0.3 * (quantity / 100.0);
                    break;

                case "chicken":
                    totalCalories += 165 * (quantity / 100.0);
                    totalProtein += 31 * (quantity / 100.0);
                    totalCarbs += 0 * (quantity / 100.0);
                    totalFats += 3.6 * (quantity / 100.0);
                    break;

                // Add more ingredients here

                default:
                    totalCalories += 50 * (quantity / 100.0);
                    totalProtein += 1 * (quantity / 100.0);
                    totalCarbs += 10 * (quantity / 100.0);
                    totalFats += 0.5 * (quantity / 100.0);
                    break;
            }
        }

        request.setAttribute("calories", totalCalories);
        request.setAttribute("protein", totalProtein);
        request.setAttribute("carbs", totalCarbs);
        request.setAttribute("fats", totalFats);

        request.getRequestDispatcher("nutrition-result.jsp").forward(request, response);
    }
}
