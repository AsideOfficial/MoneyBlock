import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_cycle/models/enums/game_action_type.dart';
import 'package:money_cycle/models/game/game_data_detail.dart';
import 'package:money_cycle/models/game/news_article.dart';
import 'package:money_cycle/models/game/player.dart';
import 'package:money_cycle/models/game/user_action.dart';
import 'package:money_cycle/models/game_action.dart';
import 'package:money_cycle/screen/play/components/end_game_alert_dialog.dart';
import 'package:money_cycle/screen/play/components/end_round_alert_dialog.dart';
import 'package:money_cycle/screen/play/components/start_game_alert_dialog.dart';
import 'package:money_cycle/services/cloud_fuction_service.dart';
import 'package:money_cycle/services/firebase_real_time_service.dart';

import '../constants.dart';

class GameController extends GetxController {
  GameController({required this.roomId, required this.myIndex});
  final String roomId;
  final int myIndex;

  @override
  void onInit() async {
    super.onInit();
    debugPrint("게임 컨트롤러 Init 시작");
    final roomData = await FirebaseRealTimeService.getRoomData(roomId: roomId);
    _currentRoom.value = roomData;
    bindRoomStream(roomId);
  }

  @override
  void onReady() {
    super.onReady();
    Get.dialog(const StartGameAlertDialog(), barrierDismissible: false);
  }

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

  //MARK: - <게임 플레이 리스너

  final Rx<int?> _currenTurnIndex = Rx<int?>(null);
  final Rx<int?> _currenRoundIndex = Rx<int?>(null);
  int get currentRound {
    if (_currenRoundIndex.value != null) {
      return (_currenRoundIndex.value!) + 1;
    } else {
      return 1;
    }
  }

  final Rx<bool?> _isGameEnded = Rx<bool?>(false);
  final Rx<GameDataDetails?> _currentRoom = Rx<GameDataDetails?>(null);
  GameDataDetails? get currentRoomData => _currentRoom.value;
  Future<void> bindRoomStream(String roomId) async {
    _currentRoom
        .bindStream(FirebaseRealTimeService.getRoomDataStream(roomId: roomId));
    _currenTurnIndex
        .bindStream(FirebaseRealTimeService.getTurnIndexStream(roomId: roomId));
    _currenRoundIndex.bindStream(
        FirebaseRealTimeService.getRoundIndexStream(roomId: roomId));
    _isGameEnded.bindStream(
        FirebaseRealTimeService.getIsGameEndedStream(roomId: roomId));
    ever(_currentRoom, _roomDataHandler);
    ever(_currenTurnIndex, _turnIndexHandler);
    ever(_currenRoundIndex, _roundIndexHandler);
    ever(_isGameEnded, _endGameHandler);
    debugPrint("게임 이벤트 핸들러 바인딩 완료");
  }

  _roomDataHandler(GameDataDetails? room) {
    debugPrint("_roomDataHandler 트리거 -");
    // debugPrint("[게임 데이터 변경 수신 핸들러] 플레이어 리스트 - ${_currentRoom.value?.player}");
    // _currentRoom.value.
  }

  _turnIndexHandler(int? index) {
    //턴 인덱스 핸들러 - 동작 검수 완료 ✅
    debugPrint("_turnIndexHandler 트리거 - 현재 턴 : $index");
    if (index! % (_currentRoom.value!.player?.length ?? 2) == myIndex) {
      debugPrint("$index - 내 차례!");
    } else {
      debugPrint("$index 다른 놈 차례!");
    }
  }

  _roundIndexHandler(int? index) {
    //라운드 인덱스 핸들러 - 동작 검수 완료 ✅
    debugPrint("_roundIndexHandler 트리거 - 라운드 $index");
    if (index == null) return;
    if (index >= 1 && index < 3) {
      Get.dialog(
        const EndRoundAlertDialog(),
        barrierDismissible: false,
      );
    }
  }

  _endGameHandler(bool? isEnd) {
    // 게임 종료 핸들러
    debugPrint("_endGameHandler 트리거 - 게임 종료 여부 : $isEnd");
    if (isEnd == true) {
      //TODO - 게임 종료 로직 실행
      Get.dialog(
        const EndGameAlertDialog(),
        barrierDismissible: false,
      );
    } else {}
    debugPrint("라운드 변경 - ${_currentRoom.value?.roundIndex}");
  }

  //MARK: - </게임 플레이 리스너>

  //MARK: - UI 비즈니스 로직

  Player? get currentTurnPlayer {
    if (_currenTurnIndex.value == null) return null;
    int turn = 0;
    if (_currenTurnIndex.value != 0) {
      turn =
          (_currenTurnIndex.value! % (_currentRoom.value!.player?.length ?? 2));
    }
    return currentRoomData?.player?[turn];
  }

  double get currentSavingRate {
    return _currentRoom.value!.savingRateInfo![_currenRoundIndex.value!];
  }

  double get previousSavingRate {
    if (_currenRoundIndex.value == 0) {
      return 0;
    } else {
      return _currentRoom
          .value!.savingRateInfo![(_currenRoundIndex.value!) - 1];
    }
  }

  double get currentInvestRate {
    return currentRoomData!.investmentRateInfo![_currenRoundIndex.value!];
  }

  double get previousInvestRate {
    if (_currenRoundIndex.value == 0) {
      return 0;
    } else {
      return _currentRoom
          .value!.investmentRateInfo![(_currenRoundIndex.value!) - 1];
    }
  }

  double get currentLoanRate {
    return _currentRoom.value!.loanRateInfo![_currenRoundIndex.value!];
  }

  double get previousLoanRate {
    if (_currenRoundIndex.value == 0) {
      return 0;
    } else {
      return _currentRoom.value!.loanRateInfo![(_currenRoundIndex.value!) - 1];
    }
  }

  bool get isMyTurn {
    if (_currenTurnIndex.value == null) return false;
    if (_currenTurnIndex.value == 0) {
      return (_currenTurnIndex.value == myIndex);
    } else {
      return (_currenTurnIndex.value! %
              (_currentRoom.value!.player?.length ?? 2) ==
          myIndex);
    }
  }

  // 뉴스 콘텐츠
  NewsArticle? get currentNews {
    if (_currenRoundIndex.value == null) return null;
    if (_currenRoundIndex.value! < 3) {
      return _currentRoom.value?.news?[_currenRoundIndex.value!];
    }
    return null;
  }

  NewsArticle? get previousNews {
    if ((_currenRoundIndex.value ?? 0) > 0) {
      return _currentRoom.value?.news?[(_currenRoundIndex.value ?? 0 - 1)];
    } else {
      return _currentRoom.value?.news?[0];
    }
  }

  int getRandomNumber(int max) {
    Random random = Random();
    return random.nextInt(max);
  }

  double previousRate({required GameActionType actionType}) {
    switch (actionType) {
      case GameActionType.saving:
        return previousSavingRate;
      case GameActionType.investment:
        return previousInvestRate;
      case GameActionType.loan:
        return previousLoanRate;
      case GameActionType.expend:
        return 0;
    }
  }

  double currentRate({required GameActionType actionType}) {
    switch (actionType) {
      case GameActionType.saving:
        return currentSavingRate;
      case GameActionType.investment:
        return currentInvestRate;
      case GameActionType.loan:
        return currentLoanRate;
      case GameActionType.expend:
        return 0;
    }
  }

  String characterAvatarAssetString({required int characterIndex}) {
    String assetString = "assets/images/profile_bear.png";
    switch (characterIndex) {
      case 0:
        assetString = "assets/images/profile_bear.png";
      case 1:
        assetString = "assets/images/profile_cow.png";
      case 2:
        assetString = "assets/images/profile_pig.png";
      case 3:
        assetString = "assets/images/profile_tiger.png";
    }
    return assetString;
  }

  String get myCharacterAvatarAssetString {
    final int? myCharacterIndex =
        currentRoomData?.player?[myIndex].characterIndex;
    String assetString = "assets/images/profile_bear.png";
    switch (myCharacterIndex) {
      case 0:
        assetString = "assets/images/profile_bear.png";
      case 1:
        assetString = "assets/images/profile_cow.png";
      case 2:
        assetString = "assets/images/profile_pig.png";
      case 3:
        assetString = "assets/images/profile_tiger.png";
    }
    return assetString;
  }

  // MARK: - 계산 비즈니스 로직
  int get myRanking {
    //TODO - 내 순위 계산식
    return 3;
  }

  int get myIncentive {
    int incentive = 0;
    switch (myRanking) {
      case 1:
        incentive = 400000;
      case 2:
        incentive = 300000;
      case 3:
        incentive = 200000;
      case 4:
        incentive = 100000;
    }
    return incentive;
  }

  int? get totalCash {
    // 리스트를 순회하면서 price 합산
    final myCashList = _currentRoom.value?.player?[myIndex].cash;
    int total = 0;
    if (myCashList != null) {
      for (UserAction cashData in myCashList) {
        total += cashData.price!;
      }
    }
    return total;
  }

  // 합산 액
  int? get totalInvestment {
    // 리스트를 순회하면서 price 합산
    final myCashList = _currentRoom.value?.player?[myIndex].investment;
    int total = 0;
    if (myCashList != null) {
      for (UserAction cashData in myCashList) {
        total += (cashData.price! * cashData.qty!);
      }
    }
    return total;
  }

  int? get totalSaving {
    // 리스트를 순회하면서 price 합산
    final myshortSavingList = _currentRoom.value?.player?[myIndex].shortSaving;
    final myLongSavingList = _currentRoom.value?.player?[myIndex].longSaving;
    int total = 0;
    if (myLongSavingList != null) {
      for (UserAction cashData in myLongSavingList) {
        total += cashData.price!;
      }
    }

    if (myshortSavingList != null) {
      for (UserAction cashData in myshortSavingList) {
        total += cashData.price!;
      }
    }

    debugPrint("totalCash - $total");

    return total;
  }

  int? get totalShortSaving {
    // 리스트를 순회하면서 price 합산
    final myshortSavingList = _currentRoom.value?.player?[myIndex].shortSaving;
    int total = 0;

    if (myshortSavingList != null) {
      for (UserAction cashData in myshortSavingList) {
        total += cashData.price!;
      }
    }
    return total;
  }

  int? get totalLongSaving {
    // 리스트를 순회하면서 price 합산
    final myshortSavingList = _currentRoom.value?.player?[myIndex].longSaving;
    int total = 0;

    if (myshortSavingList != null) {
      for (UserAction cashData in myshortSavingList) {
        total += cashData.price!;
      }
    }
    return total;
  }

  int? get totalCreditLoan {
    // 리스트를 순회하면서 price 합산
    final myCreditLoanList = _currentRoom.value?.player?[myIndex].creditLoan;
    int total = 0;

    if (myCreditLoanList != null) {
      for (UserAction cashData in myCreditLoanList) {
        total += cashData.price!;
      }
    }
    return total;
  }

  int? get totalMortgagesLoan {
    // 리스트를 순회하면서 price 합산
    final myLongMortgagesList =
        _currentRoom.value?.player?[myIndex].mortgagesLoan;
    int total = 0;

    if (myLongMortgagesList != null) {
      for (UserAction cashData in myLongMortgagesList) {
        total += cashData.price!;
      }
    }
    return total;
  }

  int? get totalLoan {
    // 리스트를 순회하면서 price 합산
    final myCreditLoanList = _currentRoom.value?.player?[myIndex].creditLoan;
    final myMortgagesLoanList =
        _currentRoom.value?.player?[myIndex].mortgagesLoan;
    int total = 0;
    if (myCreditLoanList != null) {
      for (UserAction cashData in myCreditLoanList) {
        total += cashData.price!;
      }
    }

    if (myMortgagesLoanList != null) {
      for (UserAction cashData in myMortgagesLoanList) {
        total += cashData.price!;
      }
    }

    debugPrint("totalCash - $total");

    return total;
  }

  int? get totalAsset {
    // 리스트를 순회하면서 price 합산
    final myCashList = _currentRoom.value?.player?[myIndex].cash;
    final myshortSavingList = _currentRoom.value?.player?[myIndex].shortSaving;
    final myLongSavingList = _currentRoom.value?.player?[myIndex].longSaving;
    final myCreditLoanList = _currentRoom.value?.player?[myIndex].creditLoan;
    final myMortgagesList = _currentRoom.value?.player?[myIndex].mortgagesLoan;
    final myInvestList = currentRoomData?.player?[myIndex].investment;
    int total = 0;
    if (myLongSavingList != null) {
      for (UserAction cashData in myLongSavingList) {
        total += cashData.price!;
      }
    }

    if (myshortSavingList != null) {
      for (UserAction cashData in myshortSavingList) {
        total += cashData.price!;
      }
    }

    if (myCreditLoanList != null) {
      for (UserAction cashData in myCreditLoanList) {
        total -= cashData.price!;
      }
    }

    if (myMortgagesList != null) {
      for (UserAction cashData in myMortgagesList) {
        total -= cashData.price!;
      }
    }

    if (myInvestList != null) {
      for (UserAction cashData in myInvestList) {
        total += (cashData.price! * cashData.qty!);
      }
    }

    if (myCashList != null) {
      for (UserAction cashData in myCashList) {
        total += cashData.price!;
      }
    }
    return total;
  }

  //MARK: - 플레이어 액션

  //정상동작 확인 ✅
  Future<void> firstSalary() async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- shortSaving ++
        UserAction(type: "cash", title: "월급", price: 2000000, qty: 1),
      ],
    ));
  }

  //정상동작 확인 ✅
  Future<void> salaryAndIncentive() async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- shortSaving ++
        UserAction(type: "cash", title: "월급", price: 2000000, qty: 1),
        UserAction(type: "cash", title: "인센티브", price: myIncentive, qty: 1),
      ],
    ));
  }

  //정상동작 확인 ✅
  Future<void> shortSavingAction({
    required String title,
    required int price,
  }) async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- shortSaving ++
        UserAction(type: "cash", title: "예금", price: -price, qty: 1),
        UserAction(type: "shortSaving", title: "예금", price: price, qty: 1),
      ],
    ));
    // 턴 넘기기
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  //정상동작 확인 ✅
  Future<void> longSavingAction({
    required String title,
    required int price,
  }) async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- longSaving ++
        UserAction(type: "cash", title: "적금", price: -price, qty: 1),
        UserAction(type: "longSaving", title: "적금", price: price, qty: 1),
      ],
    ));
    // 턴 넘기기
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  Future<void> creditLoanAction({
    required String title,
    required int price,
  }) async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash ++ loan ++
        UserAction(type: "cash", title: "대출 실행", price: price, qty: 1),
        UserAction(type: "creditLoan", title: "대출 실행", price: price, qty: 1),
      ],
    ));
  }

  Future<void> mortgagesLoanAction({
    required String title,
    required int price,
  }) async {
    CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash ++ loan ++
        UserAction(type: "cash", title: "대출 실행", price: price, qty: 1),
        UserAction(type: "mortgagesLoan", title: "대출 실행", price: price, qty: 1),
      ],
    ));
  }

  Future<void> loanRepaymentAction({
    required String title,
    required int price,
  }) async {
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

  //정상동작 확인 ✅
  Future<void> investAction({
    required String title,
    required int price,
    required int qty,
  }) async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- invest ++
        UserAction(type: "cash", title: title, price: -(price * qty), qty: 1),
        UserAction(
            type: "investment",
            title: title,
            price: price,
            qty: qty,
            isItem: true),
      ],
    ));
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  //정상동작 확인 ✅
  Future<void> expendAction({
    required String title,
    required int price,
  }) async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- loan --
        UserAction(type: "cash", title: title, price: -price, qty: 1),
        UserAction(
            type: "expend", title: title, price: -price, qty: 1, isItem: true),
      ],
    ));
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  Future<List<int>> calculateRound() async {
    final int previousTotalAsset = totalAsset ?? 0;
    //저축이자
    final int previousShrotSaving = totalShortSaving ?? 0;
    final int shortSavingInterest =
        totalShortSaving! * (currentSavingRate) ~/ 100 * 3;
    final int previousTotalShortSaving = totalShortSaving ?? 0;
    final int longSavingInterest =
        totalLongSaving! * (currentSavingRate + 2) ~/ 100 * 3;

    //대출이자
    final int creditLoanInterest = totalCreditLoan! * currentLoanRate ~/ 100;
    final int mortgagesLoanInterest =
        totalMortgagesLoan! * (currentLoanRate - 1) ~/ 100;
    final int totalLoanInterest = creditLoanInterest + mortgagesLoanInterest;
    //투자이익
    final int investmentInterest =
        totalInvestment! * (currentInvestRate) ~/ 100;

    int tax = ((totalCash! +
                shortSavingInterest +
                longSavingInterest -
                -totalLoanInterest +
                investmentInterest) *
            0.1)
        .toInt();
    if (tax < 0) {
      tax = 0;
    }

    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        //TODO - 정산 로직

        // 1. 예금
        // shortSaving sum -> shortSaving -- cash ++
        // shortSaving sum * 이번 라운드 이자 -> cash ++
        UserAction(
            type: "cash", title: "예금 출금", price: totalShortSaving!, qty: 1),
        UserAction(
            type: "cash", title: "예금 이자", price: shortSavingInterest, qty: 1),
        UserAction(
            type: "shortSaving",
            title: "출금",
            price: -totalShortSaving!,
            qty: 1),

        // 2. 적금
        // longSaving sum * 이번 라운드 이자 -> longSaving ++
        UserAction(
            type: "longSaving",
            title: "적금 이자",
            price: longSavingInterest,
            qty: 1),

        // 3. 대출
        // loan sum * 이번 라운드 이자 -> cash ++
        // TODO - 담보 신용 대출 금리 따로 적용
        UserAction(
            type: "cash", title: "신용대출 이자", price: -creditLoanInterest, qty: 1),
        UserAction(
            type: "cash",
            title: "담보대출 이자",
            price: -mortgagesLoanInterest,
            qty: 1),
        // 4. 투자
        UserAction(
            type: "investment",
            title: "투자 수익",
            price: investmentInterest,
            qty: 1),

        // 4. 세금
        UserAction(
            type: "cash", title: "$currentRound라운드 세금", price: -tax, qty: 1),

        // UserAction(type: "cash", title: "예금", price: -price, qty: 1),
        // UserAction(type: "shortSaving", title: "예금", price: price, qty: 1),
      ],
    ));
    return [
      previousTotalAsset,
      (previousShrotSaving + shortSavingInterest),
      (longSavingInterest - previousTotalShortSaving),
      investmentInterest,
      -totalLoanInterest,
      -tax,
    ];
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
