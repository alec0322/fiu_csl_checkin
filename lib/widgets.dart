// widgets.dart
// File used to define reusable UI components, such as custom text fields.
// widgets.dart
// File used to define reusable UI components, such as custom text fields.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HyperlinkText extends StatelessWidget {

  final String text;
  final String url;

  const HyperlinkText({
    Key? key,
    required this.text,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrlString(url)
          )
        ]
      )
    );
  }
}

class CustomInkWell extends StatelessWidget {
  
  final String text;
  final double height;
  final double width;
  final String imgPath;
  final double imgSize;
  final double? topPadding;
  final double? leftPadding;
  final VoidCallback? onTap;
  final Widget? pageRoute;

  const CustomInkWell({
    Key? key,
    required this.text,
    required this.height,
    required this.width,
    required this.imgPath,
    required this.imgSize,
    this.topPadding,
    this.leftPadding,
    this.onTap,
    this.pageRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => pageRoute!));
        }
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 33, 66, 116),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(127, 0, 0, 0),
              spreadRadius: 1,
              blurRadius: 6,
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.loose,
          children: [
            Positioned(
              top: topPadding ?? 5,
              left: leftPadding ?? 15,
              child: Image.asset(
                imgPath,
                width: imgSize,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
        obscureText: hintText.toLowerCase() == 'password' || hintText.toLowerCase() == 'confirm password',
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
  final double? width;
  final Widget? pageRoute;

  // The button can optionally be attached to a list of controllers...
  final List<TextEditingController>? controllers;

  // or to an 'onTap' callback
  final VoidCallback? onPressed;

  const CustomTextButton({
    Key? key,
    required this.text,
    this.width,
    this.pageRoute,
    this.controllers,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width ?? (text.length <= 10 ? 100 : null),
      child: TextButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          } else {
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => pageRoute!));
              }
              else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('Please fill in all fields'),
                    );
                  },
                );
              }
              
            // If controllers aren't passed, navigate to the page directly
            } else {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => pageRoute!));
            }          
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