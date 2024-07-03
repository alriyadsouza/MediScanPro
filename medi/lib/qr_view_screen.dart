import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medi/result_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewScreen extends StatefulWidget {
  @override
  _QRViewScreenState createState() => _QRViewScreenState();
}

class _QRViewScreenState extends State<QRViewScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          Positioned.fill(
            child: Center(
              child: (result != null)
                  ? Text(
                'Scanned Data: ${result!.code}',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
                  : Text(
                'Scan a QR code',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        // Navigate to result page if result is not null
        if (result != null && result!.code != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(result!.code!),
            ),
          );
        }
      });
    });
  }



  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
