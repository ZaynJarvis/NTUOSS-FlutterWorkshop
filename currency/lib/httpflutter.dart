import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HTTPFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url =
      'http://data.fixer.io/api/latest?access_key=848680d4b0eaee2e313344d4343010aa';
  final String country = 'https://restcountries.eu/rest/v2/name/';
  String data;
  final myController = TextEditingController();
  String x;
  double cu;
  List countryList = ['singapore', 'china', 'canada'];
  List storedCountry = [];
  Map<String, double> cMap = {};
  String debug = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    for (String item in storedCountry) {
      var ct = await http.get(Uri.encodeFull(country + (item ?? 'singapore')),
          headers: {"Accept": "application/json"});
      data = jsonDecode(ct.body)[0]['currencies'][0]['code'];
      cu = jsonDecode(response.body)['rates'][data];
      cMap[item] = cu;
    }
    return 'Success';
  }

  List<dynamic> getBlock() {
    var x = [];
    if (cMap != null)
      cMap.forEach((String key, double value) {
        x.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(key),
            Text(value.toString()),
          ],
        ));
      });

    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HTTP GET request")),
      body: Row(
        children: <Widget>[
          // Expanded(
          //   child: Column(
          //     // children: getBlock(),
          //     children: <Widget>[
          //       Text('s'),
          //     ],
          //   ),
          // ),
          Flexible(
            child: TextField(
              controller: myController,
              onSubmitted: (xa) {
                setState(() {
                  if (countryList.contains(xa))
                    storedCountry.add(xa);
                  else
                    debug = 'Not Valid';
                });
                myController.text = '';
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => this.getJsonData(),
          ),
        ],
      ),
    );
  }
}
