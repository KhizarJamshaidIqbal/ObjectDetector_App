// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled4/auth/login_screen.dart';
import 'package:untitled4/object_detector_logic.dart';
import 'package:untitled4/object_detector_view.dart';
import 'package:untitled4/tab_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:untitled4/viewModel/auth_methords.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showAnimation = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _showAnimation = false;
      });

      Future.delayed(const Duration(seconds: 2), () {
        _checkAuthenticationAndNavigate();
      });
    });
  }

  Future<void> _checkAuthenticationAndNavigate() async {
    bool isAuthenticated = await AuthModel().checkCurrentUser(context);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            isAuthenticated ? ObjectDetectorLogic() : LoginView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(280)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset('assets/image.png'),
              ),
            ),
            _showAnimation
                ? Visibility(
                    visible: _showAnimation,
                    child: Lottie.asset("assets/animation1.json",
                        height: 100, width: 100),
                  )
                : const SizedBox.shrink(),
            Visibility(
              visible: !_showAnimation,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 35.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('Summify'),
                    WavyAnimatedText('Summify'),
                  ],
                  isRepeatingAnimation: true,
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
