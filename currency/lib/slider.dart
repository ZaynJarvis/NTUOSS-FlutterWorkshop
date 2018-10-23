import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dbHelper.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:currency/actions/actions.dart';
import 'package:currency/models/app_state.dart';

class CurrencySlider extends StatelessWidget {
  final String country, rate;
  final DatabaseHelper database;

  CurrencySlider({Key key, this.country, this.rate})
      : database = DatabaseHelper(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      delegate: SlidableDrawerDelegate(),
      actionExtentRatio: 0.2,
      child: Container(
        color: Colors.grey[800],
        margin: EdgeInsets.symmetric(vertical: 2.0),
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        height: 70.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(country),
            Text(rate),
          ],
        ),
      ),
      actions: <Widget>[
        StoreConnector<AppState, Function>(
          converter: (Store<AppState> store) {
            return (countryName) async {
              store.dispatch(UpdateBaseCountryAction(
                countryName,
              ));
              database.updateBase(country);
            };
          },
          builder: (BuildContext context, Function onTap) {
            return IconSlideAction(
              caption: 'Set as base',
              color: Colors.grey[900],
              icon: Icons.settings,
              foregroundColor: Colors.cyanAccent,
              onTap: () => onTap(country),
            );
          },
        ),
      ],
      secondaryActions: <Widget>[
        StoreConnector<AppState, Function>(
          converter: (Store<AppState> store) {
            return (countryName) async {
              if (store.state.baseCountry != countryName) {
                store.dispatch(RemoveCountryAction(
                  countryName,
                ));
                await database.deleteCountry(country);
              } else
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("Alert"),
                      content: new Text("You cannot delete your base."),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
            };
          },
          builder: (BuildContext context, Function onTap) {
            return IconSlideAction(
              caption: 'Delete',
              color: Colors.grey[900],
              icon: Icons.delete_forever,
              foregroundColor: Colors.redAccent,
              onTap: () => onTap(country),
            );
          },
        ),
      ],
    );
  }
}
