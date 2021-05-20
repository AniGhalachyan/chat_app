import 'package:chat_app/util/theme_notifier.dart';
import 'package:chat_app/values/theme.dart';
import 'package:chat_app/widgets/all_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _darkTheme = false;
  ThemeNotifier themeNotifier;
  SharedPreferences prefs;
  UserCredential userCredential;

  @override
  void initState() {
    super.initState();
    initPage();
  }

  initPage() async {
    themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkTheme = prefs.get("darkMode");
    });
  }

  @override
  Widget build(BuildContext context) {
    // _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return SafeArea(
      child: Consumer<ThemeNotifier>(
        builder: (c, the, w) => Scaffold(
          backgroundColor: the.background,
          appBar: null,
          body: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      color: themeNotifier.background,
      padding: EdgeInsets.only(top: 70),
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Text(
                "Setting",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: 38,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 100,
                padding: EdgeInsets.only(top: 20),
                alignment: Alignment.bottomLeft,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.purple,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "Status",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            height: 15,
            thickness: 2,
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Row(children: <Widget>[
                  Icon(
                    Icons.nightlight_round,
                    color: Colors.purple,
                    size: 28,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("Dark mode", style: TextStyle(fontSize: 20)),
                  ),
                  Spacer(),
                  Switch(
                      activeColor: Colors.purple,
                      value: _darkTheme,
                      onChanged: (val) {
                        setState(() {
                          _darkTheme = val;
                        });
                        onThemeChanged(val, themeNotifier);
                      })
                ]),
                profileIcons(
                    iconData: Icons.person,
                    title: "Account",
                    icons: Icons.chevron_right),
                profileIcons(
                    iconData: Icons.notifications,
                    title: "Notification",
                    icons: Icons.chevron_right),
                profileIcons(
                    iconData: Icons.message,
                    title: "Chat Setting",
                    icons: Icons.chevron_right),
                profileIcons(
                    iconData: Icons.data_usage,
                    title: "Data and storage",
                    icons: Icons.chevron_right),
                profileIcons(
                    iconData: Icons.lock,
                    title: "Privacy and security",
                    icons: Icons.chevron_right),
                profileIcons(
                    iconData: Icons.report,
                    title: "About",
                    icons: Icons.chevron_right),
              ],
            ),
          )
        ],
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    print(value);
    await prefs.setBool("darkMode", value);
  }
}
