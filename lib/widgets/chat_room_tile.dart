import 'package:chat_app/screen/conversation.dart';
import 'package:flutter/material.dart';

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomTile(
    this.userName,
    this.chatRoomId,
  );
  @override
  Widget build(BuildContext context) {
    // print('userName $userName');
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(chatRoomId)));
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.purple.shade400,
                  borderRadius: BorderRadius.circular(60),
                  // image: DecorationImage(
                  //   image: (image),
                  // )
                ),
                child: Text(
                  "${userName.substring(0, 1)}",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                userName,
                style: TextStyle(fontFamily: "PatricHand", fontSize: 25),
              ),
            ],
          )),
    );
  }
}
