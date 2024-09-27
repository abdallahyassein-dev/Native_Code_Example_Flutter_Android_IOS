// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? _processedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndProcessImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();
      final Uint8List? processed = await _processImage(imageBytes);
      setState(() {
        _processedImage = processed;
      });
    }
  }

  Future<Uint8List?> _processImage(Uint8List imageBytes) async {
    const platform = MethodChannel('opencv_channel');
    try {
      final Uint8List? result = await platform.invokeMethod<Uint8List>(
        'processImage',
        imageBytes,
      );
      return result;
    } on PlatformException catch (e) {
      print("Failed to process image: '${e.message}'.");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OpenCV with Flutter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_processedImage != null)
              Image.memory(_processedImage!)
            else
              Text('Pick an image to process'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickAndProcessImage,
              child: Text('Pick and Process Image'),
            ),
          ],
        ),
      ),
    );
  }
}
