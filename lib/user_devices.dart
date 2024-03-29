import 'package:flutter/material.dart';
import 'dashboard.dart';

class UserDevices extends StatefulWidget {

  const UserDevices({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDevices> createState() => _UserDevices();
}

class _UserDevices extends State<UserDevices> {

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
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Dashboard()));
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
              const SizedBox(height: 250),
              Center(
                child: Text(
                  'You are not renting any devices at the moment',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}