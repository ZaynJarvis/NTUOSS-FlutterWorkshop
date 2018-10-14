import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SliderContent extends StatelessWidget {
  Map<String, double> countryMap;
  int index;
  double price;
  SliderContent(this.countryMap, this.index, this.price);
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
            Text(countryMap.keys.elementAt(index)),
            Text((price).toStringAsFixed(2)),
          ],
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.grey[900],
          icon: Icons.delete_forever,
          foregroundColor: Colors.redAccent,
          // onTap: () => _showSnackBar('Delete'),
        ),
      ],
    );
  }
}
