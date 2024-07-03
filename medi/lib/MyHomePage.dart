   // Import 'dart:io' for Platform and Platform-specific checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medi/qr_view_screen.dart';




  class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text('Home'),
  ),
  body: Center(
  child: ElevatedButton(
  onPressed: () {
  // Navigate to QR code scanner screen
  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => QRViewScreen(),
  ),
  );
  },
  child: Text('Scan QR Code'),
  ),
  ),
  );
  }
  }