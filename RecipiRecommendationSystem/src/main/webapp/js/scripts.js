// Open Nutrition Popup  
function openNutritionPopup(name, calories, protein, fat, carbs) {
    document.getElementById("nutritionTitle").innerText = `${name} - Nutrition`;
    document.getElementById("nutritionDetails").innerHTML = `
        <b>Calories:</b> ${calories} kcal<br>
        <b>Protein:</b> ${protein}g | <b>Fat:</b> ${fat}g | <b>Carbs:</b> ${carbs}g
    `;

    const modal = document.getElementById("nutritionModal");
    modal.style.display = "flex";

    // Add playful pop-in effect
    modal.querySelector(".modal-content").style.animation = "bounceIn 0.5s ease-out";
}

// Dynamic Tips (with playful fade effect)  
const tips = [
    "Always preheat your pan before cooking meat for better searing!",
    "Add a pinch of salt to enhance sweetness in desserts.",
    "For fluffier rice, let it rest covered for 10 minutes after cooking.",
    "Don’t overcrowd your pan — food browns better with space.",
    "Microwave lemons for 15 seconds to get more juice!",
    "Use the back of a spoon to peel ginger easily."
];

const proTips = [
    "Keep herbs fresh longer by storing them in a glass of water.",
    "Soak onions in cold water to mellow their bite for salads.",
    "For crispy fries, soak cut potatoes in water before frying.",
    "Add vinegar to water when boiling eggs for easier peeling.",
    "Toast spices for deeper, richer flavors."
];

// Tip text animation setup  
let tipIndex = 0;
function cycleTips() {
    const tipText = document.getElementById("tip-text");
    const proTipText = document.getElementById("pro-tip-text");

    // Add fade-out animation  
    tipText.style.opacity = 0;
    proTipText.style.opacity = 0;

    setTimeout(() => {
        tipText.innerText = tips[tipIndex % tips.length];
        proTipText.innerText = proTips[tipIndex % proTips.length];

        // Add fade-in animation  
        tipText.style.opacity = 1;
        proTipText.style.opacity = 1;

        tipIndex++;
    }, 500);
}

// Rotate tips every 4 seconds  
setInterval(cycleTips, 4000);
cycleTips();

// Open Recipe Steps Popup  
function openRecipePopup(name, steps) {
    document.getElementById("recipeTitle").innerText = `${name} - Recipe Steps`;
    document.getElementById("recipeDetails").innerHTML = `<b>Steps:</b><br> ${steps}`;

    const modal = document.getElementById("recipeModal");
    modal.style.display = "flex";

    // Add playful pop-in effect  
    modal.querySelector(".modal-content").style.animation = "bounceIn 0.5s ease-out";
}

// Close Popups (X button or click outside)  
document.addEventListener("DOMContentLoaded", () => {
    const modals = document.querySelectorAll(".modal");
    const closeButtons = document.querySelectorAll(".close");

    // Close modal on button click  
    closeButtons.forEach(btn =>
        btn.addEventListener("click", () => {
            const modal = btn.closest(".modal");
            modal.style.display = "none";
            modal.querySelector(".modal-content").style.animation = "";
        })
    );

    // Close modal when clicking outside  
    window.addEventListener("click", (event) =>
        modals.forEach((modal) => {
            if (event.target === modal) {
                modal.style.display = "none";
                modal.querySelector(".modal-content").style.animation = "";
            }
        })
    );
});

// Scroll animation for recipe cards  
document.addEventListener("DOMContentLoaded", () => {
    const recipeItems = document.querySelectorAll(".recipe-item");

    function revealOnScroll() {
        const triggerBottom = window.innerHeight * 0.85;

        recipeItems.forEach((item) => {
            const itemTop = item.getBoundingClientRect().top;

            if (itemTop < triggerBottom) {
                item.classList.add("reveal");
            }
        });
    }

    window.addEventListener("scroll", revealOnScroll);
    revealOnScroll();
});
document.querySelectorAll('.recipe-item').forEach(item => {
    item.classList.add('reveal');
});
