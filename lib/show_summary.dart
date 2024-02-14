// // ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, unused_local_variable, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/constants/colors.dart';
import 'package:untitled4/utils/utils.dart';
import 'package:untitled4/widgets/rounded_btn.dart';

class SummaryPage extends StatefulWidget {
  final String detectedObjects;
  final String captionText;
  final File apiImage;

  const SummaryPage({
    Key? key,
    required this.detectedObjects,
    required this.apiImage,
    required this.captionText,
  }) : super(key: key);

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  Future<void> _storeToHistory(String captionText) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}');
      await storageReference.putFile(widget.apiImage);
      final String imageUrl = await storageReference.getDownloadURL();
      await FirebaseFirestore.instance.collection('DetectionHistory').add({
        'userName': FirebaseAuth.instance.currentUser!.uid,
        'image_url': imageUrl,
        'summary': captionText,
        'timestamp': DateTime.now(),
      });
      Utils.snackBar("Saved To History", context,
          backgroundColor: Colors.green);
    } catch (e) {
      Utils.snackBar("$e", context, backgroundColor: Colors.green);
      print('Error storing to history: $e');
      // Handle the error as needed
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: const Center(
              child: Text(
                'Summary of Detected',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (widget.apiImage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(
                widget.apiImage,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              widget.detectedObjects,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RoundButton(
              title: "Save In History",
              textColor: Colors.white,
              loading: isLoading,
              onPress: () async {
                setState(() {
                  isLoading = true;
                });
                await _storeToHistory(widget.captionText);
                setState(() {
                  isLoading = false;
                });
              },
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
