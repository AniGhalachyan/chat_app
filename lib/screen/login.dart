import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/screen/chat_room_screen.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/data_base.dart';
import 'package:chat_app/util/theme_notifier.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final Function toggle;
  LoginScreen(this.toggle);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  ThemeNotifier themeNotifier;
  bool _isLoading = false;
  QuerySnapshot snapshotUserInfo;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void signIn() async {
    if (_formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailShP(_emailController.text);
      DatabaseMethods().getUserByUserEmail(_emailController.text).then((val) {
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameShP(
            snapshotUserInfo.docs[0].data()["name"]);
      });
      setState(() {
        _isLoading = true;
      });
      await AuthMethods()
          .signInWithEmailAndPassword(
              _emailController.text, _passwordController.text)
          .then((value) {
        if (value != null) {
          HelperFunctions.saveUserLoggedInShP(true);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ChatRoomScreen()));
        }
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
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
    return _isLoading
        ? Container(
            child: Center(child: CircularProgressIndicator()),
          )
        : Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) {
                                if (val.isEmpty || !val.contains("@")) {
                                  return "Please enter a valid email addres";
                                }
                                return null;
                              },
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(labelText: "Email"),
                            ),
                            TextFormField(
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Plaese enter password. Password has been 6+ characters";
                                }
                                return null;
                              },
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        child: Text("Forgot Password"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextButton(
                    // padding: EdgeInsets.all(0),
                    onPressed: () {
                      signIn();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 300,
                      height: 45,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.purple]),
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'IndieFlower',
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    // padding: EdgeInsets.all(0),
                    onPressed: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: 300,
                      height: 45,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.purple]),
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "Sign in with Google",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'IndieFlower',
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have  account? ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Registration ",
                            style: TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          );
  }
}
