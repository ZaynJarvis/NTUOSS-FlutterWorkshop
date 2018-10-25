import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:currency/actions/actions.dart';
import 'package:currency/models/app_state.dart';
import 'package:currency/slider.dart';

class SliderWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) => store.dispatch(RestoreFromDatabaseAction()),
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return ListView.builder(
          itemCount: vm.countryMap.isNotEmpty ? vm.countryMap.length : 0,
          itemBuilder: (BuildContext ctx, int index) {
            return CurrencySlider(
              country: vm.countryMap.keys.elementAt(index),
              rate: vm.calcPrice(index),
            );
          },
        );
      },
    );
  }
}

class _ViewModel {
  final Map countryMap;
  final String price;
  final String baseCountry;
  final Function calcPrice;

  _ViewModel({
    @required this.countryMap,
    @required this.price,
    @required this.baseCountry,
    @required this.calcPrice,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      countryMap: store.state.countryMap,
      price: store.state.price,
      calcPrice: (index) {
        Map _countryMap = store.state.countryMap;
        String _baseCountry = store.state.baseCountry;
        double multiplier;
        try {
          multiplier = double.parse(store.state.price);
        } catch (e) {
          multiplier = 0.0;
        }
        String calcPrice = (multiplier *
                _countryMap[_countryMap.keys.elementAt(index)] /
                _countryMap[_baseCountry])
            .toStringAsFixed(2);
        return calcPrice;
      },
      baseCountry: store.state.baseCountry,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          countryMap == other.countryMap &&
          baseCountry == other.baseCountry &&
          price == other.price;

  @override
  int get hashCode =>
      countryMap.hashCode ^ price.hashCode ^ baseCountry.hashCode;
}
