import 'package:flutter/material.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/models/game_action.dart';
import 'package:money_cycle/utils/extension/int.dart';

class GameItemCard extends StatelessWidget {
  const GameItemCard({
    super.key,
    required this.item,
    this.accentColor,
    this.evaluatedPrice,
    this.priceTitle,
  });

  final GameActionItem? item;
  final Color? accentColor;
  final int? evaluatedPrice;
  final String? priceTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 1, bottom: 4),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 110,
        height: 148,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                width: 1,
                color: Colors.white,
                strokeAlign: BorderSide.strokeAlignOutside),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x4C000000),
              blurRadius: 6,
              offset: Offset(3, 3),
              spreadRadius: 1,
            )
          ],
        ),
        child: Column(children: [
          Container(
            clipBehavior: Clip.hardEdge,
            height: 60,
            decoration: BoxDecoration(color: accentColor),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item?.title ?? "",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 16),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 74,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    children: [Spacer()],
                  ),
                  if (priceTitle != null)
                    Text(
                      priceTitle ?? "",
                      style: Constants.defaultTextStyle
                          .copyWith(fontSize: 12, color: Constants.black),
                    ),
                  if (priceTitle != null) const SizedBox(height: 6),
                  Text(
                    (evaluatedPrice != null)
                        ? "${evaluatedPrice?.commaString}원"
                        : "${(item!.price >= 1000000) ? ("${(item!.price / 10000.0).toStringAsFixed(0)}만") : item?.price.commaString}원",
                    style: Constants.defaultTextStyle
                        .copyWith(fontSize: 14, color: Constants.black),
                  ),
                  if (item?.description != null) const SizedBox(height: 4),
                  //TODO - 액션 타입에 따른 분기 처리 필요
                  if (item?.description != null)
                    Text(
                      item?.description ?? "",
                      style: Constants.defaultTextStyle
                          .copyWith(fontSize: 10, color: Constants.black),
                    ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class SavingCard extends StatelessWidget {
  const SavingCard({
    super.key,
    this.accentColor,
    required this.child,
    required this.title,
  });

  final String title;
  final Color? accentColor;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 1, bottom: 4),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 140,
        height: 148,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                width: 1,
                color: Colors.white,
                strokeAlign: BorderSide.strokeAlignOutside),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x4C000000),
              blurRadius: 6,
              offset: Offset(3, 3),
              spreadRadius: 1,
            )
          ],
        ),
        child: Column(children: [
          Container(
            clipBehavior: Clip.hardEdge,
            height: 42,
            decoration: BoxDecoration(color: Constants.cardGreen),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: Constants.defaultTextStyle.copyWith(fontSize: 16),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 94,
            child: child,
          )
        ]),
      ),
    );
  }
}

class InvestItemCard extends StatelessWidget {
  const InvestItemCard({
    super.key,
    this.accentColor,
    required this.child,
    required this.title,
    required this.count,
  });

  final String title;
  final Color? accentColor;
  final Widget child;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 1, bottom: 4),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 140,
        height: 136,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                width: 1,
                color: Colors.white,
                strokeAlign: BorderSide.strokeAlignOutside),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x4C000000),
              blurRadius: 6,
              offset: Offset(3, 3),
              spreadRadius: 1,
            )
          ],
        ),
        child: Column(children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                height: 60,
                decoration: BoxDecoration(color: Constants.cardRed),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: Constants.defaultTextStyle.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ),
              if (count >= 2)
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text("X$count",
                      style: Constants.defaultTextStyle.copyWith(fontSize: 16)),
                ),
            ],
          ),
          child
        ]),
      ),
    );
  }
}

class LoanItemCard extends StatelessWidget {
  const LoanItemCard({
    super.key,
    this.accentColor,
    required this.child,
    required this.title,
  });

  final String title;
  final Color? accentColor;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 1, bottom: 4),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 140,
        height: 136,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                width: 1,
                color: Colors.white,
                strokeAlign: BorderSide.strokeAlignOutside),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x4C000000),
              blurRadius: 6,
              offset: Offset(3, 3),
              spreadRadius: 1,
            )
          ],
        ),
        child: Column(children: [
          Container(
            clipBehavior: Clip.hardEdge,
            height: 42,
            decoration: BoxDecoration(color: Constants.cardOrange),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: Constants.defaultTextStyle.copyWith(fontSize: 16),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 94,
            child: child,
          )
        ]),
      ),
    );
  }
}
