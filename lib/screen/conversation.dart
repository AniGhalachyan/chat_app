import 'dart:ui';

import 'package:chat_app/helper/constans.dart';
import 'package:chat_app/services/data_base.dart';
import 'package:chat_app/util/theme_notifier.dart';
import 'package:chat_app/widgets/all_widgets.dart';
import 'package:chat_app/widgets/message_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageController = TextEditingController();
  bool isOpen = false;
  ThemeNotifier themeNotifier;

  Stream chatMessageStrem;

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();

      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constant.myName,
        "time": Timestamp.now(),
        // "image":
      };
      databaseMethods.addConversationMessage(widget.chatRoomId, messageMap);
      messageController.text = "";
    }

    messageController.clear();
  }

  @override
  void initState() {
    databaseMethods
        .getConversationMessage(
      widget.chatRoomId,
    )
        .then((value) {
      setState(() {
        chatMessageStrem = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (c, the, w) => Scaffold(
        backgroundColor: the.background,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            "Chat",
            style: TextStyle(
              fontFamily: 'IndieFlower',
              fontStyle: FontStyle.italic,
              fontSize: 45,
            ),
          ),
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Container(
      // color: themeNotifier.background,
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Expanded(child: chatMessageList()),
          isOpen ? buildSticker() : SizedBox(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Row(
                children: <Widget>[
                  messageIcons(iconData: Icons.more_vert, onTap: () {}),
                  messageIcons(iconData: Icons.image, onTap: () {}),
                  messageIcons(iconData: Icons.camera_alt, onTap: () {}),
                  messageIcons(
                      iconData: Icons.emoji_emotions,
                      onTap: () {
                        setState(() {
                          isOpen = !isOpen;
                        });
                      }),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // color: Colors.grey.shade300
                      ),
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: "Message....",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.send,
                        color: Colors.purple.shade300,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget chatMessageList() {
    return StreamBuilder(
        stream: chatMessageStrem,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                      snapshot.data.docs[index].data()["message"],
                      snapshot.data.docs[index].data()["sendBy"] ==
                          Constant.myName,
                    );
                  })
              : Container();
        });
  }

  Widget buildSticker() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: EmojiPicker(
        rows: 3,
        columns: 8,
        buttonMode: ButtonMode.MATERIAL,
        numRecommended: 10,
        onEmojiSelected: (emoji, category) {
          if (messageController.text == null) {
            messageController.text = emoji.emoji;
          } else {
            messageController.text += emoji.emoji;
          }
        },
      ),
    );
  }
}
