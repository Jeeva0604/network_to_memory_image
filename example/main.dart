import 'package:flutter/material.dart';
import 'package:network_to_memory_image/network_to_memory_image.dart';
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uint8List? _singleImage;
  List<Uint8List?> _multipleImages = [];
  bool _isLoadingSingle = true;
  bool _isLoadingMultiple = true;

  @override
  void initState() {
    super.initState();
    _loadSingleImage();
    _loadMultipleImages();
  }

  /// Load a single network image and convert it to memory
  Future<void> _loadSingleImage() async {
    final imageBytes = await NetworkToMemoryImage.loadSingle(
      "https://picsum.photos/200", // Example image URL
    );

    setState(() {
      _singleImage = imageBytes;
      _isLoadingSingle = false;
    });
  }

  /// Load multiple network images and convert them to memory
  Future<void> _loadMultipleImages() async {
    List<String> imageUrls = [
      "https://picsum.photos/200?random=1",
      "https://picsum.photos/200?random=2",
      "https://picsum.photos/200?random=3",
    ];

    final images = await NetworkToMemoryImage.loadMultiple(imageUrls);

    setState(() {
      _multipleImages = images;
      _isLoadingMultiple = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Network to Memory Image Example")),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),

              /// Single Image Example
              Text("Single Image",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _isLoadingSingle
                  ? CircularProgressIndicator()
                  : _singleImage != null
                      ? Image.memory(_singleImage!)
                      : Text("Failed to load image",
                          style: TextStyle(color: Colors.red)),

              SizedBox(height: 30),

              /// Multiple Images Example
              Text("Multiple Images",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _isLoadingMultiple
                  ? CircularProgressIndicator()
                  : _multipleImages.isNotEmpty
                      ? Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _multipleImages.map((imgBytes) {
                            return imgBytes != null
                                ? Image.memory(imgBytes,
                                    width: 100, height: 100, fit: BoxFit.cover)
                                : Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey,
                                    child: Icon(Icons.broken_image,
                                        color: Colors.white),
                                  );
                          }).toList(),
                        )
                      : Text("Failed to load images",
                          style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
