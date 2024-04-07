import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'dashboard.dart';

class UserDevices extends StatefulWidget {

  final bool isOneCardLogin;
  final String? userObjectId;

  const UserDevices({
    Key? key,
    required this.isOneCardLogin,
    required this.userObjectId
  }) : super(key: key);

  @override
  State<UserDevices> createState() => _UserDevices();
}

class _UserDevices extends State<UserDevices> {

  ParseUser? currentUser;

  @override
  void initState() {
    super.initState();
    // Handle user session regularly if the user has an account
    if (!widget.isOneCardLogin) {
      getCurrentUser();
    }
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
          'My Devices',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dashboard(isOneCardLogin: widget.isOneCardLogin, userObjectId: widget.userObjectId)));
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 33, 66, 116),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchDevicesRented(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the future is still running, show a loading indicator
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.data!.isEmpty) {
              return SingleChildScrollView(
                child: Container(
                  color: const Color.fromARGB(255, 8, 30, 63),
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 200),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [                                                    
                          Center(
                            child: Icon(CupertinoIcons.exclamationmark, color: Colors.white, size: 50),
                          ),
                          SizedBox(height: 60),
                          Text(
                            'You are not renting any devices at the moment',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              // User is renting at least 1 device, show appropriate UI
              return Column(
                children: [
                  SizedBox(height: 30),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          
                          // Extract device information
                          var device = snapshot.data![index];
                          String deviceName = device['deviceName'];
                          DateTime rentedOn = device['rentedOn'];
                          DateTime rentedUntil = device['rentedUntil'];
                          
                          String rentedOnFormatted = DateFormat('MMMM dd, yyyy').format(rentedOn);
                          String rentedUntilFormatted = DateFormat('MMMM dd, yyyy').format(rentedUntil);

                          // Display each device in the list
                          return Column(
                            children: [                            
                              ListTile(
                                title: Column (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      deviceName,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      'Rented on: $rentedOnFormatted\nUntil: $rentedUntilFormatted',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: Divider(
                                  color: Color.fromARGB(255, 182, 134, 44),
                                  thickness: 2,
                                  height: 10,
                                ),
                              ),
                            ],
                          );
                        }
                      ),
                    )
                  ),
                ],
              );
            }
          }
        },
      )
    );
  }

  Future<List<dynamic>>? fetchDevicesRented() async {
    try {

      String? objectId = widget.userObjectId != null ? widget.userObjectId! : currentUser!.objectId;

      QueryBuilder<ParseObject> retrieveDevices = QueryBuilder<ParseObject>(ParseObject('Devices'))
        ..whereEqualTo('currentRenter', objectId);

      ParseResponse apiResponse = await retrieveDevices.query();

      if (apiResponse.results == null) {
        // The user is not renting any devices
        return [];
      } else if (apiResponse.success) {
        List<dynamic> devices = apiResponse.results!;
        print(devices);
        return devices;
      } else {
        throw Exception('The user is not renting any devices');
      }
    } catch (e) {
      throw Exception('Failed to retrieve rented devices');      
    }
  }
}