import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_button.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/components/mc_text_field.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/user_controller.dart';
import 'package:money_cycle/start/model/mc_user.dart';
import 'package:money_cycle/start/model/profile_image.dart';
import 'package:money_cycle/utils/firebase_service.dart';

class MyPageDialog extends StatefulWidget {
  const MyPageDialog({super.key, required this.onUpdate});

  final Function() onUpdate;

  @override
  State<MyPageDialog> createState() => _MyPageDialogState();
}

class _MyPageDialogState extends State<MyPageDialog> {
  final nameController = TextEditingController();
  bool nameError = false;
  bool hasFocus = false;

  late int profileImageIndex;

  bool isLoading = false;

  @override
  void initState() {
    profileImageIndex =
        Get.find<MCUserController>().user!.value.profileImageIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserData = Get.find<MCUserController>().user!.value;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MCContainer(
                    width: 430,
                    height: 340,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Focus(
                        onFocusChange: (value) {
                          setState(() => hasFocus = value);
                        },
                        child: Column(
                          mainAxisAlignment: hasFocus
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                          children: [
                            if (!hasFocus)
                              Column(
                                children: [
                                  Text(
                                    '마이페이지',
                                    style: Constants.defaultTextStyle
                                        .copyWith(fontSize: 24.0),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    '프로필 변경',
                                    textAlign: TextAlign.center,
                                    style: Constants.defaultTextStyle
                                        .copyWith(fontSize: 16.0),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Bounceable(
                                    onTap: () {
                                      setState(() {
                                        if (profileImageIndex < 3) {
                                          profileImageIndex++;
                                        } else {
                                          profileImageIndex = 0;
                                        }
                                      });
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Image.asset(
                                          ProfileImage
                                              .profileImages[profileImageIndex],
                                          width: 70.0,
                                          height: 70.0,
                                        ),
                                        Image.asset(
                                          'assets/icons/switch_button.png',
                                          width: 24.0,
                                          height: 24.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 9.0),
                                ],
                              ),
                            if (hasFocus) const SizedBox(height: 20.0),
                            SizedBox(
                              width: 268.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '닉네임 변경',
                                    textAlign: TextAlign.center,
                                    style: Constants.defaultTextStyle
                                        .copyWith(fontSize: 16.0),
                                  ),
                                  const SizedBox(height: 10.0),
                                  MCTextField(
                                    controller: nameController,
                                    fillColor: Colors.white,
                                    borderRadius: 50,
                                    onChanged: (p0) {
                                      setState(
                                          () => nameError = (p0.length < 3));
                                    },
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(width: 21.0),
                                      Text(
                                        '3~20자 사이의 닉네임을 입력해주세요.',
                                        style: TextStyle(
                                          color: nameError
                                              ? const Color(0xFFFF5943)
                                              : const Color(0xFFC0C0C0),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            MCButton(
                              isLoading: isLoading,
                              width: 184,
                              height: 44,
                              title: "저장하기",
                              backgroundColor: Constants.blueNeon,
                              onPressed: () async {
                                final newUserData = MCUser(
                                  uid: currentUserData.uid,
                                  name: currentUserData.name,
                                  nickNm: nameController.text,
                                  profileImageIndex: profileImageIndex,
                                  phoneNumber: currentUserData.phoneNumber,
                                  birthday: currentUserData.birthday,
                                  gender: currentUserData.gender,
                                );

                                await FirebaseService.updateUserData(
                                    userData: newUserData);

                                widget.onUpdate();
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Bounceable(
                  scaleFactor: 0.8,
                  onTap: () => Get.back(),
                  child: Image.asset(
                    'assets/icons/x_button.png',
                    width: 46.0,
                    height: 46.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
