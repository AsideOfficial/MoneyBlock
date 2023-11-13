import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 220.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 33,
              borderLength: 30,
              borderWidth: 6,
              cutOutSize: scanArea,
              cutOutBottomOffset: 16,
            ),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),
          SafeArea(
            left: false,
            right: false,
            child: Column(
              children: [
                const SizedBox(height: 40.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 60.0),
                    Column(
                      children: [
                        const SizedBox(height: 10.0),
                        Text(
                          'QR코드 스캔하기',
                          style: Constants.defaultTextStyle
                              .copyWith(fontSize: 24.0),
                        ),
                        const SizedBox(height: 14.0),
                        Text(
                          '방장의 QR 코드를 스캔하고\n게임에 참여하세요.',
                          style: Constants.defaultTextStyle
                              .copyWith(fontSize: 16.0),
                        )
                      ],
                    ),
                    const Spacer(),
                    Bounceable(
                      onTap: () => Get.back(),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/icons/qr_x_button.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 50.0),
                  ],
                ),
                const Spacer(),
                Bounceable(
                  onTap: () {},
                  child: Container(
                    width: 128,
                    height: 36,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(16.0),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFDFDFD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      '코드입력 입장',
                      style: Constants.defaultTextStyle
                          .copyWith(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
      print(result?.code);
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    debugPrint('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
