// This screen will pop up after scanning a QR code showing the item's information
// and asking if the user is sure they wish to check out the item

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'qr_scanner.dart';
import 'dashboard.dart';
import 'widgets.dart';

class ConfirmationPage extends StatefulWidget {

  final ParseObject device;
  final bool isOneCardLogin;
  final String? userObjectId;

  const ConfirmationPage({
    Key? key,
    required this.device,
    required this.isOneCardLogin,
    required this.userObjectId
  }) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPage();
}

class _ConfirmationPage extends State<ConfirmationPage> {

  ParseUser? currentUser;

  TextEditingController rentalDaysController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Handle user session regularly if the user has an account
    print(widget.userObjectId);
    if (!widget.isOneCardLogin) {
      getCurrentUser();
    }
    print('Current device: ${widget.device}');
  }

  void getCurrentUser() async {
    ParseUser user = await ParseUser.currentUser();
    setState(() {
      currentUser = user;
    });
  }

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
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => QRScannerScreen(isReturn: false, isOneCardLogin: widget.isOneCardLogin, userObjectId: widget.userObjectId)));
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
                  'Scanned device:\n${widget.device.get<String>('deviceName')}',
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
                  onPressed: () {
                    print('Renting...');
                    rentDevice(widget.device);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Success'),
                          content: Text('You have successfully rented the ${widget.device['deviceName']}'),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                // Close the dialog
                                Navigator.of(context).pop();

                                // Redirect the user to the dashboard
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard(isOneCardLogin: widget.isOneCardLogin, userObjectId: widget.userObjectId)));
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },         
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> rentDevice(ParseObject device) async {
     try {

      if (widget.isOneCardLogin) {
        print(widget.userObjectId);
        device..set('currentRenter', widget.userObjectId);
      }
      else {
        device..set('currentRenter', currentUser!.objectId);
      }

      // Calculate rental time based on given rental days
      int rentalDays = int.parse(rentalDaysController.text.trim());
      DateTime startDate = DateTime.now();
      DateTime endDate = startDate.add(Duration(days: rentalDays));

      device..set('rentedOn', startDate);
      device..set('rentedUntil', endDate);

      final ParseResponse updateResponse = await device.save();

      if (updateResponse.success) {
        print('Device updated successfully: ${updateResponse.result}');
      } else {
        print('Error updating object: ${updateResponse.error}');
      }
    }
    catch (e) {
      throw Exception('Error querying the database: $e');
    }
  }
}