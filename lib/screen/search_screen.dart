import 'dart:io';

import 'package:chat_app/helper/constans.dart';
import 'package:chat_app/screen/conversation.dart';
import 'package:chat_app/services/data_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchController = TextEditingController();
  QuerySnapshot querySnapshot;

  initiateSearch() {
    DatabaseMethods().getUserByUserName(searchController.text).then((val) {
      setState(() {
        querySnapshot = val;
      });
      print(querySnapshot);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "Search",
          style: TextStyle(
            fontFamily: 'IndieFlower',
            fontStyle: FontStyle.italic,
            fontSize: 45,
          ),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade300),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                  )
                ],
              ),
            ),
            searchUsersList()
          ],
        ),
      ),
    );
  }

  // for send message
  createChatRoomAndConversation({String userName}) {
    if (userName != Constant.myName) {
      String chatRoomId = getChatRoom(userName, Constant.myName);
      List<String> user = [userName, Constant.myName];
      File image;
      Map<String, dynamic> chatRoomMap = {
        "users": user,
        "chatroomId": chatRoomId,
        "iamge": image
      };
      DatabaseMethods().creatChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId)));
    } else {
      print("you cannot send message to yourself");
    }
  }

  Widget searchList({String userName, String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                userEmail,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndConversation(
                userName: userName,
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient:
                      LinearGradient(colors: [Colors.blue, Colors.purple])),
              child: Text(
                "Message",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget searchUsersList() {
    return querySnapshot != null
        ? ListView.builder(
            itemCount: querySnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchList(
                userEmail: querySnapshot.docs[index].data()["email"],
                userName: querySnapshot.docs[index].data()["name"],
              );
            })
        : Container();
  }
}

getChatRoom(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
