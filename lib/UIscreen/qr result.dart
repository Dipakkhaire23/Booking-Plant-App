import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart'; // Import for clipboard functionality

class Result extends StatelessWidget {
  final String qrData;

  const Result({Key? key, required this.qrData}) : super(key: key);

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: qrData)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Copied to clipboard!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to copy: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Show QR Code
              // QrImage(
              //   data: qrData,
              //   size: 150,
              //   version: QrVersions.auto,
              // ),
              const SizedBox(height: 20), // Add some space
              ElevatedButton(
                onPressed: () => _copyToClipboard(context),
                child: const Text("Copy"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}