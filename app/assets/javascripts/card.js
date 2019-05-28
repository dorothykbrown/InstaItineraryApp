
const cards = document.querySelectorAll(".card-category");
const toggleActiveClass = event => event.currentTarget.classList.toggle("active");
const toggleActiveOnClick = card => card.addEventListener("click", toggleActiveClass);
cards.forEach(card => toggleActiveOnClick(card));
