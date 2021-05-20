import 'dart:io';

import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/screen/chat_room_screen.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/data_base.dart';
import 'package:chat_app/util/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggle;
  RegisterScreen(this.toggle);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  File userImageFile;

  bool _isLoading = false;
  ThemeNotifier themeNotifier;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String pickedAvatar = "";

  ImagePicker picker = ImagePicker();
  Future getImage() async {
    var pickerImageFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 150,
    );

    setState(() {
      userImageFile = File(pickerImageFile.path);
    });
  }

  // void pickedImage(File image) {
  //   userImageFile = image;
  // }

  void signUp() async {
    if (userImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("please pick an image"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await AuthMethods()
          .createUserWithEmailAndPassword(
              _emailController.text, _passwordController.text)
          .then((value) {
        Map<String, String> userInfo = {
          "name": _userNameController.text,
          "email": _emailController.text,
          "image": userImageFile.path,
        };

        HelperFunctions.saveUserImagelShP(userImageFile.toString());
        HelperFunctions.saveUserNameShP(_userNameController.text);
        HelperFunctions.saveUserEmailShP(_emailController.text);
        DatabaseMethods().uploadUserName(userInfo);

        HelperFunctions.saveUserLoggedInShP(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoomScreen()));
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
        ? Center(
            child: CircularProgressIndicator(),
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
                            pickerImg(),
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
                              key: ValueKey("Username"),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Please enter name";
                                }
                                return null;
                              },
                              controller: _userNameController,
                              decoration:
                                  InputDecoration(labelText: "UserName"),
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
                      signUp();
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
                        "Registration",
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
                        "I have  account, ",
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
                            "Login",
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

  Widget pickerImg() {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: userImageFile != null
              ? FileImage(userImageFile)
              : AssetImage("assets/img/avatar.png"),
          backgroundColor: Colors.purple.shade300,
          radius: 40,
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.35,
          child: TextButton(
            // autofocus: false,
            onPressed: getImage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image,
                  color: Colors.purple,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "add image",
                  style: TextStyle(color: Colors.purple),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
