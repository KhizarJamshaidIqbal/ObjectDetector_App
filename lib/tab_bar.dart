// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/about_us.dart';
import 'package:untitled4/auth/login_screen.dart';
import 'package:untitled4/history_screen.dart';
import 'package:untitled4/object_detector_logic.dart';
import 'package:untitled4/widgets/CustomDrawer%20.dart';

class ObjectDetectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        drawer: CustomDrawer(user: FirebaseAuth.instance.currentUser),
        appBar: AppBar(
          backgroundColor: Color(0xff1C232D),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.yellow),
          title: Text(
            "Hi, Sabeeh",
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ObjectDetectorLogic(),
      ),
    );
  }
}
