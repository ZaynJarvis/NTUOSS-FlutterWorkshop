import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './SliderContent.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HTTPFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final countryController = TextEditingController();
  final numberController = TextEditingController();
  String debug;
  String base;
  double calcNumber;
  Map<String, double> countryMap;
  // final String currencyUrl =
  //     'http://data.fixer.io/api/latest?access_key=848680d4b0eaee2e313344d4343010aa';
  // ifconfig | grep "inet " | grep -v 127.0.0.1
  final String currencyUrl = 'http://192.168.0.102:3001';
  final String countryCode = 'https://restcountries.eu/rest/v2/name/';

  @override
  void initState() {
    super.initState();
    base = 'Singapore';
    debug = '';
    calcNumber = 0.0;
    countryMap = {};
    addMap(base);
  }

  @override
  void dispose() {
    countryController.dispose();
    numberController.dispose();
    super.dispose();
  }

  void addMap(item) async {
    String newConturyCode;
    String newConturyName;
    try {
      var newCountry = await http.get(Uri.encodeFull(countryCode + item),
          headers: {"Accept": "application/json"});
      newConturyCode = jsonDecode(newCountry.body)[0]['currencies'][0]['code'];
      newConturyName = jsonDecode(newCountry.body)[0]['name'];
      var response = await http.get(Uri.encodeFull(currencyUrl),
          headers: {"Accept": "application/json"});
      double currency = jsonDecode(response.body)['rates'][newConturyCode];
      setState(() {
        countryMap[newConturyName] = currency;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<String> getJsonData() async {
    addMap(countryController.text);
    countryController.text = '';
    return 'Success';
  }

  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
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

  void _deleteContent(country) {
    if (country != base)
      setState(() {
        countryMap.remove(country);
      });
    else
      _showDialog();
  }

  void _resetBase(country) {
    setState(() {
      base = country;
    });
  }

  void putNumber() {
    try {
      setState(() {
        if (numberController.text == '')
          calcNumber = 0.0;
        else
          calcNumber = double.parse(numberController.text ?? 0.0);
      });
    } catch (e) {
      setState(() {
        debug = 'Number not valid';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extrange Rate App'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: <Widget>[
            Flexible(
              child: GestureDetector(
                child: ListView.builder(
                  itemCount: countryMap.isNotEmpty ? countryMap.length : 0,
                  itemBuilder: (BuildContext context, int index) {
                    try {
                      double price = calcNumber *
                          countryMap[countryMap.keys.elementAt(index)] /
                          countryMap[base];
                      // return SliderContent(countryMap, index+1, price);
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
                              Text(countryMap.keys.elementAt(index)),
                              Text((price).toStringAsFixed(2)),
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
                                _resetBase(countryMap.keys.elementAt(index)),
                          ),
                        ],
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.grey[900],
                            icon: Icons.delete_forever,
                            foregroundColor: Colors.redAccent,
                            onTap: () => _deleteContent(
                                countryMap.keys.elementAt(index)),
                          ),
                        ],
                      );
                    } catch (e) {
                      print(e);
                      return null;
                    }
                  },
                ),
                onTap: () => _dismissKeyboard(context),
              ),
              fit: FlexFit.tight,
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Based on Country: $base',
                          ),
                          controller: countryController,
                          keyboardAppearance: Brightness.dark,
                          onSubmitted: (data) => getJsonData(),
                          // implement with picker.
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      IconButton(
                        color: Colors.cyanAccent,
                        icon: Icon(
                          Icons.add,
                        ),
                        onPressed: getJsonData,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Price',
                          ),
                          keyboardType: TextInputType.number,
                          keyboardAppearance: Brightness.dark,
                          controller: numberController,
                          onChanged: (data) => putNumber(),
                          onSubmitted: (data) {
                            numberController.text = '';
                            setState(() {
                              calcNumber = 0.0;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
