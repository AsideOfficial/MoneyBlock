import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_button.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShareCodeDialog extends StatelessWidget {
  const ShareCodeDialog({super.key, required this.roomCode});

  final int roomCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: MCContainer(
          width: 430,
          height: 280,
          strokePadding: const EdgeInsets.all(6.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '코드공유',
                style: Constants.defaultTextStyle.copyWith(fontSize: 24.0),
              ),
              const SizedBox(height: 26.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        'QR코드',
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 16.0),
                      ),
                      const SizedBox(height: 13.0),
                      QrImageView(
                        data: roomCode.toString(),
                        padding: EdgeInsets.zero,
                        eyeStyle: const QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: Color(0xFFFEFEFE),
                        ),
                        dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: Color(0xFFFEFEFE),
                        ),
                        version: QrVersions.auto,
                        size: 70.0,
                      ),
                    ],
                  ),
                  const SizedBox(width: 37.5),
                  Container(
                    width: 1,
                    height: 98,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 37.5),
                  Column(
                    children: [
                      Text(
                        '초대코드',
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 16.0),
                      ),
                      const SizedBox(height: 23.0),
                      Text(
                        roomCode.toString(),
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 16.0),
                      Bounceable(
                        onTap: () {},
                        child: Container(
                          width: 65,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFFFDFDFD),
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            '복사하기',
                            style: Constants.defaultTextStyle
                                .copyWith(fontSize: 12.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2.0),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 27.0),
              MCButton(
                width: 184,
                height: 44,
                title: "닫기",
                backgroundColor: Constants.blueNeon,
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
