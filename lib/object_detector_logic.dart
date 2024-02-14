// ignore_for_file: use_key_in_widget_constructors, avoid_print, prefer_const_declarations, prefer_const_constructors

import 'dart:io' as io;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled4/constants/colors.dart';
import 'package:untitled4/widgets/CustomDrawer%20.dart';

import 'object_detector_view.dart';

class ObjectDetectorLogic extends StatefulWidget {
  @override
  State<ObjectDetectorLogic> createState() => _ObjectDetectorView();
}

class _ObjectDetectorView extends State<ObjectDetectorLogic> {
  late ObjectDetector _objectDetector;
  bool _canProcess = false;
  bool _isBusy = false;
  String? _text;

  @override
  void initState() {
    super.initState();
    _initializeDetector(DetectionMode.single);
  }

  @override
  void dispose() {
    _canProcess = false;
    _objectDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(user: FirebaseAuth.instance.currentUser),
      appBar: AppBar(
        backgroundColor: Color(0xff1C232D),
        // GlobalColors.GreyColor
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.yellow),
        title: Text(
          "Hi, Sabeeh",
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ObjectDetectorView(
        title: 'Summify',
        text: _text,
        onImage: (inputImage) {
          processImage(inputImage);
        },
      ),
    );
  }

  void _initializeDetector(DetectionMode mode) async {
    print('Set detector in mode: $mode');

    final path = 'assets/ml/object_labeler.tflite';
    final modelPath = await _getModel(path);
    final options = LocalObjectDetectorOptions(
      mode: mode,
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
    );
    _objectDetector = ObjectDetector(options: options);

    _canProcess = true;
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final objects = await _objectDetector.processImage(inputImage);

    String text = 'Objects found: ${objects.length}\n\n';
    for (final object in objects) {
      text += 'Object Identified :  ${object.labels.map((e) => e.text)}\n\n';
    }
    _text = text;
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<String> _getModel(String assetPath) async {
    if (io.Platform.isAndroid) {
      return 'flutter_assets/$assetPath';
    }
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await io.Directory(dirname(path)).create(recursive: true);
    final file = io.File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }
}
