import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';

class InputCodeScreen extends StatefulWidget {
  const InputCodeScreen({super.key, required this.onTap});

  final Function() onTap;

  @override
  State<InputCodeScreen> createState() => _InputCodeScreenState();
}

class _InputCodeScreenState extends State<InputCodeScreen> {
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 40.0),
                      Text(
                        '코드 직접 입력하기',
                        style: Constants.defaultTextStyle.copyWith(
                            color: const Color(0xFF303030), fontSize: 24.0),
                      ),
                      Bounceable(
                        onTap: () => Get.back(),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/icons/qr_x_button.png',
                            color: Colors.black,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14.0),
                  Text(
                    '코드를 입력하여 게임에 참여하세요.',
                    style: Constants.defaultTextStyle.copyWith(
                      color: const Color(0xFF303030),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: codeController,
                      textAlign: TextAlign.center,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 11.5),
                  Bounceable(
                    onTap: widget.onTap,
                    child: Container(
                      width: 128,
                      height: 36,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(16.0),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF6F6F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'QR스캔 입장',
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
      ),
    );
  }
}
