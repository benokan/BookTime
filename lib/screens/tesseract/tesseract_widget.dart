import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';

class TesseractScreen extends StatefulWidget {
  @override
  _TesseractScreenState createState() => _TesseractScreenState();
}

class _TesseractScreenState extends State<TesseractScreen> {
  String _ocrText = '';

  String path = "";
  bool bload = false;

  void runFilePicker() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _ocr(pickedFile.path);
    }
  }

  // takes path (url)
  void _ocr(url) async {
    path = url;

    bload = true;
    setState(() {});

    _ocrText = await FlutterTesseractOcr.extractText(url);

    bload = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    path.length <= 0
                        ? Container()
                        : Image.file(
                            File(path),
                          ),
                    bload
                        ? Column(children: [CircularProgressIndicator()])
                        : Center(
                          child: Column(
                            children: [
                              Text(
                                  '$_ocrText',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  child: Text("Add this to your Scanned list"),
                                  onPressed: (){
                                    // TODO: implement this but since we are using a static database 
                                    // which is initialized by us using Book instances created in books.dart.
                                    // Should fine a new approach to store this text in elsewhere ... 
                                  },

                                )
                            ],
                          ),
                        ),
                  ],
                ))
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: kIsWeb
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                runFilePicker();
                _ocr("");
              },
              tooltip: 'OCR',
              child: Icon(Icons.add),
            ),
    );
  }
}
