// dashboard.dart
// Main page the user will see when logged in.

import 'package:flutter/material.dart';
import 'login.dart';
import 'qr_scanner.dart';
import 'widgets.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 33, 66, 116),
      ),
      backgroundColor: const Color.fromARGB(255, 8, 30, 63),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Successfully Logged In!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextButton(
                text: 'Log out', 
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                }, 
                pageRoute: const LoginPage(),
              ),
              const SizedBox(height: 120),
              CustomTextButton(
                text: 'Item check out', 
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => QRScannerScreen()));
                }, 
                pageRoute: QRScannerScreen(),
              ),              
              const SizedBox(height: 10),
              CustomTextButton(
                text: 'Return items', 
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => QRScannerScreen()));
                },
                pageRoute: QRScannerScreen(),
              ),
              const SizedBox(height: 80),              
            ],
          ),
        ),
      ),
    );
  }
}
