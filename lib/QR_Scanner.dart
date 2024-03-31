import 'dart:async';
import 'dart:io';
import 'package:fiu_csl_checkin/checkout_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dashboard.dart';

class QRScannerScreen extends StatefulWidget {

  // Extremely important boolean, determines whether a scan is a return or rental
  final bool isReturn;

  const QRScannerScreen({
    Key? key,
    required this.isReturn,
  }) : super(key: key);

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {

  late ParseUser currentUser;
  String? objectId;
  StreamSubscription? scanSubscription;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    ParseUser user = await ParseUser.currentUser();
    setState(() {
      currentUser = user;
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 30, 63),
      appBar: AppBar(
        title: Text(
          'Scan a device...',
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
            child: _buildQRView(context)
          ),
        ],
      ),
    );
  }

  Widget _buildQRView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400)
      ? 150.0
      : 300.0;
    
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Color.fromARGB(255, 182, 134, 44),
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    scanSubscription = controller.scannedDataStream.listen((scanData) {
      setState(() {
        objectId = scanData.code;

        if (widget.isReturn) {
          returnDevice(currentUser);
        } else {
          proceedToCheckout();
        }
      });
    });
  }
  
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if(!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No permission')),
      );
    }
  }

  void returnDevice(ParseUser user) async {
    print('The user is returning a device');

    this.controller?.dispose();
    this.scanSubscription?.cancel();

    print('Scanned device: ${objectId}');

    // Check if device is being rented by the current user
    try {
      ParseObject device = await getDevice(objectId);

      if (device['currentRenter'] == user.objectId) {

        // Detach the user from the device... 
        device..set('currentRenter', null);

        // And set the rental dates to null
        device..set('rentedOn', null);
        device..set('rentedUntil', null);

        final ParseResponse updateResponse = await device.save();

        if (updateResponse.success) {
          showDialog(
            context: context, 
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('You have successfully returned the ${device['deviceName']}'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      // Close the dialog
                      Navigator.of(context).pop();
                      // Redirect the user to the dashboard
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard()));
                    },
                  )
                ],
              );
            }
          );
        } else {
          showDialog(
            context: context, 
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('There was an error updating the database'),
              );
            }
          );
        }        
      } else {
        showDialog(
          context: context, 
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('You are not renting this device'),
            );
          }
        );
      }      
    } catch (e) {
      throw Exception('Error querying the database: $e');
    }
  }

  void proceedToCheckout() async {
    print('The user is checking-out a device');
    
    this.controller?.dispose();
    this.scanSubscription?.cancel();

    print('Scanned device: ${objectId}');

    // Check if device scanned is already being rented
    bool rented = await isDeviceRented(objectId);

    if (!rented) {
      // Allow the user to proceed to rental confirmation
      ParseObject device = await getDevice(objectId);

      // Ensure the widget is still mounted before navigating
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmationPage(device: device)));
    } else {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('This device is already being rented'),
          );
        }
      );
    }
  }

  Future<ParseObject> getDevice(objectId) async {    
    try {
      QueryBuilder<ParseObject> retrieveDevice = QueryBuilder<ParseObject>(ParseObject('Devices'))
        ..whereEqualTo('objectId', objectId);

      ParseResponse apiResponse = await retrieveDevice.query();

      ParseObject device = apiResponse.results![0];

      return device;
    }
    catch (e) {      
      throw Exception('Error querying the database: $e');
    }
  }

  Future<bool> isDeviceRented(objectId) async {    
    try {
      ParseObject device = await getDevice(objectId);
      // Check if the device has a 'currentRenter'
      String? currentRenter = device.get<String>('currentRenter');
      String? deviceName = device.get<String>('deviceName');

      if (currentRenter == '' || currentRenter == null) {
        print('The $deviceName is not being rented');
        return false;
      } else {
        print('Someone is already renting this $deviceName');
        return true;
      }
    }
    catch (e) {
      throw Exception('Error querying the database: $e');
    }
  }

  @override
  void dispose() {
    scanSubscription?.cancel();
    controller?.dispose();
    super.dispose();
  }
}