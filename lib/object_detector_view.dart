// ignore_for_file: use_build_context_synchronously, unused_import, unnecessary_import, prefer_const_constructors_in_immutables, depend_on_referenced_packages, unused_field, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:untitled4/constants/app_size.dart';
import 'package:untitled4/constants/colors.dart';
import 'package:untitled4/show_summary.dart';
import 'package:untitled4/widgets/CustomDrawer%20.dart';

class ObjectDetectorView extends StatefulWidget {
  ObjectDetectorView({
    Key? key,
    required this.title,
    this.text,
    required this.onImage,
  }) : super(key: key);

  final String title;
  final String? text;
  final Function(InputImage inputImage) onImage;

  @override
  State<ObjectDetectorView> createState() => _ObjectDetectorViewState();
}

class _ObjectDetectorViewState extends State<ObjectDetectorView> {
  File? _image;
  String? _path;
  ImagePicker? _imagePicker;
  final bool _allowPicker = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _summarizeImage() async {
    if (_image != null) {
      try {
        List<int> imageBytes = await _image!.readAsBytes();

        const String apiEndpoint =
            'https://imagecaptionapi.cognitiveservices.azure.com/vision/v3.1/describe';

        final response = await http.post(
          Uri.parse(apiEndpoint),
          headers: {
            'Content-Type': 'application/octet-stream',
            'Ocp-Apim-Subscription-Key': '9116bddf7079419db31c35f1514f6bc4',
          },
          body: imageBytes,
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = json.decode(response.body);

          if (responseData.containsKey('description')) {
            List<dynamic> captions = responseData['description']['captions'];

            if (captions.isNotEmpty) {
              String captionText = captions[0]['text'];
              double confidence = captions[0]['confidence'];

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SummaryPage(
                    captionText: captionText,
                    detectedObjects:
                        'Summary: $captionText\nConfidence: ${(confidence * 100).toStringAsFixed(2)}',
                    apiImage: _image!,
                  ),
                ),
              );
            } else {
              showSummaryDialog('Error: No captions found in the response');
            }
          } else {
            showSummaryDialog('Error: Invalid response format');
          }
        } else {
          showSummaryDialog('Error: ${response.reasonPhrase}');
        }
      } catch (e) {
        print(e.toString());
        showSummaryDialog('Error: $e');
      }
    } else {
      showSummaryDialog('Error: No image selected');
    }
  }

  void showSummaryDialog(String summary) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Summary'),
          content: Text(summary),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //      showHelpDialog(context);
      //   },
      //   child: const Icon(
      //     Icons.question_mark_rounded,
      //     size: 35,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            _galleryBody(),
            const SizedBox(
              height: 140,
            ),
          ],
        ),
      ),
    );
  }

  // void showHelpDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //         ),
  //         backgroundColor: Colors.white,
  //         child: Container(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               const Text(
  //                 "Help",
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //               const Text(
  //                 "Welcome to Summify!",
  //                 style: TextStyle(fontSize: 20, color: Colors.green),
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               const Align(
  //                 alignment: Alignment.center,
  //                 child: Text(
  //                   "Launch the Summify app and select the image you want to summarize. Upon completion of the image upload process, click the Summarize button to initiate the automated summarization process.",
  //                   textAlign: TextAlign.justify,
  //                   style: TextStyle(fontSize: 14, color: Colors.black),
  //                 ),
  //               ),
  //               const SizedBox(height: 20),
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text(
  //                   "Close",
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _galleryBody() {
    return ListView(
      shrinkWrap: true,
      children: [
        _image != null
            ? Center(
                child: SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Image.file(_image!),
                ),
              )
            : const Icon(
                Icons.image,
                size: 300,
              ),
        70.h,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: SizedBox(
            height: 45,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color(0xff1C232D),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Text(
                'Select from Gallery',
                style: TextStyle(fontSize: 20, color: Colors.yellow),
              ),
              onPressed: () => _getImage(ImageSource.gallery),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: SizedBox(
            height: 45,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color(0xff1C232D),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20, width: 20, child: CircularProgressIndicator())
                  : const Text(
                      'Summarize',
                      style: TextStyle(fontSize: 20, color: Colors.yellow),
                    ),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await _summarizeImage();
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ),
        ),
        if (_image != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                '${_path == null ? '' : 'Image path: $_path'}\n\n${widget.text ?? ''}'),
          ),
      ],
    );
  }

  Future<void> _getImage(ImageSource source) async {
    setState(() {
      _image = null;
      _path = null;
    });

    final pickedFile = await _imagePicker?.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
