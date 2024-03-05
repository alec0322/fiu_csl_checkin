// login.dart
// Login page of the application.

import 'package:flutter/material.dart';
import 'main.dart';
import 'widgets.dart';
import 'dashboard.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 30, 63),
      appBar: AppBar(
        title: const Text(
          'Back to home',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyApp()));
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 33, 66, 116),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 8, 30, 63),
          padding: const EdgeInsets.all(45.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [              
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Username', 
                controller: usernameController,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: 'Password', 
                controller: passwordController,
                onChanged: (value) {
                  setState(() {});
                }
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextButton(
                      text: 'Log in',
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Dashboard()));
                      },
                      pageRoute: const Dashboard(),
                      controllers: [usernameController, passwordController],
                    ), 
                    
                    const Spacer(),

                    CustomTextButton(
                      text: 'Sign up', 
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupPage()));
                      }, 
                      pageRoute: const SignupPage(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}