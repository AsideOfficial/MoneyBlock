import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_cycle/models/enums/game_action.dart';
import 'package:money_cycle/models/game_action.dart';

import '../constants.dart';

class GameController extends GetxController {
  final _curretnActionType = GameActionType.expend.obs;
  GameActionType get currentActionType => _curretnActionType.value;

  final Rx<SpecifitGameAction?> _curretnSpecificActionModel =
      Rx<SpecifitGameAction?>(null);
  SpecifitGameAction? get curretnSpecificActionModel =>
      _curretnSpecificActionModel.value;

  final _isActionChoicing = false.obs;
  bool get isActionChoicing => _isActionChoicing.value;
  set isActionChoicing(bool newValue) => _isActionChoicing.value = newValue;

  void specificActionButtonTap(int index) {
    _curretnSpecificActionModel.value = currentActionTypeModel.actions[index];
    debugPrint(_curretnSpecificActionModel.value?.title ?? "");
  }

  void actionButtonTap(GameActionType type) {
    _curretnActionType.value = type;
    _curretnSpecificActionModel.value = null;

    // _curretnSpecificActionModel.value = currentActionTypeModel.actions[0];
    isActionChoicing = true;
  }

  GameAction get currentActionTypeModel {
    switch (_curretnActionType.value) {
      case GameActionType.saving:
        return savingModel;
      case GameActionType.investment:
        return investmentModel;
      case GameActionType.expend:
        return expendModel;
    }
  }

  LinearGradient get currentBackgroundGradient {
    switch (_curretnActionType.value) {
      case GameActionType.saving:
        return Constants.greenGradient;
      case GameActionType.investment:
        return Constants.redGradient;
      case GameActionType.expend:
        return Constants.blueGradient;
    }
  }

  Color get currentCardColor {
    switch (_curretnActionType.value) {
      case GameActionType.saving:
        return Constants.cardGreen;
      case GameActionType.investment:
        return Constants.cardRed;
      case GameActionType.expend:
        return Constants.cardBlue;
    }
  }

  String get currentColorString {
    switch (_curretnActionType.value) {
      case GameActionType.saving:
        return "green";
      case GameActionType.investment:
        return "red";
      case GameActionType.expend:
        return "blue";
    }
  }
}
