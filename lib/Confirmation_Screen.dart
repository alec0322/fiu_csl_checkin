// This screen will pop up after scanning a QR code showing the item's information
// and asking if the user is sure they wish to check out the item

import 'package:flutter/material.dart';


class Confirmation_Screen extends StatelessWidget {
  final String scannedData;

  // Constructor
  Confirmation_Screen(this.scannedData);


  @override
  Widget build(BuildContext context) {
    // Build your new screen UI here
    return Scaffold(
      appBar: AppBar(
        title: Text('New Screen'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text('Scanned Data: $scannedData'),
      ),
    );
  }
}
