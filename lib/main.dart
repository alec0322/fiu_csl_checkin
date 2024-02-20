// main.dart
// Main page of the application, for security purposes the user should always
// be asked to login.

import 'package:flutter/material.dart';
import 'widgets.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FIU CSL Check-in',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'FIU CSL Check-in',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 8, 30, 63)
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/fiu_roary.png')),

              const SizedBox(height: 30),
              
              CustomTextButton(
                text: 'Log in',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                pageRoute: const LoginPage(),
              )
            ],
          ),
        ),
      ),
    );
  }
}