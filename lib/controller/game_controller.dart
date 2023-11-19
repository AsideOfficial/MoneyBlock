import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_cycle/models/enums/game_action_type.dart';
import 'package:money_cycle/models/game/game_data_detail.dart';
import 'package:money_cycle/models/game/player.dart';
import 'package:money_cycle/models/game/user_action.dart';
import 'package:money_cycle/models/game_action.dart';
import 'package:money_cycle/services/cloud_fuction_service.dart';
import 'package:money_cycle/services/firebase_real_time_service.dart';

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

  final Rx<GameDataDetails?> _currentRoom = Rx<GameDataDetails?>(null);
  Future<void> bindRoomStream() async {
    _currentRoom.bindStream(
        FirebaseRealTimeService.getRoomDataStream(roomId: "015327"));
    ever(_currentRoom, _roomDataHandler);
  }

  _roomDataHandler(GameDataDetails? room) {
    debugPrint("${_currentRoom.value?.isPlaying} - 변경 확인!");
    // _currentRoom.value.
  }

  final roomId = "015327";
  final myIndex = 0;

  Future<void> shortSavingAction(int price) async {
    CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- shortSaving ++
        UserAction(type: "cash", title: "예금", price: -price, qty: 1),
        UserAction(type: "shortSaving", title: "예금", price: price, qty: 1),
      ],
    ));
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  Future<void> longSavingAction(int price) async {
    CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- longSaving ++
        UserAction(type: "cash", title: "적금", price: -price, qty: 1),
        UserAction(type: "longSaving", title: "적금", price: price, qty: 1),
      ],
    ));
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  Future<void> loanAction(int price) async {
    CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash ++ loan ++
        UserAction(type: "cash", title: "대출 실행", price: price, qty: 1),
        UserAction(type: "loan", title: "대출 실행", price: price, qty: 1),
      ],
    ));
  }

  Future<void> loanRepaymentAction(int price) async {
    CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- loan --
        UserAction(type: "cash", title: "대출 상환", price: -price, qty: 1),
        UserAction(type: "loan", title: "대출 상환", price: -price, qty: 1),
      ],
    ));
  }

  Future<void> investAction(String title, int price) async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- loan --
        UserAction(type: "cash", title: "$title-투자", price: -price, qty: 1),
        UserAction(type: "invest", title: "$title-투자", price: -price, qty: 1),
      ],
    ));
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  Future<void> expendAction(String title, int price) async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- loan --
        UserAction(type: "cash", title: "$title-구매", price: -price, qty: 1),
        UserAction(type: "expend", title: "$title-구매", price: -price, qty: 1),
      ],
    ));
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  GameAction get currentActionTypeModel {
    switch (_curretnActionType.value) {
      case GameActionType.saving:
        return savingModel;
      case GameActionType.investment:
        return investmentModel;
      case GameActionType.expend:
        return expendModel;
      case GameActionType.loan:
        return loanModel;
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
      case GameActionType.loan:
        return Constants.orangeGradient;
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
      case GameActionType.loan:
        return Constants.cardOrange;
    }
  }

  String get currentAssetString {
    switch (_curretnActionType.value) {
      case GameActionType.saving:
        return "assets/components/button_square_green.png";
      case GameActionType.investment:
        return "assets/icons/red_button.png";
      case GameActionType.expend:
        return "assets/icons/blue_button.png";
      case GameActionType.loan:
        return "assets/components/button_square_orange.png";
    }
  }

  String get currentBackButtonAssetString {
    switch (_curretnActionType.value) {
      case GameActionType.saving:
        return "assets/icons/back_button_green.png";
      case GameActionType.investment:
        return "assets/icons/back_button_red.png";
      case GameActionType.expend:
        return "assets/icons/back_button_blue.png";
      case GameActionType.loan:
        return "assets/icons/back_button_orange.png";
    }
  }
}
