SMART RECIPE RECOMMENDER

This is a basic Java web application that helps users find recipes based on the ingredients they have and provides the nutritional value of the recipe.
 
 What It Does

- Lets users input available ingredients
- Searches a CSV file for matching recipes
- Displays the names of recipes that contain those ingredients
- Provides nutritional value of recipe

 How It Works

- The user enters ingredients in a form (JSP page)
- A Servlet reads the recipe CSV file
- It filters and matches recipes that include the given ingredients
- Matching recipes are shown to the user on the result page

 Tech Stack

- Java (Servlets and JSP)
- HTML & CSS
- Apache Tomcat (local server)
- CSV file for recipe data
