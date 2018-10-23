import 'package:flutter/material.dart';
import 'package:currency/currency_app.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:currency/models/app_state.dart';
import 'package:currency/reducers/app_reducer.dart';
import 'package:currency/middleware/currency_redux_middleware.dart';

void main() {
  AppState state = AppState();
  final store = Store<AppState>(appReducer,
      initialState: state, middleware: createStoreMiddleware());

  runApp(
    StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Currency App',
        theme: ThemeData.dark(),
        home: CurrencyApp(),
      ),
    ),
  );
}
