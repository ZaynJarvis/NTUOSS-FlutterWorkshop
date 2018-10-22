import 'dart:async';
import 'package:flutter/material.dart';
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

  void _priceOnChange([String data]) {}

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
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_countryMap.keys.elementAt(index)),
                        Text((_countryMap[_countryMap.keys.elementAt(index)])
                            .toStringAsFixed(2)),
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
