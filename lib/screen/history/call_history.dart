import 'package:chat_app/util/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CallHistroy extends StatelessWidget {
  ThemeNotifier themeNotifier;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (c, the, w) => Container(
        decoration: BoxDecoration(
            color: the.background, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15, top: 15),
                    width: 55,
                    height: 55,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(55),
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/img/avatar.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 18,
                            width: 18,
                            color: Colors.white,
                            padding: EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Call History ",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(
                            "User Name",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                    ),
                    color: Colors.purple,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 2,
              thickness: 2,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.green,
                        child: Icon(
                          Icons.call_received,
                          size: 15,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "03.30 AM",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text("33 mins 12.3MB"),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.call,
                      color: Colors.purple,
                    ),
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
