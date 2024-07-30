import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mediscanproo/result_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mediscanproo/text_to_speech_screen.dart'; // Import the TextToSpeechScreen
import 'package:mediscanproo/result_page.dart';

class QRViewScreen extends StatefulWidget {
  @override
  _QRViewScreenState createState() => _QRViewScreenState();
}

class _QRViewScreenState extends State<QRViewScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool flashOn = false;

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
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.teal,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: Icon(flashOn ? Icons.flash_on : Icons.flash_off, color: Colors.white),
              onPressed: () {
                setState(() {
                  flashOn = !flashOn;
                });
                controller?.toggleFlash();
              },
            ),
          ),
          Center(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (result != null) ...[
                      Text(
                        'Scanned Data:',
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${result!.code}',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TextToSpeechScreen(text: result!.code!),
                            ),
                          );
                        },
                        child: Text('Speak', style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultPage(result!.code!),
                            ),
                          );
                        },
                        child: Text('Translate to Kannada'),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultPage(result!.code!),
                            ),
                          );
                        },
                        child: Text('Translate to Hindi'),
                      ),
                    ] else ...[
                      Text(
                        'Scan a QR code',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                      ),
                    ],
                  ],
                ),
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
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
