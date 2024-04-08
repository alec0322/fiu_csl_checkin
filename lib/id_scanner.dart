import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'interface/text_recognizer.dart';
import 'package:image_picker/image_picker.dart';
import 'widgets.dart';
import 'login.dart';
import 'dashboard.dart';

class MLKitTextRecognizer extends ITextRecognizer {
  late TextRecognizer recognizer;

  MLKitTextRecognizer() {
    recognizer = TextRecognizer();
  }

  void dispose() {
    recognizer.close();
  }

  @override
  Future<String> processImage(String imgPath) async {
    final image = InputImage.fromFile(File(imgPath));
    final recognized = await recognizer.processImage(image);
    return recognized.text;
  }
}

class RecognitionResponse {
  final String imgPath;
  final String recognizedText;

  RecognitionResponse({
    required this.imgPath,
    required this.recognizedText,
  });

  @override
  bool operator == (covariant RecognitionResponse other) {
    if (identical(this, other)) return true;

    return other.imgPath == imgPath && other.recognizedText == recognizedText;
  }

  @override
  int get hashCode => imgPath.hashCode ^ recognizedText.hashCode;
}

class IDScanner extends StatefulWidget {

  const IDScanner({
    Key? key,
  }) : super(key: key);

  @override
  State<IDScanner> createState() => _IDScanner();
}

class _IDScanner extends State<IDScanner> {

  TextEditingController nameController = TextEditingController();
  TextEditingController pantherIDController = TextEditingController();

  late ImagePicker _picker;
  late ITextRecognizer _recognizer;
  RecognitionResponse? _response;

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    _recognizer = MLKitTextRecognizer();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    pantherIDController.dispose();
    if(_recognizer is MLKitTextRecognizer) {
      (_recognizer as MLKitTextRecognizer).dispose();
    }
  }

  Future<String?> obtainImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    return file?.path;
  }

  Widget imagePickAlert({
    void Function()? onCameraPressed,
    void Function()? onGalleryPressed,
  }) {
    return AlertDialog(
      title: const Text(
        'Pick a source:',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column (
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text(
              'Camera',
            ),
            onTap: onCameraPressed,
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text(
              'Gallery',
            ),
            onTap: onGalleryPressed,
          )
        ],
      ),
    );
  }

  void updateTextFields(String name, String pantherID) {
    setState(() {
      nameController.text = name;
      pantherIDController.text = pantherID;
    });
  }

  void processImage(String imgPath) async {
    final recognizedText = await _recognizer.processImage(imgPath);
    setState(() {
      _response = RecognitionResponse(imgPath: imgPath, recognizedText: recognizedText);
      processRecognizedText(_response!.recognizedText);
    });
  }

  void processRecognizedText(String recognizedText) {
    List<String> lines = recognizedText.split('\n');

    // Assuming the ID is scanned properly, the name will be on the 3rd line
    // and the PID will be on the 4th line of the 'recognizedText'
    String name = lines[2];
    List<String> splitName = name.split(' ');
    String firstName = splitName[0];
    firstName = '${firstName[0].toUpperCase()}${firstName.substring(1).toLowerCase()}';
    String lastName = splitName[1];
    lastName = '${lastName[0].toUpperCase()}${lastName.substring(1).toLowerCase()}';
    String formattedName = firstName + ' ' + lastName;

    String pid = lines[3].substring(3);
    pid = pid.replaceAll(RegExp(r'\s+'), '');

    print(formattedName);
    print(pid);

    updateTextFields(formattedName, pid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 30, 63),
      appBar: AppBar(
        title: const Text(
          'FIU One Card Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
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
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 8, 30, 63),
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'You may enter the details yourself or scan your card:',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 25),
              CustomTextField(
                hintText: 'Name (First & Last)',
                controller: nameController
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: 'Panther ID',
                controller: pantherIDController
              ),
              const SizedBox(height: 40),
              ElevatedButton(                
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => imagePickAlert(
                      onCameraPressed: () async {
                        // Pick image from Camera
                        final imgPath = await obtainImage(ImageSource.camera);
                        if (imgPath == null) return;
                        processImage(imgPath);
                        Navigator.of(context).pop();
                      },
                      onGalleryPressed: () async {
                        // Pick image from Gallery
                        final imgPath = await obtainImage(ImageSource.gallery);
                        if (imgPath == null) return;
                        processImage(imgPath);
                        Navigator.of(context).pop();
                      }
                    )
                  );
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(100, 50),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 33, 66, 116)
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                  ),
                ),
                child: const Text(
                  'Scan One Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text(
                  'Proceed to dashboard',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),
                onPressed: () async {
                  if (nameController.text.isNotEmpty && pantherIDController.text.isNotEmpty) {

                    var name = nameController.text;
                    var pantherId = pantherIDController.text;
                    bool userExists = await checkUserExists(name, pantherId);
                    
                    // Check if the ID has ever been used before
                    if (!userExists) {
                      // If not, register User
                      registerUser(name, pantherId);
                    }

                    String? userObjectId = await getObjectIdByPantherId(pantherId);

                    // Here the One Card login is guaranteed to be true
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard(isOneCardLogin: true, userObjectId: userObjectId)));
                  } else {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Please make sure both fields are filled'),
                        );
                      }
                    );  
                  }
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(100, 50),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 33, 66, 116)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> checkUserExists(name, pantherId) async {
    try {
      QueryBuilder<ParseObject> retrieveUser = QueryBuilder(ParseObject('PID_User'))
        ..whereEqualTo('pantherId', pantherId);

      ParseResponse apiResponse = await retrieveUser.query();

      List user = apiResponse.results ?? [];

      return user.isNotEmpty;
    } catch (e) {
      throw Exception('Error querying the database: $e');
    }
  }


  void registerUser(name, pantherId) async {
    ParseObject pidUser = ParseObject('PID_User');

    pidUser.set<String>('name', name);
    pidUser.set<String>('pantherId', pantherId);

    try {
      await pidUser.save();
      print('New PID User created successfully: ${pidUser.objectId}');
    } catch (e) {
      throw Exception('Failed to create new user: $e');
    }
  }

  Future<String?> getObjectIdByPantherId(String pantherId) async {
    try {
      QueryBuilder<ParseObject> queryBuilder = QueryBuilder<ParseObject>(ParseObject('PID_User'))
        ..whereEqualTo('pantherId', pantherId);

      ParseResponse response = await queryBuilder.query();

      List<ParseObject>? results = response.result;

      if (results != null && results.isNotEmpty) {
        return results[0].objectId;
      } else {
        return null;
      }
    } catch (e) {
      print('Error while fetching objectId: $e');
      return null;
    }
  }
}