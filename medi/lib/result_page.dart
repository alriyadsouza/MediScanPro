import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String scannedData;

  ResultPage(this.scannedData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Result'),
      ),
      body: Center(
        child: Text(
          'Scanned QR Code Data:\n$scannedData',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
