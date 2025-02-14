import 'dart:io';

import 'package:aadhar_text_extractor/screens/form_extracted.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  final ImagePicker _picker = ImagePicker();
  File? image;

  RxMap<String, String> extractedData = {
    'aadharNumber': '',
    'name': '',
    'dob': '',
    'gender': '',
  }.obs;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    await performTextRecognition();
    Get.to(()=>FormExtracted(name: extractedData['name'], dob: extractedData['dob'], gender: extractedData['gender'], aadhar: extractedData['aadharNumber'],));
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
  Future<void> performTextRecognition() async {
    if (image == null) return;


    final inputImage = InputImage.fromFile(image!);
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
        }
      }

    } catch (e) {
      throw Exception('Error performing text recognition: $e');
    } finally {
      textRecognizer.close();
    }
  }

}
