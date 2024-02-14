// ignore_for_file: prefer_const_constructors_in_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled4/constants/app_size.dart';
import 'package:untitled4/constants/colors.dart';
import 'package:untitled4/widgets/custom_textField.dart';
import '../model/userModel.dart';
import '../viewmodel/auth_methords.dart';
import '../widgets/password_field.dart';
import '../widgets/rounded_btn.dart';
import 'login_screen.dart';

class SignupView extends StatefulWidget {
  SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First Name is required';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  String? validateCollege(String? value) {
    if (value == null || value.isEmpty) {
      return 'College is required';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.lightGreen],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                50.h,
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Lottie.asset('assets/robot.json'),
                        ),
                        const Text(
                          "Sign Up for Unlocking Learning with AI Support",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                        20.h,
                        Row(
                          children: [
                            Expanded(
                              child: RoundedTextField(
                                labelText: "First Name",
                                isOptional: true,
                                hintText: "First Name...",
                                controller: firstNameController,
                                validator: validateFirstName,
                              ),
                            ),
                            5.w,
                            Expanded(
                              child: RoundedTextField(
                                labelText: "Last Name",
                                isOptional: true,
                                hintText: "Last Name...",
                                controller: lastNameController,
                                validator: validateLastName,
                              ),
                            ),
                          ],
                        ),
                        10.h,
                        RoundedTextField(
                          labelText: "Email",
                          isOptional: true,
                          hintText: "Enter Your Email...",
                          controller: emailController,
                          validator: validateEmail,
                        ),
                        10.h,
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
                        10.h,
                        ValueListenableBuilder(
                          valueListenable: _obsecurePassword,
                          builder: (context, value, child) {
                            return PasswordRoundedTextField(
                              labelText: "Confirm Password",
                              hintText: "Confirm Your Password...",
                              isOptional: true,
                              controller: confirmPasswordController,
                              validator: validateConfirmPassword,
                              isPassword: true,
                              obscureText: _obsecurePassword.value,
                              onTogglePasswordVisibility: () {
                                _obsecurePassword.value =
                                    !_obsecurePassword.value;
                              },
                            );
                          },
                        ),
                        80.h,
                        RoundButton(
                          title: "Sign Up",
                          textColor: Colors.white,
                          loading: _isLoading,
                          onPress: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              final usermodel = UserModel(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  timestamp: DateTime.timestamp());

                              final auth = AuthModel();
                              await auth.signUpUser(usermodel, context);

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
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginView(),
                                  ),
                                );
                              },
                              child: const Text('Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline)),
                            ),
                          ],
                        ),
                      ],
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
