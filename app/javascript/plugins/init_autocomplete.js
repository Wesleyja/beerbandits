import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('store-location');
  if (addressInput) {
    var placesAutocomplete = places({
      appId: 'plIMCSCGWUV1',
      apiKey: '4927a1ed0b882fcd4be6fc0a6a281f41',
      container: document.querySelector('#store-location'),
      useDeviceLocation: true
    });
    placesAutocomplete.search();
    placesAutocomplete.on('change', e => console.log(e.suggestion));

    }
};

export { initAutocomplete };
