// signup.dart
// Signup page of the application

import 'package:flutter/material.dart';
import 'widgets.dart';

class SignupPage extends StatefulWidget {

  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {

  // Controllers to store user input
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  int _currentStep = 0;
  bool _step1Complete = false;
  bool _step2Complete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 30, 63),
      appBar: AppBar(
        title: const Text(
          'Back to login',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 8, 30, 63),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0) {
            if (firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty) {
              setState(() {
                _step1Complete = true;
                _currentStep++;
              });
            } else {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text('Error'),
                    content: Text('Please input both first and last name'),
                  );
                }
              );
            }
          } else if (_currentStep == 1) {
            if (usernameController.text.isNotEmpty && emailController.text.isNotEmpty) {
              setState(() {
                _step2Complete = true;
                _currentStep++;
              });
            } else {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text('Error'),
                    content: Text('Please input both a username and an email'),
                  );
                }
              );
            }
          } else {
            // Perform final step actions here
            // For example, submite form data
            _submitForm();
          }
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep--;
            } else {
              _currentStep = 0;
            }
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Row(
            children: [
              ElevatedButton(
                onPressed: details.onStepContinue,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 33, 66, 116)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )
                ),
              ),

              const SizedBox(width: 15),
              
              ElevatedButton(
                onPressed: details.onStepCancel,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 33, 66, 116)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )
                ),
              ),
            ],
          );
        },
        steps: [
          Step(
            title: const Text(
              'Personal Information',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
              )
            ),
            content: Column(
              children: [
                CustomTextField(
                  hintText: 'First Name',
                  controller: firstNameController,
                ),
                  
                const SizedBox(height: 20),

                CustomTextField(
                  hintText: 'Last Name',
                  controller: lastNameController,                  
                ),

                const SizedBox(height: 20)
              ],
            ),
            isActive: _currentStep == 0,
            state: _step1Complete ? StepState.indexed : StepState.disabled,
          ),
          Step(
            title: const Text(
              'Account Information',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
              )
            ),
            content: Column(
              children: [
                CustomTextField(
                  hintText: 'Username',
                  controller: usernameController,                  
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  hintText: 'Email',
                  controller: emailController,                  
                ),

                const SizedBox(height: 20),
              ],
            ),
            isActive: _currentStep == 1,
            state: _step2Complete ? StepState.indexed : StepState.disabled,
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    // Perform form submission logic here
    // For example, print the entered data
    print('First Name: ${firstNameController.text}');
    print('Last Name: ${lastNameController.text}');
    print('Username: ${usernameController.text}');
    print('Email: ${emailController.text}');
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}