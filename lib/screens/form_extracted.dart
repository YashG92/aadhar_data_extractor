import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormExtracted extends StatelessWidget {
  FormExtracted({super.key, this.name, this.dob, this.gender, this.aadhar});

  final name;
  final dob;
  final gender;
  final aadhar;

  late final nameController = TextEditingController(text: name);
  late final dobController = TextEditingController(text: dob);
  late final genderController = TextEditingController(text: gender);
  late final aadharController = TextEditingController(text: aadhar);

  final String scriptURL = 'https://script.google.com/macros/s/AKfycbzmTD7Ph7KK6nQtS8FDkGcn_rBzaOs2ffL5x3M9QWyVI27hlx0Muz_VYeunysqaiVcp/exec';


  Future<void> _submitData() async {
    final Map<String, dynamic> formData = {
      'name': nameController.text,
      'dob': dobController.text,
      'gender': genderController.text,
      'aadhar': aadharController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(scriptURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );

      if (response.statusCode == 200) {
        print('Data successfully sent to Google Sheets');
      } else {
        print('Failed to send data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Extracted'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Form(
                child: Column(
              spacing: 12,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  controller: dobController,
                  decoration: InputDecoration(
                    labelText: 'DOB',
                  ),
                ),
                TextFormField(
                  controller: genderController,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                  ),
                ),
                TextFormField(
                  controller: aadharController,
                  decoration: InputDecoration(
                    labelText: 'Aadhar Number',
                  ),
                ),

                ElevatedButton(onPressed: _submitData, child: Text('Submit')),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
