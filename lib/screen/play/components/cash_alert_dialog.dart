import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/utils/extension/int.dart';

import '../../../components/mc_button.dart';
import '../../../components/mc_container.dart';

class CashAlertDialog extends StatefulWidget {
  final String title;
  final String subTitle;
  final String description;
  final String actionTitle;
  final bool? isMultiple;
  final Color? primaryActionColor;
  final Future<void> Function()? onAction;

  const CashAlertDialog({
    super.key,
    this.isMultiple = false,
    this.primaryActionColor = Constants.accentRed,
    required this.title,
    required this.subTitle,
    required this.actionTitle,
    this.onAction,
    required this.description,
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
            children: [
              Text(widget.title,
                  style:
                      Constants.titleTextStyle.copyWith(color: Colors.black)),
              const SizedBox(height: 10),
              Text(widget.subTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Constants.defaultTextStyle
                      .copyWith(fontSize: 18, color: Colors.black)),
              const SizedBox(height: 10),
              Text(widget.description,
                  textAlign: TextAlign.center,
                  style: Constants.defaultTextStyle
                      .copyWith(fontSize: 18, color: Colors.black)),
              const Spacer(),
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
