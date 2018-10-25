import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData.dark(),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;
  int _upperBound = 12;
  int _lowerBound = 1;
  void _setCounterState(func) {
    setState(() {
      _counter = func(_counter);
    });
  }

  int max(a, b) {
    return a > b ? a : b;
  }

  int min(a, b) {
    return a < b ? a : b;
  }

  int _increment(val) {
    return min(val + 1, _upperBound);
  }

  int _decrement(val) {
    return max(val - 1, _lowerBound);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                ('assets/linearGradient.png'),
              ),
              fit: BoxFit.cover),
        ),
        child: GestureDetector(
          child: Center(
            child: Text(
              'iOS $_counter',
              style: Theme.of(context).textTheme.display4,
            ),
          ),
          onTap: () => _setCounterState(_decrement),
          onDoubleTap: () => _setCounterState(_increment),
        ),
      ),
    );
  }
}
