// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, unused_element, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/constants/app_size.dart';
import 'package:untitled4/constants/colors.dart';
import 'package:untitled4/widgets/CustomDrawer%20.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

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
        "About Us",
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
            "Introducing the Summify",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "In today's fast-paced world, we are constantly bombarded with images. From social media to news articles, we are surrounded by visuals that can be difficult to process and remember. That's where the Summify App comes in.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          20.h,
          Text(
            "Our app uses cutting-edge artificial intelligence to automatically summarize images, extracting the key information and providing a concise description. This means you can quickly and easily understand the content of any image, without having to spend hours reading or watching.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          30.h,
          Text(
            "Why Use the Summify",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          20.h,
          Text(
            "1. Save time:",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "Our app can summarize an image in just a few seconds, saving you valuable time.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          10.h,
          Text(
            "2. Improve comprehension:",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "Our summaries are clear and concise, making it easier to understand the content of an image.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          10.h,
          Text(
            "3. Enhance learning:",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "Our app can help you learn more effectively by providing summaries of complex images.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          10.h,
          Text(
            "4. Stay informed:",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "Our app can help you stay up-to-date on current events by summarizing news photos and images.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          30.h,
          Text(
            "How it works",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "Our app uses a variety of techniques to summarize images, including:",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          20.h,
          Text(
            "Scene understanding:",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            " Our app can understand the context of an image and provide a description of the scene.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          10.h,
          Text(
            "Natural language generation:",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          8.h,
          Text(
            "Our app can generate natural language descriptions of images that are easy to read and understand.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          20.h,
          Text(
            "Meet the Team",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          20.h,
          Text(
            "We are a team of three passionate and dedicated individuals who share a common vision: to revolutionize the way we interact with and understand visual information. Each member brings a unique blend of expertise and experience, which is essential to the success of this project.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          20.h,
          Text(
            "Portion for images with one line description of three membera. Like deep learning work, ui/ux designer etc.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          20.h,
          Text(
            "Get Started Today",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          20.h,
          Text(
            "Download the Summify App today and embark on your image understanding journey.",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
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
