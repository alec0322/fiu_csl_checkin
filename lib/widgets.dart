// widgets.dart
// File used to define reusable UI components, such as custom text fields.

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key, 
    required this.hintText, 
    required this.controller,
    this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        obscureText: hintText.toLowerCase() == 'password',
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 182, 134, 44),
              width: 3.0,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 182, 134, 44),
              width: 3.0,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}