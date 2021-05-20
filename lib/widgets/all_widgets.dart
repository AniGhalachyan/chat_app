import 'package:flutter/material.dart';

Widget messageIcons({IconData iconData, Function onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(10),
      child: Icon(
        iconData,
        color: Colors.purple.shade300,
        size: 20,
      ),
    ),
  );
}

Widget profileIcons({
  IconData iconData,
  String title,
  IconData icons,
}) {
  return Container(
    padding: EdgeInsets.only(top: 25),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          iconData,
          size: 28,
          color: Colors.purple,
        ),
        Container(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Spacer(),
        Icon(
          icons,
          size: 25,
        ),
      ],
    ),
  );
}
