// This screen will pop up after scanning a QR code showing the item's information
// and asking if the user is sure they wish to check out the item

import 'package:flutter/material.dart';
import 'qr_scanner.dart';
import 'dashboard.dart';
import 'widgets.dart';

class ConfirmationPage extends StatefulWidget {

  final String scannedData;

  const ConfirmationPage({
    Key? key,
    required this.scannedData,
  }) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPage();
}

class _ConfirmationPage extends State<ConfirmationPage> {

  TextEditingController rentalDaysController = TextEditingController();

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
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 8, 30, 63),
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Scanned device: *ITEM NAME* ${widget.scannedData}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 25),
              Center(
                child: Text(
                  'Please enter the number of days you would like to rent the device:',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 25),
              CustomTextField(
                hintText: 'Days to rent...',
                controller: rentalDaysController,
                onChanged: (value) {
                  setState(() {});
                }
              ),
              if (rentalDaysController.text.isNotEmpty) ...[
                SizedBox(height: 25),
                Center(
                  child: Text(
                    'By tapping the "Confirm" button below, you assume responsibility of the device specified above for ${rentalDaysController.text} days.',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 30),
                CustomTextButton(
                  text: 'Confirm',
                  // IMPLEMENT 'onTap' LOGIC TO PROCESS USER RENTAL ON DATABASE
                  pageRoute: Dashboard(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}