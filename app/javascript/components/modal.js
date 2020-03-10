export const initModalPopup = () => {
	const drinkModalEl = document.querySelector('.js-drink-modal');
	if (!drinkModalEl){
		return;
	}

	const drinkNameEl = drinkModalEl.querySelector('.js-drink-name');
	const drinkStoreEl = drinkModalEl.querySelector('.js-drink-store');
	const drinkPriceEl = drinkModalEl.querySelector('.js-drink-price');
	const drinkAbvEl = drinkModalEl.querySelector('.js-drink-abv');
	
	const carouselItemEls = document.querySelectorAll('.js-drink-carousel-item');

	carouselItemEls.forEach((carouselItemEl) => {
		carouselItemEl.addEventListener("click", () => {
			drinkNameEl.innerText = carouselItemEl.dataset.drinkName
			drinkStoreEl.innerText = carouselItemEl.dataset.drinkStore
			drinkPriceEl.innerText = carouselItemEl.dataset.drinkPrice
			drinkAbvEl.innerText = carouselItemEl.dataset.drinkAbv
		});
	});

};
