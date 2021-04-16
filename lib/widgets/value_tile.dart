import 'package:flutter/material.dart';

class ValueTile extends StatelessWidget {
  final String text;
   var temp;
  final String icon;

  ValueTile(this.text , this.icon, this.temp);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        this.icon != null?
        Text(
          icon,
          style: TextStyle(
            fontSize: 20,
          ),
        )
        : Container(
          height: 0,
          width: 0,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '$temp',
        style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
            fontSize: 15,
            color: Colors.black,
        ),
        ),
      ],
    );
  }
}
