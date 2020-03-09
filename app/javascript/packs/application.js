import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';
import { initMultistepForm } from '../components/preferences_form';


initMapbox();
initAutocomplete();
initMultistepForm();
