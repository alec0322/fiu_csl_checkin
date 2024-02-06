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

    void _onQRViewCreated(QRViewController controller) {
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) {
        print('Scanned data: ${scanData.code}');
        // Do something with the scanned QR code data
      });
    }
  
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }
  }
