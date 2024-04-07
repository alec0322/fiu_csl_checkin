// dashboard.dart
// Main page the user will see when logged in.

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'login.dart';
import 'qr_scanner.dart';
import 'widgets.dart';
import 'user_devices.dart';

class Dashboard extends StatelessWidget {

  const Dashboard({
    Key? key
  }) : super(key: key);

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
        child: PopScope (
        canPop: false,
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
                    topPadding: 4,
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
                    topPadding: 8,
                    leftPadding: 11,
                    pageRoute: QRScannerScreen(isReturn: false)
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
                    pageRoute: QRScannerScreen(isReturn: true)
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
                    onTap: () {
                      userLogout(context);
                    },
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
    )
    );
  }

  void userLogout(context) async {
    final user = await ParseUser.currentUser() as ParseUser;
    var response = await user.logout();

    if (response.success) {
      print('User successfully logged out');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
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
}
