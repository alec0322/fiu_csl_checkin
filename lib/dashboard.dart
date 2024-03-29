// dashboard.dart
// Main page the user will see when logged in.

import 'package:flutter/material.dart';
import 'login.dart';
import 'qr_scanner.dart';
import 'widgets.dart';
import 'checkout_confirmation.dart';
import 'user_devices.dart';

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
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 33, 66, 116),
      ),
      backgroundColor: const Color.fromARGB(255, 8, 30, 63),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [              
              const SizedBox(height: 110),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomInkWell(
                    text: 'My Devices',
                    height: 150,
                    width: 150,
                    imgPath: 'assets/devices.png',
                    imgSize: 90,
                    topPadding: 7,
                    leftPadding: 13,
                    pageRoute: UserDevices()
                  ),
                  const SizedBox(width: 20),
                  CustomInkWell(
                    text: 'Check-out',
                    height: 150,
                    width: 150,
                    imgPath: 'assets/cart.png',
                    imgSize: 85,
                    topPadding: 10,
                    leftPadding: 11,
                    pageRoute: QRScannerScreen()
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomInkWell(
                    text: 'Return device',
                    height: 150,
                    width: 150,
                    imgPath: 'assets/undo.png',
                    imgSize: 70,
                    topPadding: 13,
                    leftPadding: 27,
                    pageRoute: QRScannerScreen()
                  ),
                  const SizedBox(width: 20),
                  CustomInkWell(
                    text: 'Log out',
                    height: 150,
                    width: 150,
                    imgPath: 'assets/logout.png',
                    imgSize: 65,
                    topPadding: 15,
                    leftPadding: 30,
                    pageRoute: LoginPage()
                  ),
                ],
              ),
              SizedBox(height: 80),
              Text(
                'For information on the CSL lab,',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'please visit: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  HyperlinkText(
                    text: 'https://csl.fiu.edu',
                    url: 'https://csl.fiu.edu',
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
