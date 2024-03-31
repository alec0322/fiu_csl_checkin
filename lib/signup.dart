// signup.dart
// Signup page of the application

import 'package:fiu_csl_checkin/login.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
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
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  int _currentStep = 0;
  bool _step1Complete = false;
  bool _step2Complete = false;
  bool _step3Complete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 30, 63),
      appBar: AppBar(
        title: const Text(
          'Sign up',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 33, 66, 116),
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
                    content: Text('Please input both your first and last name'),
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
          } else if (_currentStep == 2) {
            if (passwordController.text.isNotEmpty && passwordConfirmationController.text.isNotEmpty) {
              if (passwordController.text != passwordConfirmationController.text) {
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      title: Text('Error'),
                      content: Text('Passwords do not match'),
                    );
                  }
                );   
              } else {
                setState(() {
                  _step3Complete = true;
                });
              }      
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text('Error'),
                    content: Text('Please input matching passwords')
                  );
                }
              );
            }
          }                    
          if (_step1Complete && _step2Complete && _step3Complete) {
            registerUser();            
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
              const SizedBox(width: 15),
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
          Step (
            title: const Text(
              'Create Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
              )
            ),
            content: Column(
              children: [
                CustomTextField(
                  hintText: 'Password',
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Confirm Password', 
                  controller: passwordConfirmationController
                ),
                const SizedBox(height: 20),
              ],
            ),
            isActive: _currentStep == 2,
            state: _step3Complete ? StepState.indexed : StepState.disabled,
          )
        ],
      ),
    );
  }

  void registerUser() async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Create a new ParseUser object
    final user = ParseUser.createUser(username, password, email);

    // Set additional necessary fields
    user.set<String>('firstName', firstName);
    user.set<String>('lastName', lastName);

    var response = await user.signUp();

    if (response.success) {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('All done!'),
            content: Text('Your account has been successfully created'),
            actions: <Widget>[
              CustomTextButton(
                text: 'Log in', 
                pageRoute: const LoginPage(),
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
            content: Text(response.error!.message),
          );
        }
      );   
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }
}