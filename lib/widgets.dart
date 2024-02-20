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

class CustomTextButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final Widget pageRoute;

  // The button can optionally be attached to a list of controllers
  final List<TextEditingController>? controllers;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.pageRoute,
    this.controllers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: TextButton(
        onPressed: () {

          // If controllers are passed, we check if they are all filled prior to routing the user
          if (controllers != null) {
            bool allFilled = true;
            for (TextEditingController? controller in controllers!) {
              if (controller == null || controller.text.isEmpty) {
                allFilled = false;
                break;
              }
            }
            
            if (allFilled) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => pageRoute));
            }
            
          // If controllers aren't passed, we assume the button isn't conditional
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => pageRoute));
          }          
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 33, 66, 116)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        ),
      ),
    );
  }
}