// ignore_for_file: unused_import

import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/constants/app_size.dart';
import 'package:untitled4/constants/colors.dart';
import 'package:untitled4/widgets/rounded_btn.dart';
import '../viewmodel/auth_methords.dart';
import '../widgets/custom_textField.dart';
import '../widgets/password_field.dart';
import 'signup_screen.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          key: formKey,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                40.h,
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: GlobalColors.appLightColor,
                      size: 32,
                    ),
                  ),
                ),
                SizedBox(
                  height: 245,
                  width: 500,
                  child: Lottie.asset('assets/robot.json'),
                ),
                // 10.h,
                SizedBox(
                  // height: context.screenHeight * 0.8,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.green, Colors.lightGreen],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            50.h,
                            const Text(
                              "Login To Unlocking Learning with AI Support",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                            ),
                            60.h,
                            RoundedTextField(
                              labelText: "Email",
                              isOptional: true,
                              hintText: "Enter Your Email...",
                              controller: emailController,
                              validator: validateEmail,
                            ),
                            20.h,
                            ValueListenableBuilder(
                              valueListenable: _obsecurePassword,
                              builder: (context, value, child) {
                                return PasswordRoundedTextField(
                                  labelText: "Passowrd",
                                  hintText: "Enter Your Password...",
                                  isOptional: true,
                                  controller: passwordController,
                                  isPassword: true,
                                  obscureText: _obsecurePassword.value,
                                  onTogglePasswordVisibility: () {
                                    _obsecurePassword.value =
                                        !_obsecurePassword.value;
                                  },
                                  validator: validatePassword,
                                );
                              },
                            ),
                            50.h,
                            RoundButton(
                              title: "Login",
                              loading: _isLoading,
                              textColor: Colors.white,
                              onPress: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final auth = AuthModel();
                                  await auth.signInWithEmailAndPassword(
                                      emailController.text.trim(),
                                      passwordController.text,
                                      context);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              color: AppColors.appColor,
                            ),
                            // 5.h,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Do not have an account?',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignupView(),
                                        ));
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            10.h,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
