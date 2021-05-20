import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/helper/helper_functions.dart';

import 'package:chat_app/screen/home_screen.dart';
import 'package:chat_app/util/theme_notifier.dart';
import 'package:chat_app/values/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.getInstance().then((prefs) {
    // bool darkModeOn = prefs.getBool("darkModeOn") ?? true;
    runApp(ChangeNotifierProvider<ThemeNotifier>(
        create: (c) => ThemeNotifier(),
        builder: (c, w) {
          final themeNotifier = Provider.of<ThemeNotifier>(c);

          print(themeNotifier.getTheme());
          return MyApp();
        }));
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeNotifier themeNotifierVal;
  var prefs;
  final fcm = FirebaseMessaging.instance;
  bool userIsLoggedIn;
  @override
  void initState() {
    fcm.requestPermission();
    FirebaseMessaging.onMessage.listen((event) {
      event.notification.body;
      event.notification.title;
      print('FirebaseMessaging.onMessage ${event.data}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('FirebaseMessaging.onMessageOpenedApp ${event.data}');
    });

    getLoggedInState();
    super.initState();
    getAppMode();
  }

  getAppMode() async {
    themeNotifierVal = Provider.of<ThemeNotifier>(context, listen: false);
    prefs = await SharedPreferences.getInstance();
    bool isDarkMode = false;
    isDarkMode = prefs.get("darkMode");
    print("theme in shared prefereances: $isDarkMode");
    isDarkMode
        ? themeNotifierVal.setTheme(darkTheme)
        : themeNotifierVal.setTheme(lightTheme);
  }

  getLoggedInState() async {
    HelperFunctions.getUserLoggedInShP().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      theme: themeNotifier.getTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: userIsLoggedIn != null
          ? userIsLoggedIn
              ? HomeScreen()
              : Authenticate()
          : Container(
              child: Center(
                child: Authenticate(),
              ),
            ),
    );
  }
}
