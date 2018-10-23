import 'package:currency/models/app_state.dart';
import 'package:currency/reducers/base_country_reducer.dart';
import 'package:currency/reducers/country_map_reducer.dart';
import 'package:currency/reducers/price_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    baseCountry: baseCountryReducer(state.baseCountry, action),
    countryMap: countryMapReducer(state.countryMap, action),
    price: priceReducer(state.price, action),
  );
}
