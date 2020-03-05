import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('store-location');
  if (addressInput) {
    var placesAutocomplete = places({
      appId: 'pl6MOBGWO5K2',
      apiKey: '1ab7507646816c1fa69ea8a9b3065f0b',
      container: document.querySelector('#store-location'),
      useDeviceLocation: true
    });
    placesAutocomplete.search();
    placesAutocomplete.on('change', e => console.log(e.suggestion));
    
    }
};

export { initAutocomplete };