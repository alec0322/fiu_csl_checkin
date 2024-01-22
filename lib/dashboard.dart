// dashboard.dart
// Main page the user will see when logged in.

import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {

  const Dashboard({super.key});
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Successfully Logged In!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logout logic here
                print('Log out button pressed');
                // Example: Navigate back to the login screen
                Navigator.pop(context);
              },
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}