import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('store-location');
  if (addressInput) {
    var placesAutocomplete = places({
      appId: 'pl6MOBGWO5K2',
      apiKey: '75f7e43a6f2956e8f744723f36216e95',
      container: document.querySelector('#store-location'),
      useDeviceLocation: true
    });
    placesAutocomplete.search();
    placesAutocomplete.on('change', e => console.log(e.suggestion));
    
    }
};

export { initAutocomplete };