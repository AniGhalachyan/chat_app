import 'package:chat_app/screen/call_screen.dart';
import 'package:chat_app/screen/chat_room_screen.dart';
import 'package:chat_app/screen/profile_screen.dart';
import 'package:chat_app/screen/schedule_screen.dart';
import 'package:chat_app/util/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  ThemeNotifier themeNotifier;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (c, the, w) => Scaffold(
        backgroundColor: the.background,
        body: _body(),
        bottomNavigationBar: _bottomBar(bg: the.background),
      ),
    );
  }

  Widget _body() {
    print(currentIndex);
    switch (currentIndex) {
      case 0:
        currentIndex = 0;
        return ChatRoomScreen();
        break;
      case 1:
        currentIndex = 1;
        return ScheduleScreen();
        break;
      case 2:
        currentIndex = 2;
        return CallScreen();
        break;
      case 3:
        currentIndex = 3;
        return ProfileScreen();
      default:
        return ChatRoomScreen();
    }
  }

  Widget _bottomBar({Color bg}) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: bg,
      elevation: 50,
      selectedItemColor: Colors.purple,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.messenger,
              color: Colors.grey,
            ),
            activeIcon: Icon(Icons.messenger, color: Colors.purple)),
        BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.schedule,
              color: Colors.grey,
            ),
            activeIcon: Icon(Icons.schedule, color: Colors.purple)),
        BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.call,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.call,
              color: Colors.purple,
            )),
        BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            activeIcon: Icon(Icons.person, color: Colors.purple)),
      ],
    );
  }
}
