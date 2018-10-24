import 'package:flutter/material.dart';
import 'package:currency/get_exchange_rate.dart';
import 'package:currency/dbHelper.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:currency/models/app_state.dart';
import 'package:currency/actions/actions.dart';

class InputField extends StatefulWidget {
  final DatabaseHelper database;
  InputField({Key key, this.database});
  @override
  InputFieldState createState() {
    return new InputFieldState();
  }
}

class InputFieldState extends State<InputField> {
  final _countryController = TextEditingController();

  @override
  void dispose() async {
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: StoreConnector<AppState, _ViewModel>(
                  distinct: true,
                  converter: _ViewModel.fromStore,
                  builder: (context, viewModel) {
                    return TextField(
                      decoration: InputDecoration(
                          hintText: 'Base Country: ${viewModel.baseCountry}'),
                      controller: _countryController,
                      keyboardType: TextInputType.text,
                      onSubmitted: (data) async {
                        Map record = await getExchangeRate(data);
                        if (record.isNotEmpty) {
                          viewModel.addCountryMapAction(record);
                          await widget.database
                              .saveCountry(record.keys.elementAt(0));
                        }
                        _countryController.text = '';
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: StoreConnector<AppState, Function>(
                  converter: (Store<AppState> store) {
                    return (price) {
                      store.dispatch(UpdatePriceAction(
                        price,
                      ));
                    };
                  },
                  builder: (BuildContext context, Function onChanged) {
                    return TextField(
                      decoration: InputDecoration(hintText: 'Enter price: '),
                      keyboardType: TextInputType.number,
                      onChanged: onChanged,
                      onSubmitted: (data) {},
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ViewModel {
  final Function(Map) addCountryMapAction;
  final String baseCountry;

  _ViewModel({
    @required this.addCountryMapAction,
    @required this.baseCountry,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      addCountryMapAction: (country) {
        store.dispatch(AddCountryMapAction(country));
      },
      baseCountry: store.state.baseCountry,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          baseCountry == other.baseCountry;

  @override
  int get hashCode => baseCountry.hashCode;
}
