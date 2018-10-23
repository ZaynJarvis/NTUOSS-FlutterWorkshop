import 'package:redux/redux.dart';
import 'package:currency/actions/actions.dart';
import 'package:currency/models/app_state.dart';
import 'package:currency/dbHelper.dart';
import 'package:currency/get_exchange_rate.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  final restoreFromDatabase = _restoreFromDatabase();
  return [
    TypedMiddleware<AppState, RestoreFromDatabaseAction>(restoreFromDatabase)
  ];
}

Middleware<AppState> _restoreFromDatabase() {
  DatabaseHelper database;

  Future<Map> restore() async {
    Map countryMap = {};
    database = DatabaseHelper();
    String baseCountry = await database.findBase() ?? 'Singapore';
    await database.saveCountry(baseCountry);
    await database.updateBase(baseCountry);
    List<Map> countries = await database.getAllCountries();
    await Future.forEach(countries, (item) async {
      var x = await getExchangeRate(item['country']);
      countryMap.addAll(x);
    });
    return Map.from({'baseCountry': baseCountry, 'countryMap': countryMap});
  }

  return (Store<AppState> store, action, NextDispatcher next) {
    restore().then((state) => store.dispatch(DatabaseLoadedAction(
        baseCountry: state['baseCountry'], countryMap: state['countryMap'])));
    next(action);
  };
}
