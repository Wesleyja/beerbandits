export const initModalPopup = () => {
	const drinkModalEl = document.querySelector('.js-drink-modal');
	if (!drinkModalEl){
		return;
	}

	const drinkNameEl = drinkModalEl.querySelector('.js-drink-name');
	const drinkStoreEl = drinkModalEl.querySelector('.js-drink-store');
	const drinkPriceEl = drinkModalEl.querySelector('.js-drink-price');
	const drinkAbvEl = drinkModalEl.querySelector('.js-drink-abv');
  const drinkDistanceEl = drinkModalEl.querySelector('.js-drink-distance');
  const drinkDistanceTimeEl = drinkModalEl.querySelector('.js-drink-distance-time');
  const drinkStandardsEl = drinkModalEl.querySelector('.js-drink-standards');
  const drinkMapsEl = drinkModalEl.querySelector('.js-drink-maps');



  const attachListenersToCarouselItems = () => {
  	const carouselItemEls = document.querySelectorAll('.js-drink-carousel-item');

  	carouselItemEls.forEach((carouselItemEl) => {
  		carouselItemEl.addEventListener("click", () => {
  			drinkNameEl.innerText = carouselItemEl.dataset.drinkName
  			drinkStoreEl.innerText = carouselItemEl.dataset.drinkStore
  			drinkPriceEl.innerText = carouselItemEl.dataset.drinkPrice
  			drinkAbvEl.innerText = carouselItemEl.dataset.drinkAbv
        drinkDistanceEl.innerText = carouselItemEl.dataset.drinkDistance
        drinkDistanceTimeEl.innerText = carouselItemEl.dataset.drinkDistanceTime
        drinkStandardsEl.innerText = carouselItemEl.dataset.drinkStandards
        drinkMapsEl.setAttribute("href", carouselItemEl.dataset.drinkMaps)
  		});
  	});
  };
  attachListenersToCarouselItems();
  window.attachListenersToCarouselItems = attachListenersToCarouselItems;
}
