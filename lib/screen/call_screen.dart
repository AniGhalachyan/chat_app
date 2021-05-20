import 'package:chat_app/screen/history/call_history.dart';
import 'package:chat_app/util/theme_notifier.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  void callHistory(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: CallHistroy(),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (c, the, w) => Scaffold(
        backgroundColor: the.background,
        appBar: null,
        body: _body(),
        floatingActionButton: _buttom(),
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Text(
                "Recent Calls",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: 38,
                  // color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              callHistory(context);
            },
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
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "User Name",
                        style: TextStyle(
                          // color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                              width: 15,
                              height: 15,
                              color: Colors.green,
                              child: Icon(
                                Icons.call_received,
                                size: 15,
                                color: Colors.white,
                              )),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 3, left: 5),
                            child: Text(
                              "03.30 AM",
                              style: TextStyle(fontSize: 12),
                            )),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.call,
                  ),
                  color: Colors.purple,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttom() {
    return FloatingActionButton(
      backgroundColor: Colors.purple,
      onPressed: () {},
      child: Icon(
        Icons.call,
        color: Colors.white,
      ),
    );
  }
}
