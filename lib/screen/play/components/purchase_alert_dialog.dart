import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/utils/extension/int.dart';

import '../../../components/mc_button.dart';
import '../../../components/mc_container.dart';

class PurchaseAlertDialog extends StatefulWidget {
  final String title;
  final String subTitle;
  final int perPrice;
  final String actionTitle;
  final bool? isMultiple;
  final Color? primaryActionColor;
  final Future<void> Function(int count)? onPurchase;

  const PurchaseAlertDialog({
    super.key,
    this.isMultiple = false,
    this.primaryActionColor = Constants.accentRed,
    required this.title,
    required this.subTitle,
    required this.perPrice,
    required this.actionTitle,
    this.onPurchase,
  });

  @override
  State<PurchaseAlertDialog> createState() => _PurchaseAlertDialogState();
}

class _PurchaseAlertDialogState extends State<PurchaseAlertDialog> {
  bool isLoading = false;
  int count = 1;
  int totalAmount = 0;
  @override
  void initState() {
    super.initState();
    totalAmount = widget.perPrice;
  }

  void calculate() {
    setState(() {
      totalAmount = widget.perPrice * count;
    });
  }

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
              if (widget.isMultiple!)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Bounceable(
                        onTap: () {
                          if (count > 1) {
                            setState(() {
                              count--;
                            });
                            calculate();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 14,
                            height: 14,
                            child: Image.asset("assets/icons/minus.png"),
                          ),
                        ),
                      ),
                      Text(count.toString(),
                          style: Constants.defaultTextStyle
                              .copyWith(fontSize: 18, color: Colors.black)),
                      Bounceable(
                        onTap: () {
                          if (count < 10) {
                            setState(() {
                              count++;
                            });
                            calculate();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 14,
                            height: 14,
                            child: Image.asset("assets/icons/plus.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              Text("금액: ${totalAmount.commaString}원",
                  style:
                      Constants.largeTextStyle.copyWith(color: Colors.black)),
              const Spacer(),
              SizedBox(
                height: 48,
                child: Row(
                  children: [
                    Expanded(
                      child: MCButton(
                          title: "취소",
                          fontSize: 20,
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
                          vertical: 12, horizontal: 6),
                      fontSize: 20,
                      title: widget.actionTitle,
                      backgroundColor: widget.primaryActionColor,
                      shadows: const [Constants.buttonShadow],
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (widget.onPurchase != null) {
                                setState(() {
                                  isLoading = true;
                                });
                                await widget.onPurchase!(count);
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
