import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_button.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/screen/lobby/model/game_variable.dart';
import 'package:money_cycle/utils/firebase_service.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SettingDialog extends StatefulWidget {
  const SettingDialog({
    super.key,
    required this.roomID,
    required this.savingRate,
    required this.loanRate,
    required this.changeRate,
  });

  final String roomID;
  final double savingRate;
  final double loanRate;
  final double changeRate;

  @override
  State<SettingDialog> createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  late double savingRate = widget.savingRate;
  late double loanRate = widget.loanRate;
  late double changeRate = widget.changeRate;

  bool isLoading = false;

  Widget variableSettingBox() {
    return Container(
      width: 316,
      height: 150,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFFA69EFF), Color(0xFF8B80FF)],
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          variableSlideBar(
            variable: GameVariable.savingsInterestRate,
            value: savingRate,
            min: 2.0,
            max: 10.0,
            onChange: (newValue) {
              setState(() => savingRate = newValue);
            },
          ),
          variableSlideBar(
            variable: GameVariable.loanInterestRate,
            value: loanRate,
            min: 1.0,
            max: 9.0,
            onChange: (newValue) {
              setState(() => loanRate = newValue);
            },
          ),
          variableSlideBar(
            variable: GameVariable.investmentChangeRate,
            value: changeRate,
            min: -20.0,
            max: 30.0,
            onChange: (newValue) {
              setState(() => changeRate = newValue);
            },
          ),
        ],
      ),
    );
  }

  Widget variableSlideBar({
    required GameVariable variable,
    double min = 0.0,
    double max = 5.0,
    required double value,
    required Function(dynamic) onChange,
  }) {
    return Row(
      children: [
        const SizedBox(width: 6.0),
        Image.asset(
          variable.sourceUrl,
          width: 96,
          height: 42,
        ),
        SizedBox(
          width: 140,
          child: SfSliderTheme(
            data: SfSliderThemeData(
              activeTrackHeight: 2,
              inactiveTrackHeight: 2,
              trackCornerRadius: 2,
              activeTrackColor: Colors.white.withOpacity(0.8),
              inactiveTrackColor: const Color(0xFF7062AD),
              overlayRadius: 10,
            ),
            child: SfSlider(
              value: value,
              min: min,
              max: max,
              stepSize: 0.5,
              thumbIcon: Container(
                width: 18,
                height: 18,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, 1.00),
                    end: Alignment(0, -1),
                    colors: [Color(0xFF6322EE), Color(0xFF8572FF)],
                  ),
                  shape: OvalBorder(
                    side: BorderSide(width: 1, color: Colors.white),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
              onChanged: onChange,
            ),
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          '${value.toStringAsFixed(1)}%',
          textAlign: TextAlign.right,
          style: Constants.defaultTextStyle.copyWith(fontSize: 16),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: MCContainer(
          width: 412,
          height: 280,
          alignment: Alignment.center,
          strokePadding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '환경설정',
                style: Constants.defaultTextStyle.copyWith(fontSize: 24.0),
              ),
              const SizedBox(height: 10),
              variableSettingBox(),
              const SizedBox(height: 10),
              MCButton(
                width: 184,
                height: 44,
                title: "확인",
                backgroundColor: isLoading ? Colors.grey : Constants.blueNeon,
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() => isLoading = true);

                        await FirebaseService.updateRateSetting(
                          roomId: widget.roomID,
                          savigRate: savingRate,
                          loanRate: loanRate,
                          investmentRate: changeRate,
                        );

                        setState(() => isLoading = false);
                        Get.back();
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
