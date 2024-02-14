// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled4/about_us.dart';
import 'package:untitled4/auth/login_screen.dart';
import 'package:untitled4/help_screen.dart';
import 'package:untitled4/history_screen.dart';
import 'package:untitled4/object_detector_logic.dart';

class CustomDrawer extends StatelessWidget {
  final User? user;

  CustomDrawer({required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xff1C232D),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text(user?.email ?? ''),
              accountName: Text(user?.displayName ?? ''),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.yellow,
              ),
              title: const Text(
                'Home',
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ObjectDetectorLogic()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info,
                color: Colors.yellow,
              ),
              title: const Text(
                'About Us',
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.help_outline,
                color: Colors.yellow,
              ),
              title: const Text(
                'Help',
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.history,
                color: Colors.yellow,
              ),
              title: const Text(
                'History',
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetectionHistoryScreen()),
                );
              },
            ),
            SizedBox(
              height: 50.0,
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
