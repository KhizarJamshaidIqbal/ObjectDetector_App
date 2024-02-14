// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, unused_element, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/constants/app_size.dart';
import 'package:untitled4/constants/colors.dart';
import 'package:untitled4/widgets/CustomDrawer%20.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(user: FirebaseAuth.instance.currentUser),
      body: CustomScrollView(
        slivers: [
          MyCustomAppBar(),
          SliverToBoxAdapter(
            child: MyColumn(),
          )
        ],
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      backgroundColor: Color(0xff1C232D),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.yellow),
      title: Text(
        "Help Us",
        style: TextStyle(
          color: Colors.yellow,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MyColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.h,
          Text(
            "Unlock the Essence of an Image",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "YOUR GUIDE TO SUMMIFY",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          30.h,
          Text(
            "How to Use",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          20.h,
          Text(
            "1. Select an Image:",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "Launch the app select an existing image from your device's gallery.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          10.h,
          Text(
            "2. Initiate Summarization:",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "Tap the Summarize button to activate the app summarization process within seconds, a comprehensive summary of the image will appear on next screen.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          10.h,
          Text(
            "3. Explore the Summary:",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "Read the generated summary to gain insights into the image's key elements, such as objects, people, and scenes.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          10.h,
          Text(
            "4. Optimizing Your Summarization Experience Image Quality Matters:",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "For optimal results, use high-resolution images that are well-lit and in focus.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          10.h,
          Text(
            "Addressing Common Issues",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          20.h,
          Text(
            "Network Connectivity:",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "Ensure your device has a stable internet connection to facilitate image processing and summarization.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          10.h,
          Text(
            "Image Clarity:",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "If the app struggles to summarize an image, check if the image is clear and free from excessive noise or distractions",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          20.h,
          Text(
            "Reach Out for Assistance",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          20.h,
          Text.rich(
            TextSpan(
              text:
                  'If you have any further questions or require assistance, please don\'t hesitate to contact us at ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: 'example@example.com',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _launchEmail("example@example.com");
                    },
                ),
              ],
            ),
          ),
          20.h,
          Text(
            "We hope that the Summify App will become an integral part of your workflow for understanding and utilizing visual information.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          50.h,
        ],
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }
}
