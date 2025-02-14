import 'package:aadhar_text_extractor/form_extracted.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String _recognizedText = 'Select an image to recognize text.';

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _performTextRecognition();
    }
  }

  void _extractAadharNumber(String text, Map<String, String> data) {
    final aadharRegex = RegExp(r'^[0-9]{4}\s?[0-9]{4}\s?[0-9]{4}$');
    if (aadharRegex.hasMatch(text)) {
      data['aadharNumber'] = text.replaceAll(' ', '');
    }
  }

  void _extractName(String text, Map<String, String> data) {
    final fullNameRegExp =
        RegExp(r"^[A-Za-z]{2,30}\s[A-Za-z]{2,30}\s[A-Za-z]{2,30}$");

    if (fullNameRegExp.hasMatch(text)) {
      final parts = text.split('-');
      data['name'] = parts.last.trim();
    }
  }

  void _extractDOB(String text, Map<String, String> data) {
    final RegExp dobRegExp = RegExp(r".*DOB[:\-]?\s*(\d{2}/\d{2}/\d{4})");
    final match = dobRegExp.firstMatch(text);

    if (match != null) {
      data['dob'] = match.group(1)!;
    }
  }

  void _extractGender(String text, Map<String, String> data) {
    if (text.toLowerCase().contains('male')) {
      data['gender'] = 'Male';
    } else if (text.toLowerCase().contains('female')) {
      data['gender'] = 'Female';
    }
  }

  Map<String, String> extractedData = {
    'aadharNumber': '',
    'name': '',
    'dob': '',
    'gender': ''
  };

  Future<void> _performTextRecognition() async {
    if (_image == null) return;

    extractedData = {'aadharNumber': '', 'name': '', 'dob': '', 'gender': ''};

    final inputImage = InputImage.fromFile(_image!);
    final textRecognizer = TextRecognizer();

    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          _extractAadharNumber(line.text, extractedData);
          _extractName(line.text, extractedData);
          _extractDOB(line.text, extractedData);
          _extractGender(line.text, extractedData);
          print(line.text);
        }
      }
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FormExtracted(
                      name: extractedData['name'],
                      dob: extractedData['dob'],
                      gender: extractedData['gender'],
                      aadhar: extractedData['aadharNumber'],
                    )));
      });
    } catch (e) {
      setState(() {
        _recognizedText = 'Error occurred : $e';
      });
    } finally {
      textRecognizer.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aadhar Text Extractor'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image != null
                  ? Image.file(
                      _image!,
                      height: 300,
                    )
                  : Icon(
                      Icons.image,
                      size: 100,
                    ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(extractedData['name']!),
              Text(extractedData['dob']!),
              Text(extractedData['gender']!),
              Text(extractedData['aadharNumber']!),
              Text(extractedData.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
