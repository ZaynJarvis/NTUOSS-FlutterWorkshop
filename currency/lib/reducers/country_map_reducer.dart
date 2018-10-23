import 'package:redux/redux.dart';
import 'package:currency/actions/actions.dart';

final countryMapReducer = combineReducers<Map>([
  TypedReducer<Map, DatabaseLoadedAction>(_databaseLoadedReducer),
  TypedReducer<Map, AddCountryMapAction>(_addCountryMapReducer),
  TypedReducer<Map, RemoveCountryAction>(_removeCountryMapReducer),
]);

Map _databaseLoadedReducer(Map countryMap, DatabaseLoadedAction action) {
  return Map.from(action.countryMap);
}

Map _addCountryMapReducer(Map countryMap, AddCountryMapAction action) {
  return Map.from(countryMap)..addAll(action.countryRecord);
}

Map _removeCountryMapReducer(Map countryMap, RemoveCountryAction action) {
  return Map.from(countryMap)..remove(action.countryName);
}
