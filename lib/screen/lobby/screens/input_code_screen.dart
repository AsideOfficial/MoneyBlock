import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/user_controller.dart';
import 'package:money_cycle/controller/waiting_room_controller.dart';
import 'package:money_cycle/screen/lobby/screens/waiting_room_screen.dart';
import 'package:money_cycle/utils/firebase_service.dart';

class InputCodeScreen extends StatefulWidget {
  const InputCodeScreen({super.key, required this.onTap});

  final Function() onTap;

  @override
  State<InputCodeScreen> createState() => _InputCodeScreenState();
}

class _InputCodeScreenState extends State<InputCodeScreen> {
  final codeController = TextEditingController();

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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 100),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: codeController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            suffixIconConstraints: const BoxConstraints(
                                maxWidth: 20, maxHeight: 20),
                            suffixIcon: codeController.text.isEmpty
                                ? const SizedBox(width: 20, height: 20)
                                : Bounceable(
                                    onTap: () {
                                      setState(() => codeController.text = '');
                                    },
                                    child: Image.asset(
                                        'assets/icons/textfield_x_button.png'),
                                  ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            counterText: '',
                          ),
                          maxLength: 6,
                          style: Constants.defaultTextStyle.copyWith(
                            color: const Color(0xFF303030),
                            fontSize: 16.0,
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      if (codeController.text.length == 6)
                        Bounceable(
                          onTap: () async {
                            final result = await FirebaseService.enterRoom(
                              roomId: codeController.text,
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              name: Get.find<MCUserController>()
                                  .user!
                                  .value
                                  .nickNm,
                              characterIndex: Get.find<MCUserController>()
                                  .user!
                                  .value
                                  .profileImageIndex,
                            );

                            if (result != null) {
                              Get.off(
                                () => const WaitingRoomScreen(),
                                binding: BindingsBuilder(() {
                                  Get.put(
                                    WaitingRoomController(
                                        roomId: result.roomId),
                                  );
                                }),
                                transition: Transition.fadeIn,
                                arguments: result.roomId,
                              );
                            } else {
                              showSnackBar();
                            }
                          },
                          child: Container(
                            width: 80,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF303030),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              '완료',
                              style: Constants.defaultTextStyle
                                  .copyWith(fontSize: 14),
                            ),
                          ),
                        )
                      else
                        const SizedBox(width: 80),
                    ],
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
                        color: const Color(0xFFEEEEEE),
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
