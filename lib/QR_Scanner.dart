  import 'package:fiu_csl_checkin/Confirmation_Screen.dart';
  import 'package:flutter/material.dart';
  import 'package:qr_code_scanner/qr_code_scanner.dart';

  class QRScannerScreen extends StatefulWidget {
    @override
    _QRScannerScreenState createState() => _QRScannerScreenState();
  }

  class _QRScannerScreenState extends State<QRScannerScreen> {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    late QRViewController controller;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('QR Scanner'),
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
        if (!navigated) { // Check if navigation has already occurred
          print('Scanned data: ${scanData.code}');
          navigated = true; // Set the flag to true to prevent multiple navigations

          // Ensure the widget is still mounted before navigating
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Confirmation_Screen(scanData.code ?? "")),
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
