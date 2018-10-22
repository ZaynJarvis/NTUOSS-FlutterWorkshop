import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:currency/get_exchange_rate.dart';

class CurrencyApp extends StatefulWidget {
  @override
  _CurrencyAppState createState() => _CurrencyAppState();
}

class _CurrencyAppState extends State<CurrencyApp> {
  final _countryController = TextEditingController();
  final _priceController = TextEditingController();
  Map _countryMap;
  String _baseCountry;
  String _inputPrice;
  @override
  void initState() {
    super.initState();
    _countryMap = {};
    _baseCountry = 'Singapore';
    (() async {
      Map record = await _findExchangeRate(_baseCountry);
      _constructCountryMap(record);
    })();
  }

  void _constructCountryMap(Map record) {
    setState(() {
      _countryMap.addAll(record);
    });
  }

  Future<Map> _findExchangeRate(String data) async {
    Map response = await getExchangeRate(data);
    return response;
  }

  void _priceOnChange([String data]) {
    setState(() {
      _inputPrice = _priceController.text;
    });
  }

  void _deleteContent(country) async {
    if (country != _baseCountry) {
      setState(() {
        _countryMap.remove(country);
      });
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
  }

  void _resetBase(country) async {
    setState(() {
      _baseCountry = country;
    });
  }

  @override
  void dispose() async {
    _countryController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency App',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Currency'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  itemCount: _countryMap.isNotEmpty ? _countryMap.length : 0,
                  itemBuilder: (BuildContext ctx, int index) {
                    double multiplier;
                    try {
                      multiplier = double.parse(_inputPrice);
                    } catch (e) {
                      multiplier = 0.0;
                    }
                    String price = (multiplier *
                            _countryMap[_countryMap.keys.elementAt(index)] /
                            _countryMap[_baseCountry])
                        .toStringAsFixed(2);

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
                            Text(_countryMap.keys.elementAt(index)),
                            Text(price),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Set as base',
                          color: Colors.grey[900],
                          icon: Icons.settings,
                          foregroundColor: Colors.cyanAccent,
                          onTap: () =>
                              _resetBase(_countryMap.keys.elementAt(index)),
                        ),
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.grey[900],
                          icon: Icons.delete_forever,
                          foregroundColor: Colors.redAccent,
                          onTap: () =>
                              _deleteContent(_countryMap.keys.elementAt(index)),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Base Country: $_baseCountry'),
                            controller: _countryController,
                            keyboardType: TextInputType.text,
                            onSubmitted: (data) async {
                              Map record = await _findExchangeRate(data);
                              _constructCountryMap(record);
                              _countryController.text = '';
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: 'Enter price: '),
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            onChanged: _priceOnChange,
                            onSubmitted: (data) {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
