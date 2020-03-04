const drinksCheckbox = document.querySelectorAll('.clickable-card');

const toggleActiveClass = (event) => {
  event.currentTarget.classList.toggle('active');
};

const toggleActiveOnClick = (drink) => {
  drink.addEventListener('click', toggleActiveClass);
};

drinksCheckbox.forEach(toggleActiveOnClick);

export { toggleActiveOnClick };