import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/helper/constans.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/screen/search_screen.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/data_base.dart';
import 'package:chat_app/util/theme_notifier.dart';
import 'package:chat_app/widgets/chat_room_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  ThemeNotifier themeNotifier;

  @override
  void initState() {
    themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constant.myName = await HelperFunctions.getUserNameShP();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (c, the, w) => Scaffold(
        backgroundColor: the.background,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            "Chat Room",
            style: TextStyle(
              fontFamily: 'IndieFlower',
              fontStyle: FontStyle.italic,
              fontSize: 40,
              // color: themeNotifier.background
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                AuthMethods().signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (contex) => Authenticate()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: chatRoomList(),
        floatingActionButton: _buttom(),
      ),
    );
  }

  Widget _buttom() {
    return FloatingActionButton(
      backgroundColor: Colors.purple,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchScreen()));
      },
      child: Icon(
        Icons.search,
        color: Colors.white,
      ),
    );
  }

  Widget chatRoomList() {
    return Container(
      color: themeNotifier.background,
      child: StreamBuilder(
          stream: DatabaseMethods().getChatRooms(Constant.myName),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ChatRoomTile(
                        snapshot.data.docs[index]
                            .data()["chatroomId"]
                            .toString()
                            .replaceAll("_", '')
                            .replaceAll(Constant.myName, ""),
                        snapshot.data.docs[index].data()["chatroomId"],
                        // snapshot.data.docs[index].data()["image"]
                      );
                    },
                  )
                : Container(
                    child: Text("hello"),
                  );
          }),
    );
  }
}
