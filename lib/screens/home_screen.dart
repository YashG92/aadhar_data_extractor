import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controller/image_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Aadhar Text Extractor'),
      ),
      body: Obx(
        ()=> Center(
          child: Column(
            children: [
              controller.image != null
                  ? Image.file(
                      controller.image!,
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
                onPressed: controller.pickImage,
                child: Text('Select Image'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(controller.extractedData['name']!),
              Text(controller.extractedData['dob']!),
              Text(controller.extractedData['gender']!),
              Text(controller.extractedData['aadharNumber']!),
            ],
          ),
        ),
      ),
    );
  }
}
