import 'package:flutter/material.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/models/game_action.dart';

class GameItemCard extends StatelessWidget {
  const GameItemCard({
    super.key,
    required this.item,
    this.accentColor,
  });

  final GameActionItem? item;
  final Color? accentColor;

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
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item?.price}원",
                    style: Constants.defaultTextStyle
                        .copyWith(fontSize: 16, color: Constants.dark100),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    item?.description ?? "",
                    style: Constants.defaultTextStyle
                        .copyWith(fontSize: 10, color: Constants.dark100),
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
