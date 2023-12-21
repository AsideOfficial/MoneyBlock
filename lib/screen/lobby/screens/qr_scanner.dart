import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/user_controller.dart';
import 'package:money_cycle/controller/waiting_room_controller.dart';
import 'package:money_cycle/screen/lobby/screens/waiting_room_screen.dart';
import 'package:money_cycle/utils/firebase_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key, required this.onTap});

  final Function() onTap;

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isLoading = true;

  void ready() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() => isLoading = false);
  }

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
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.white,
                  borderWidth: 0,
                  borderRadius: 30,
                  borderLength: 30,
                  cutOutSize: 300,
                  cutOutBottomOffset: 16,
                ),
                onPermissionSet: (ctrl, p) =>
                    _onPermissionSet(context, ctrl, p),
              ),
              Transform.translate(
                offset: const Offset(0.0, -16.0),
                child: Image.asset(
                  'assets/components/qr_border.png',
                  width: 220,
                  height: 220,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 40.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width / 20.0),
                  Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Text(
                        'QR코드 스캔하기',
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 24.0),
                      ),
                      const SizedBox(height: 14.0),
                      Text(
                        '방장의 QR 코드를 스캔하고\n게임에 참여하세요.',
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 16.0),
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
              if (!isLoading)
                Bounceable(
                  onTap: widget.onTap,
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
                )
              else
                const SizedBox(height: 36.0),
              const SizedBox(height: 4.0),
            ],
          ),
        ],
      ),
    );
  }

  void showSnackBar() {
    Get.snackbar(
      '',
      '',
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 400),
      maxWidth: 230,
      titleText: Container(
        width: 230,
        height: 50,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: const Color(0xFF696969),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Text(
          '해당 방을 찾을 수 없어요.',
          style: Constants.defaultTextStyle.copyWith(fontSize: 14.0),
        ),
      ),
      borderRadius: 50,
      barBlur: 0,
      backgroundColor: Colors.transparent,
      snackPosition: SnackPosition.TOP,
    );
  }

  void showNoPermissionSnackBar() {
    Get.snackbar(
      '',
      '',
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 400),
      maxWidth: 300,
      titleText: Container(
        width: 300,
        height: 80,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: const Color(0xFF696969),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Text(
          '카메라 권한이 없습니다.\n설정에서 카메라 권한을 허용해주세요.',
          style: Constants.defaultTextStyle.copyWith(fontSize: 14.0),
          textAlign: TextAlign.center,
        ),
      ),
      borderRadius: 50,
      barBlur: 0,
      backgroundColor: Colors.transparent,
      snackPosition: SnackPosition.TOP,
    );
  }

  void participateRoom({required String roomCode}) async {
    final result = await FirebaseService.enterRoom(
      roomId: roomCode,
      uid: FirebaseAuth.instance.currentUser!.uid,
      name: Get.find<MCUserController>().user!.value.nickNm,
      characterIndex:
          Get.find<MCUserController>().user!.value.profileImageIndex,
    );

    if (result != null) {
      Get.off(
        const WaitingRoomScreen(),
        binding: BindingsBuilder(() {
          Get.put(
            WaitingRoomController(roomId: result.roomId),
          );
        }),
        transition: Transition.fadeIn,
        arguments: result.roomId,
      );
    } else {
      showSnackBar();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);

      if (result?.code?.length == 6) {
        controller.dispose();
        participateRoom(roomCode: result?.code ?? '');
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    debugPrint('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    ready();
    if (!p) {
      showNoPermissionSnackBar();
    }
  }
}
