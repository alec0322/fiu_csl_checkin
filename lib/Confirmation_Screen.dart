// This screen will pop up after scanning a QR code showing the item's information
// and asking if the user is sure they wish to check out the item

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Confirmation_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Screen'),
      ),
      body: Center(
        child: Text(
          'This is the new screen!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
