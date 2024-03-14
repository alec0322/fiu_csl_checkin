// login.dart
// Login page of the application.

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
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
          'Welcome!',
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
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        width: 100,
                        child: TextButton(
                          child: const Text(
                            'Log in',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),
                          ),
                          onPressed: () {
                            if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                              userLogin();
                            } else {
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text('Please input both username and password'),
                                  );
                                }
                              );  
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
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    Expanded(
                      child: CustomTextButton(
                        text: 'Sign up', 
                        pageRoute: const SignupPage(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  void userLogin() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      setState(() {});
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Dashboard()));
    } else {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(response.error!.message),
          );
        }
      );   
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }
}