// login.dart
// Login page of the application.

import 'package:flutter/material.dart';
import 'widgets.dart';
import 'dashboard.dart';

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
      appBar: AppBar(
        title: const Text(
          'Back to home',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 8, 30, 63),
      ),
      body: Container(
        color: const Color.fromARGB(255, 8, 30, 63),
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please use your myFIU credentials',
              textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                )
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Username', 
              controller: usernameController,
              onChanged: (value) {
                setState(() {
                      
                });
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Password', 
              controller: passwordController,
              onChanged: (value) {
                setState(() {
                      
                });
              }
            ),
            const SizedBox(height: 20),
            DashboardLoginButton(
              usernameController: usernameController,
              passwordController: passwordController,
            ),
          ],
        ),
      ),
    );
  }
}

// Redirects the user to dashboard page (dashboard.dart)
class DashboardLoginButton extends StatelessWidget {

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const DashboardLoginButton({
    Key? key,
    required this.usernameController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      onPressed: () {
        String username = usernameController.text;
        String password = passwordController.text;

        if (username.isNotEmpty && password.isNotEmpty) {
          // To implement
          print('Username: $username');
          print('Password: $password');

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        } else {
          // To implement
          print('Please enter both username and password');
        }
      },
      child: const Text('Log in'),
    );
  }
}