import 'package:flutter/material.dart';
import 'package:food/UIscreen/qr%20result.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanComplete = false;
  String scannedCode = '';

  void resetScan() {
    setState(() {
      isScanComplete = false;
      scannedCode = '';
    });
  }

  static const bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Place QR code in Area',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    'Scanning will start automatically',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color you want
                  borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                ),
                clipBehavior: Clip.antiAlias, // Ensures that the content respects the border radius
                child: Stack(
                  children: [
                    MobileScanner(
                      onDetect: (BarcodeCapture barcodeCapture) {
                        if (!isScanComplete) {
                          setState(() {
                            isScanComplete = true;
                            scannedCode = barcodeCapture.barcodes.first.rawValue ?? "Unknown code";
                          });

                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: Result(qrData: scannedCode),
                            ),
                          );
                        }
                      },
                    ),
                    QRScannerOverlay(overlayColor: Colors.black.withOpacity(0.5)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
            Expanded(
              child: Container(
                color: bgColor,
                child: Text(
                  isScanComplete ? 'Scanned Code: $scannedCode' : 'Place QR code in Area',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
