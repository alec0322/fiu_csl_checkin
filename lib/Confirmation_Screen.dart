// This screen will pop up after scanning a QR code showing the item's information
// and asking if the user is sure they wish to check out the item

import 'package:flutter/material.dart';
import 'QR_Scanner.dart';
import 'dashboard.dart';
import 'widgets.dart';

class ConfirmationPage extends StatefulWidget {

  final String scannedData;

  const ConfirmationPage({Key? key, required this.scannedData}) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPage();
}

class _ConfirmationPage extends State<ConfirmationPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 30, 63),
      appBar: AppBar(
        title: const Text(
          'Confirm rental',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const QRScannerScreen()));
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 33, 66, 116),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Scanned data: ${widget.scannedData}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16
              ),
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              text: 'Accept',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Dashboard()));
              },
              pageRoute: Dashboard(),
            )
          ],
        )
      ),
    );
  }
}