import 'dart:ffi';

import 'package:get/get.dart';
import 'package:money_cycle/models/enums/game_action.dart';
import 'package:money_cycle/models/game_action.dart';

class GameController extends GetxController {
  final _curretnActionType = GameActionType.expend.obs;
  GameActionType get currentActionType => _curretnActionType.value;

  final _isActionChoicing = false.obs;
  bool get isActionChoicing => _isActionChoicing.value;
  set isActionChoicing(bool newValue) => _isActionChoicing.value = newValue;

  void actionButtonTap(GameActionType type) {
    _curretnActionType.value = type;
    isActionChoicing = true;
  }

  GameAction get currentActionTypeModle {
    switch (_curretnActionType.value) {
      case GameActionType.saving:
        return savingModel;
      case GameActionType.investment:
        return investmentModel;
      case GameActionType.expend:
        return expendModel;
    }
  }
}
