import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultPage extends StatefulWidget {
  final String scannedData;

  ResultPage(this.scannedData);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String translatedData = '';
  bool isTranslated = false;
  bool isLoading = false;

  Future<void> translateData(String language) async {
    setState(() {
      isLoading = true;
    });

    String targetLang;
    if (language == 'Kannada') {
      targetLang = 'kn';
    } else if (language == 'Hindi') {
      targetLang = 'hi';
    } else {
      return;
    }

    final response = await http.get(
      Uri.parse(
          'https://api.mymemory.translated.net/get?q=${Uri.encodeComponent(widget.scannedData)}&langpair=en|$targetLang'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        translatedData = jsonResponse['responseData']['translatedText'];
        isTranslated = true;
        isLoading = false;
      });
    } else {
      setState(() {
        translatedData = 'Translation failed';
        isTranslated = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Result'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[200]!, Colors.teal[800]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code,
                  size: 100,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  'Scanned QR Code Data:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  isTranslated ? translatedData : widget.scannedData,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 30),
                isLoading
                    ? CircularProgressIndicator()
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => translateData('Kannada'),
                      child: Text('Translate to Kannada'),
                    ),
                    SizedBox(),
                    ElevatedButton(
                      onPressed: () => translateData('Hindi'),
                      child: Text('Translate to Hindi'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}