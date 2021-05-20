import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseMethods {
  UserCredential res;

  getUserByUserName(String username) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String userEmail) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserName(userMap) async {
    print("this is called $userMap");
    if (userMap["image"] != null) {
      try {
        var ref = FirebaseStorage.instance.ref(userMap["image"]);
        var res = await ref.putFile(File(userMap["image"]));
        var url = await res.ref.getDownloadURL();
        print(url);
        userMap["image"] = url;
      } catch (e) {
        print(e.toString());
      }
    } else {
      userMap["image"] = null;
    }

    print(userMap);

    try {
      FirebaseFirestore.instance.collection("users").add(userMap);
    } catch (e) {
      print(e.toString());
    }
  }

  creatChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((error) {
      print(error.toString());
    });
  }

  getConversationMessage(
    String chatRoomId,
  ) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  addConversationMessage(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((error) {
      print(error.toString());
    });
  }

  Stream getChatRooms(String userName) {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }

  // getImage(File image) async {

  // }
}
