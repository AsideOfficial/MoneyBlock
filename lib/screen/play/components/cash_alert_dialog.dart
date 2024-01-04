import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';
import '../../../components/mc_button.dart';
import '../../../components/mc_container.dart';

class CashAlertDialog extends StatefulWidget {
  final String actionTitle;
  final Color? primaryActionColor;
  final Function()? onAction;
  final List<Widget> children;

  const CashAlertDialog({
    super.key,
    this.primaryActionColor = Constants.accentRed,
    required this.actionTitle,
    required this.children,
    this.onAction,
  });

  @override
  State<CashAlertDialog> createState() => _CashAlertDialogState();
}

class _CashAlertDialogState extends State<CashAlertDialog> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: MCContainer(
        strokePadding: const EdgeInsets.all(8),
        gradient: Constants.grey01Gradient,
        width: 306,
        height: 256,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 24, bottom: 22, left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.children,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 44,
                child: Row(
                  children: [
                    Expanded(
                      child: MCButton(
                          title: "취소",
                          fontSize: 20,
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 6),
                          titleColor: Constants.grey03,
                          gradient: Constants.grey01Gradient,
                          shadows: const [Constants.buttonShadow],
                          onPressed: () {
                            Get.back();
                          }),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: MCButton(
                      isLoading: isLoading,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 6),
                      fontSize: 20,
                      title: widget.actionTitle,
                      backgroundColor: widget.primaryActionColor,
                      shadows: const [Constants.buttonShadow],
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (widget.onAction != null) {
                                setState(() {
                                  isLoading = true;
                                });
                                await widget.onAction!();
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                    )),
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
