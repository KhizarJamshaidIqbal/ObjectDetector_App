// ignore_for_file: use_build_context_synchronously, unused_import, avoid_print, unused_local_variable, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/auth/login_screen.dart';
import 'package:untitled4/object_detector_logic.dart';
import 'package:untitled4/tab_bar.dart';

import '../model/userModel.dart';
import '../utils/utils.dart';

class AuthModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpUser(UserModel userModel, BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      final User? user = _auth.currentUser;
      if (user != null) {
        final userData = userModel.toMap();
        await _firestore.collection('users').doc(user.uid).set(userData);
        await fetchUserProfileData(user.uid, context);
        print("step 4");
        Utils.showSnakBar(context, "Your account created successfully");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ObjectDetectorLogic(),
            ));
      }
    } catch (e) {
      Utils.errorSnakbar(context, "$e");
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = authResult.user;
      if (user != null) {
        await fetchUserProfileData(user.uid, context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ObjectDetectorLogic()),
        );
      }
      return user;
    } catch (error) {
      Utils.errorSnakbar(context, error.toString());
      return null;
    }
  }

  Future<bool> checkCurrentUser(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await fetchUserProfileData(
            FirebaseAuth.instance.currentUser!.uid, context);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> fetchUserProfileData(String userId, BuildContext context) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = UserModel(
          firstName: userDoc['firstName'],
          lastName: userDoc['lastName'],
          email: userDoc['email'],
          password: userDoc['password'],
          timestamp: userDoc['timestamp'].toDate(),
        );
      } else {
        Utils.snackBar("Record not exists", context,
            backgroundColor: Colors.green);
      }
    } catch (error) {
      Utils.errorSnakbar(context, error);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginView(),
          ));
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
