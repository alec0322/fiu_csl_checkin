import 'dart:async';

import 'package:fiu_csl_checkin/Confirmation_Screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dashboard.dart';

class QRScannerScreen extends StatefulWidget {

  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 30, 63),
      appBar: AppBar(
        title: Text(
          'Scan an item...',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Dashboard()));
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 33, 66, 116),
      ),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  bool navigated = false; // Add this variable to the state

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Check if navigation has already occurred
      if (!navigated) {
        print('Scanned data: ${scanData.code}');
        // Set the flag to true to prevent multiple navigations
        navigated = true;

        // Ensure the widget is still mounted before navigating
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConfirmationPage(scannedData: scanData.code ?? "")),
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
