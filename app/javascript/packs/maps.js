import { autocomplete } from '../components/autocomplete';

autocomplete();

const styles = [ /* the style copied from https://snazzymaps.com/ */ ];

map.addStyle({
  styles: styles,
  mapTypeId: 'map_style'
});
map.setStyle('map_style');
