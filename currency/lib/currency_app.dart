import 'package:flutter/material.dart';

class CurrencyApp extends StatefulWidget {
  @override
  _CurrencyAppState createState() => _CurrencyAppState();
}

class _CurrencyAppState extends State<CurrencyApp> {
  final _countryController = TextEditingController();
  final _priceController = TextEditingController();

  void _countryOnSubmit([String data]) {}
  void _priceOnChange([String data]) {}
  @override
  void initState() {
    super.initState();
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
                  itemCount: 1,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Text('Count #$index');
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
                            controller: _countryController,
                            keyboardType: TextInputType.text,
                            onSubmitted: _countryOnSubmit,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                          ),
                          onPressed: _countryOnSubmit,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
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
