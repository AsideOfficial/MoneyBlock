import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:money_cycle/components/mc_text_field.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/start/model/mc_user.dart';
import 'package:money_cycle/utils/firebase_service.dart';
import 'package:money_cycle/utils/text_validator.dart';

class AddInformationScreen extends StatefulWidget {
  const AddInformationScreen({super.key, required this.uid});

  final String uid;

  @override
  State<AddInformationScreen> createState() => _AddInformationScreenState();
}

class _AddInformationScreenState extends State<AddInformationScreen> {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final birthdayController = TextEditingController();
  final genderController = TextEditingController();
  final locationController = TextEditingController();

  bool isNameError = false;
  bool isPhoneNumberError = false;
  bool isBirthdayError = false;
  bool isGenderError = false;
  bool isLocationError = false;

  bool checkCondition() {
    bool require = nameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        birthdayController.text.isNotEmpty &&
        genderController.text.isNotEmpty;

    bool isValid = TextValidator.isNameFormat(nameController.text) &&
        TextValidator.isPhoneNumberFormat(phoneNumberController.text) &&
        TextValidator.isDateFormat(birthdayController.text) &&
        TextValidator.isGenderFormat(genderController.text) &&
        (locationController.text.isNotEmpty
            ? TextValidator.isLocationFormat(locationController.text)
            : true);

    return require && isValid;
  }

  @override
  Widget build(BuildContext context) {
    const background = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment(0.00, 1.00),
        end: Alignment(0, -1),
        colors: [Color(0xFF6322EE), Color(0xFF8572FF)],
      ),
    );

    Widget errorString({required bool isError, required String errorLabel}) {
      return SizedBox(
        width: 268,
        child: Row(
          children: [
            const SizedBox(width: 24.0),
            Text(
              errorLabel,
              style: TextStyle(
                color:
                    isError ? const Color(0xFFFF5943) : const Color(0xFFC0C0C0),
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          decoration: background,
          child: ListView(
            children: [
              const SizedBox(height: 50.0),
              Center(
                child: Column(
                  children: [
                    Text(
                      '필수 정보 입력',
                      style:
                          Constants.defaultTextStyle.copyWith(fontSize: 24.0),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: 268,
                      child: MCTextField(
                        controller: nameController,
                        fillColor: Colors.white,
                        hintText: '이름',
                        onChanged: (p0) {
                          setState(() => checkCondition());
                        },
                      ),
                    ),
                    errorString(
                      isError: isNameError,
                      errorLabel:
                          isNameError ? '이름을 올바르게 입력해주세요.' : '이름을 입력해주세요.',
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: 268,
                      child: MCTextField(
                        controller: phoneNumberController,
                        fillColor: Colors.white,
                        hintText: '연락처',
                        onChanged: (p0) {
                          setState(() => checkCondition());
                        },
                      ),
                    ),
                    errorString(
                      isError: isPhoneNumberError,
                      errorLabel: isPhoneNumberError
                          ? '예시: 01012345678, 예시를 참고해주세요.'
                          : '예시: 01012345678',
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: 268,
                      child: MCTextField(
                        controller: birthdayController,
                        fillColor: Colors.white,
                        hintText: '생년월일',
                        onChanged: (p0) {
                          setState(() => checkCondition());
                        },
                      ),
                    ),
                    errorString(
                      isError: isBirthdayError,
                      errorLabel: isBirthdayError
                          ? '예시: 2000.01.01, 예시를 참고해주세요.'
                          : '예시: 2000.01.01',
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: 268,
                      child: MCTextField(
                        controller: genderController,
                        fillColor: Colors.white,
                        hintText: '성별',
                        onChanged: (p0) {
                          setState(() => checkCondition());
                        },
                      ),
                    ),
                    errorString(
                      isError: isGenderError,
                      errorLabel:
                          isGenderError ? '예시: 남, 예시를 참고해주세요.' : '예시: 남',
                    ),
                    const SizedBox(height: 34.0),
                    Text(
                      '추가 정보 입력',
                      style:
                          Constants.defaultTextStyle.copyWith(fontSize: 24.0),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: 268,
                      child: MCTextField(
                        controller: locationController,
                        fillColor: Colors.white,
                        hintText: '지역',
                        onChanged: (p0) {
                          setState(() => checkCondition());
                        },
                      ),
                    ),
                    errorString(
                      isError: isLocationError,
                      errorLabel: isLocationError
                          ? '예시: 서울시 마포구, 예시를 참고해주세요.'
                          : '예시: 서울시 마포구',
                    ),
                    const SizedBox(height: 34.0),
                    Bounceable(
                      onTap: checkCondition()
                          ? () {
                              FirebaseService.updateUserData(
                                userData: MCUser(
                                  uid: widget.uid,
                                  name: nameController.text,
                                  nickNm: nameController.text,
                                  profileImageIndex: 0,
                                  phoneNumber: phoneNumberController.text,
                                  birthday: birthdayController.text,
                                  gender: genderController.text,
                                  location: locationController.text,
                                ),
                              );
                            }
                          : null,
                      child: Image.asset(
                        'assets/components/input_button_${checkCondition() ? '' : 'in'}active.png',
                        width: 264,
                        height: 50,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
