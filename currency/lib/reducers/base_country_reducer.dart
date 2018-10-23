import 'package:redux/redux.dart';
import 'package:currency/actions/actions.dart';

final baseCountryReducer = combineReducers<String>([
  TypedReducer<String, DatabaseLoadedAction>(_databaseLoadedReducer),
  TypedReducer<String, UpdateBaseCountryAction>(_updateBaseCountryReducer),
]);

String _updateBaseCountryReducer(
    String baseCountry, UpdateBaseCountryAction action) {
  return action.baseCountry;
}

String _databaseLoadedReducer(String baseCountry, DatabaseLoadedAction action) {
  return action.baseCountry;
}
