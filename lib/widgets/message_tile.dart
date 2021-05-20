import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    Size _textSize = getTextSize(context);
    double _minSize = MediaQuery.of(context).size.width * 0.5;
    double _actualSize =
        _textSize.width < _minSize ? _textSize.width : _minSize;

    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 10, right: isSendByMe ? 10 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: _actualSize,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isSendByMe
                    ? [Colors.blue, Colors.purple]
                    : [Colors.purple, Colors.blue]),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomLeft: isSendByMe ? Radius.circular(23) : Radius.circular(0),
              bottomRight:
                  isSendByMe ? Radius.circular(0) : Radius.circular(23),
            )),
        child: Text(
          message,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontFamily: "PatrickHand"),
        ),
      ),
    );
  }

  Size getTextSize(BuildContext context) {
    return (TextPainter(
            text: TextSpan(
                text: message,
                style: TextStyle(
                    fontSize: 31,
                    color: Colors.white,
                    fontFamily: "PatrickHand")),
            textDirection: TextDirection.ltr)
          ..layout())
        .size;
  }
}
