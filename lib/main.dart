// main.dart
// Main page of the application, for security purposes the user should always
// be asked to login.

import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'widgets.dart';
import 'login.dart';
import 'dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = 'h5XaqSeulft0D8Chkuk4LmaGFdkhcpR0MzVj8Jgm';
  final keyClientKey = 't56zEH1VUF0MYCnQOyxaGFzfrMThx6UjCISRecnh';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
    clientKey: keyClientKey, autoSendSessionId: true);

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
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 33, 66, 116),
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(image: AssetImage('assets/cslLabLogo.png'), height: 250, width: 250),
                const SizedBox(height: 80),              
                CustomTextButton(
                  text: 'Log in',
                  pageRoute: const LoginPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}