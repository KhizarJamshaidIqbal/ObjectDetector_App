// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:untitled4/constants/app_size.dart';

class RoundedTextField extends StatelessWidget {
  final String labelText, hintText;
  bool? isOptional;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? Function(String?)? validator; // Add validator function

  RoundedTextField({
    super.key,
    required this.labelText,
    this.isOptional = false,
    this.hintText = "",
    this.inputType,
    this.controller,
    this.validator, // Pass the validator function
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              labelText,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
              ),
            ),
            if (isOptional == true)
              const Text(
                " *",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffB80000),
                  fontFamily: 'Poppins',
                ),
              ),
          ],
        ),
        5.h,
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          validator: validator, // Assign the validator function
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(
              color: const Color(0xff5F566B).withOpacity(0.5),
              fontFamily: 'Poppins',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 192, 189, 195),
                width: 1.5,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          ),
        ),
      ],
    );
  }
}
