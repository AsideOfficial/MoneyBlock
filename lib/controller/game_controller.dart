import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_cycle/models/enums/game_action_type.dart';
import 'package:money_cycle/models/game/game_content_item.dart';
import 'package:money_cycle/models/game/game_data_detail.dart';
import 'package:money_cycle/models/game/lottery.dart';
import 'package:money_cycle/models/game/lucky_lottery.dart';
import 'package:money_cycle/models/game/news_article.dart';
import 'package:money_cycle/models/game/player.dart';
import 'package:money_cycle/models/game_action.dart';
import 'package:money_cycle/screen/play/components/end_game_alert_dialog.dart';
import 'package:money_cycle/screen/play/components/end_round_alert_dialog.dart';
import 'package:money_cycle/screen/play/components/start_game_alert_dialog.dart';
import 'package:money_cycle/services/cloud_fuction_service.dart';
import 'package:money_cycle/services/firebase_real_time_service.dart';
import 'package:money_cycle/utils/snack_bar_util.dart';

import '../constants.dart';

class GameController extends GetxController {
  GameController({required this.roomId, required this.myIndex});
  final String roomId;
  final int myIndex;
  List<GameContentCategory>? expendItems;

  // Mock 데이터를 LuckyLottery 인스턴스로 변환
  List<LuckyLottery> lotteryList =
      mockLotteryData.map((data) => LuckyLottery.fromJson(data)).toList();

  @override
  void onInit() async {
    debugPrint("[게임 컨트롤러 onInit 시작]");
    final roomData = await FirebaseRealTimeService.getRoomData(roomId: roomId);
    final contentsData = await FirebaseRealTimeService.getGameContents();

    for (final content in contentsData!.contentsData!) {
      debugPrint(content.actionType);
      if (content.actionType == "소비") {
        expendItems = content.categories;
      }
    }
    _currentRoom.value = roomData;
    super.onInit();
    bindRoomStream(roomId);
    debugPrint("[게임 컨트롤러 onInit 종료]");
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 1), () {
      Get.dialog(const StartGameAlertDialog(), barrierDismissible: false);
    });
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
    if (currentActionType == GameActionType.expend) {
      _curretnSpecificActionModel.value = SpecifitGameAction(
        title: expendItems![index].type!,
        items: expendItems![index].contents!,
      );
    } else {
      _curretnSpecificActionModel.value = currentActionTypeModel.actions[index];
    }

    debugPrint(_curretnSpecificActionModel.value?.title ?? "");
  }

  void actionButtonTap(GameActionType type) {
    _curretnActionType.value = type;
    _curretnSpecificActionModel.value = null;
    // _curretnSpecificActionModel.value = currentActionTypeModel.actions[0];
    isActionChoicing = true;
  }

  //MARK: - <게임 플레이 리스너

  final Rx<int?> _currentTurnIndex = Rx<int?>(null);
  int? get currentTurnIndex => _currentTurnIndex.value;

  final Rx<int?> _currentRoundIndex = Rx<int?>(null);
  int? get currentRoundIndex {
    if (_currentRoundIndex.value == null) return 0;
    if (_currentRoundIndex.value! >= 2) {
      return 2;
    }
    return _currentRoundIndex.value;
  }

  int get currentRound {
    if (_currentRoundIndex.value != null) {
      return (_currentRoundIndex.value!) + 1;
    } else {
      return 1;
    }
  }

  bool get isVacation {
    if (currentRoom?.player?[myIndex].isVacation == null) return false;
    return currentRoom!.player![myIndex].isVacation!;
  }

  final Rx<bool?> _isGameEnded = Rx<bool?>(false);
  final Rx<GameDataDetails?> _currentRoom = Rx<GameDataDetails?>(null);
  GameDataDetails? get currentRoom => _currentRoom.value;

  //MARK: - 이벤트 핸들러
  Future<void> bindRoomStream(String roomId) async {
    debugPrint("[게임 이벤트 핸들러 바인딩 시작]");
    _currentRoom
        .bindStream(FirebaseRealTimeService.getRoomDataStream(roomId: roomId));
    _currentTurnIndex
        .bindStream(FirebaseRealTimeService.getTurnIndexStream(roomId: roomId));
    _currentRoundIndex.bindStream(
        FirebaseRealTimeService.getRoundIndexStream(roomId: roomId));
    _isGameEnded.bindStream(
        FirebaseRealTimeService.getIsGameEndedStream(roomId: roomId));
    ever(_currentTurnIndex, _turnIndexHandler);
    ever(_currentRoundIndex, _roundIndexHandler);
    ever(_isGameEnded, _endGameHandler);
    debugPrint("[게임 이벤트 핸들러 바인딩 완료]");
  }

  _turnIndexHandler(int? index) {
    //턴 인덱스 핸들러 - 동작 검수 완료 ✅
    debugPrint("_turnIndexHandler 트리거 - index : $index");
    if (index == null) return;
    if (index % (currentRoom!.player?.length ?? 2) == myIndex) {
      debugPrint("$index - 내 차례!");
    } else {
      debugPrint("$index 다른 놈 차례!");
    }
  }

  _roundIndexHandler(int? index) async {
    //라운드 인덱스 핸들러 - 동작 검수 완료 ✅
    debugPrint("_roundIndexHandler 트리거 - index: $index");
    if (index == null) return;
    if (index >= 1 && index < 3) {
      // 1.5초 동안 기다리기
      if (isVacation) {
        Get.back();
      }
      await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
      Get.dialog(
        const EndRoundAlertDialog(),
        name: "라운드 종료 다이얼로그",
        barrierDismissible: false,
      );
    } else if (index > 3) {
      Get.dialog(const EndGameAlertDialog());
    }
  }

  _endGameHandler(bool? isEnd) async {
    // 게임 종료 핸들러
    debugPrint("_endGameHandler 트리거 - 게임 종료 여부 : $isEnd");
    if (isEnd == null) return;
    if (isEnd == true) {
      if (isVacation) {
        Get.back();
      }
      await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
      Get.dialog(const EndGameAlertDialog(),
          barrierDismissible: false, name: "게임 종료 다이얼로그");
    } else {}
    debugPrint("라운드 변경 - ${currentRoom?.roundIndex}");
  }

  //MARK: - </게임 플레이 리스너>

  //MARK: - UI 비즈니스 로직

  List<GameContentItem>? get myInvestmentItems {
    if (currentRoom == null) return null;
    final list = currentRoom!.player?[myIndex].investment
        ?.where((element) => element.isItem == true)
        .toList();
    if (list != null) {
      return list;
    } else {
      return null;
    }
  }

  List<GameContentItem>? get myConsumptionItems =>
      currentRoom!.player?[myIndex].consumption
          ?.where((element) => !(element.isDeleted ?? false))
          .toList();

  List<GameContentItem>? get myInsuranceItems =>
      currentRoom!.player?[myIndex].insurance
          ?.where((element) => !(element.isDeleted ?? false))
          .toList();
  List<GameContentItem>? get myDonationItems =>
      currentRoom!.player?[myIndex].insurance
          ?.where((element) => !(element.isDeleted ?? false))
          .toList();

  List<GameContentItem>? get myExpendItems {
    if (currentRoom == null) return null;
    final List<GameContentItem> result = [];
    final expendList = currentRoom!.player?[myIndex].expend
        ?.where((element) => element.isItem == true)
        .where((element) => !(element.isDeleted ?? false))
        .toList();
    final consumptionList = myConsumptionItems;
    final insuranceList = myInsuranceItems;
    final donationList = currentRoom!.player?[myIndex].donation
        ?.where((element) => !(element.isDeleted ?? false))
        .toList();

    if (expendList != null) {
      result.addAll(expendList);
    }

    if (consumptionList != null && consumptionList.isNotEmpty) {
      result.addAll(consumptionList);
      debugPrint(consumptionList.length.toString());
    }

    if (insuranceList != null && insuranceList.isNotEmpty) {
      result.addAll(insuranceList);
      debugPrint(insuranceList.length.toString());
    }

    if (donationList != null && donationList.isNotEmpty) {
      result.addAll(donationList);
      debugPrint(donationList.length.toString());
    }

    if (result.isEmpty) {
      debugPrint("NONO");
      return null;
    } else {
      // debugPrint("NONO");
      return result;
    }
  }

  Player? get currentTurnPlayer {
    if (currentTurnIndex == null) return null;
    if (currentRoom?.player == null) return null;
    int turn = 0;
    if (currentTurnIndex != 0) {
      turn = (currentTurnIndex! % (currentRoom!.player?.length ?? 2));
    }
    return currentRoom!.player![turn];
  }

  double get currentSavingRate {
    if (currentRoom == null) return 0;
    return currentRoom!.savingRateInfo![currentRoundIndex!];
  }

  double? get previousSavingRate {
    if (currentRoundIndex == 0) {
      return null;
    } else {
      return _currentRoom.value!.savingRateInfo![(currentRoundIndex!) - 1];
    }
  }

  double get currentInvestRate {
    return currentRoom!.investmentRateInfo![currentRoundIndex!];
  }

  double? get previousInvestRate {
    if (currentRoundIndex == 0) {
      return null;
    } else {
      return _currentRoom.value!.investmentRateInfo![(currentRoundIndex!) - 1];
    }
  }

  double get currentLoanRate {
    return currentRoom!.loanRateInfo![currentRoundIndex!];
  }

  double? get previousLoanRate {
    if (currentRoundIndex == 0) {
      return null;
    } else {
      return currentRoom!.loanRateInfo![(currentRoundIndex!) - 1];
    }
  }

  bool get isMyTurn {
    if (currentTurnIndex == null) return false;
    if (currentTurnIndex == 0) {
      return (currentTurnIndex == myIndex);
    } else {
      return (currentTurnIndex! % (currentRoom!.player?.length ?? 2) ==
          myIndex);
    }
  }

  // 뉴스 콘텐츠
  NewsArticle? get currentNews {
    if (currentRoundIndex == null) return null;
    if (currentRoundIndex! < 3) {
      return currentRoom?.news?[currentRoundIndex!];
    }
    return null;
  }

  NewsArticle? get previousNews {
    if (currentRoundIndex! > 0) {
      return currentRoom?.news?[currentRoundIndex! - 1];
    } else {
      return null;
    }
  }

  int getRandomNumber(int max) {
    Random random = Random();
    return random.nextInt(max);
  }

  double? previousRate({required GameActionType actionType}) {
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
    String assetString = "assets/images/profile_cow.png";
    switch (characterIndex) {
      case 0:
        assetString = "assets/images/profile_cow.png";
      case 1:
        assetString = "assets/images/profile_bear.png";
      case 2:
        assetString = "assets/images/profile_pig.png";
      case 3:
        assetString = "assets/images/profile_tiger.png";
    }
    return assetString;
  }

  Color characterBackgroundColor({required int characterIndex}) {
    Color backgroundColor = const Color(0xFFEA5C67);
    switch (characterIndex) {
      case 0:
        backgroundColor = const Color(0xFFEA5C67);
      case 1:
        backgroundColor = const Color(0xFF6969E8);
      case 2:
        backgroundColor = const Color(0xFFF9D746);
      case 3:
        backgroundColor = const Color(0xFF3B892B);
    }
    return backgroundColor;
  }

  Color get myCharacterBackgroundColor {
    final int? myCharacterIndex = currentRoom?.player?[myIndex].characterIndex;
    Color backgroundColor = const Color(0xFFEA5C67);
    switch (myCharacterIndex) {
      case 0:
        backgroundColor = const Color(0xFFEA5C67);
      case 1:
        backgroundColor = const Color(0xFF6969E8);
      case 2:
        backgroundColor = const Color(0xFFF9D746);
      case 3:
        backgroundColor = const Color(0xFF3B892B);
    }
    return backgroundColor;
  }

  String get myCharacterAvatarAssetString {
    final int? myCharacterIndex = currentRoom?.player?[myIndex].characterIndex;
    String assetString = "assets/images/profile_cow.png";
    switch (myCharacterIndex) {
      case 0:
        assetString = "assets/images/profile_cow.png";
      case 1:
        assetString = "assets/images/profile_bear.png";
      case 2:
        assetString = "assets/images/profile_pig.png";
      case 3:
        assetString = "assets/images/profile_tiger.png";
    }
    return assetString;
  }

  String luckyItemAssetString(Lottery item) {
    String assetString = "assets/icons/lottery.png";
    switch (item.title) {
      case "행운복권 당첨!":
        assetString = "assets/icons/lottery.png";
      case "건강 검진":
        assetString = "assets/icons/medical_checkup.png";
      case "자동차 사고":
        assetString = "assets/icons/car_accident.png";
      case "공모전 당선!":
        assetString = "assets/icons/throphy.png";
      case "과속운전":
        assetString = "assets/icons/speeding.png";
      case "친척모임":
        assetString = "assets/icons/allowance.png";
    }
    return assetString;
  }

  // MARK: - 계산 비즈니스 로직

  int getEstimatedPrice({
    required int purchasedPrice,
    required int purchaseRoundIndex,
    required int currentRoundIndex,
  }) {
    int result = purchasedPrice;
    for (var index = 0; index < currentRoundIndex; index++) {
      double currentInvestmentRate =
          currentRoom!.investmentRateInfo![index] / 100;
      if (currentInvestRate < 0) {
        final playerInsuranceList = currentRoom?.player?[myIndex].insurance;
        if (currentTotalInvestmentRate < 1) {
          if (playerInsuranceList != null && playerInsuranceList.isNotEmpty) {
            for (final insurance in playerInsuranceList) {
              if (insurance.title == "사회보장보험2") {
                // 🚧 투자 손익률 보전
                currentInvestmentRate = 0;
              }
            }
          }
        }
      }
      if (purchaseRoundIndex <= index) {
        if (myConsumptionItems!.any(((element) =>
            element.title == "투자관리" && element.isDeleted == false))) {
          // 투자 관리 상품 존재
          final GameContentItem investAdvisorItem =
              myConsumptionItems!.firstWhere(
            (element) => element.title == "투자관리" && element.isDeleted == false,
          );

          if (investAdvisorItem.purchaseRoundIndex! < index) {
            result *= (1 +
                    currentInvestmentRate +
                    investAdvisorItem.preferentialRate! / 100)
                .toInt(); // 투자 금리 혜택 적용
          } else {
            result *= (1 + currentInvestmentRate).toInt();
          }

          debugPrint("getEstimatedPrice() - 투자 관리 상품 존재");
        } else {
          result *= (1 + currentInvestmentRate).toInt();
          debugPrint("getEstimatedPrice() - 투자 관리 상품 존재 X");
        }
      }
    }
    return result;
  }

  double get currentTotalInvestmentRate {
    if (currentRoom == null) return 0;
    double result = 1 + (currentRoom!.investmentRateInfo![0] / 100);
    switch (currentRound) {
      case 1:
        result = 1 + (currentRoom!.investmentRateInfo![0] / 100);

      case 2:
        result = (1 + currentRoom!.investmentRateInfo![0] / 100) *
            (1 + currentRoom!.investmentRateInfo![1] / 100);
      case 3:
        result = (1 + currentRoom!.investmentRateInfo![0] / 100) *
            (1 + currentRoom!.investmentRateInfo![1] / 100) *
            (1 + currentRoom!.investmentRateInfo![2] / 100);
      case 4:
        result = (1 + currentRoom!.investmentRateInfo![0] / 100) *
            (1 + currentRoom!.investmentRateInfo![1] / 100) *
            (1 + currentRoom!.investmentRateInfo![2] / 100);
    }
    return result;
  }

  int get myRanking {
    final rankingList = currentRanking;
    return rankingList.indexOf(currentRoom!.player![myIndex]) + 1;
  }

  int getMyRanking() {
    final rankingList = currentRanking;
    return rankingList.indexOf(currentRoom!.player![myIndex]) + 1;
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

  int getMyIncentive() {
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

  // MARK: - 합산 액
  int? get totalCash {
    // 리스트를 순회하면서 price 합산
    final myCashList = currentRoom?.player?[myIndex].cash;
    int total = 0;
    if (myCashList != null) {
      for (GameContentItem cashData in myCashList) {
        total += cashData.price;
      }
    }
    return total;
  }

  int? get totalInvestment {
    // 리스트를 순회하면서 price 합산
    final myInvestItems = currentRoom?.player?[myIndex].investment;
    int total = 0;

    if (myInvestItems != null) {
      for (GameContentItem investItem in myInvestItems) {
        final estimatedPrice = getEstimatedPrice(
          purchasedPrice: investItem.price * investItem.qty!,
          purchaseRoundIndex: investItem.purchaseRoundIndex!,
          currentRoundIndex: currentRoundIndex!,
        );
        total += estimatedPrice;
      }
    }
    return (total * currentTotalInvestmentRate).toInt();
  }

  int? get totalSaving {
    // 리스트를 순회하면서 price 합산
    final myshortSavingList = currentRoom?.player?[myIndex].shortSaving;
    final myLongSavingList = currentRoom?.player?[myIndex].longSaving;
    int total = 0;
    if (myLongSavingList != null) {
      for (GameContentItem cashData in myLongSavingList) {
        total += cashData.price;
      }
    }

    if (myshortSavingList != null) {
      for (GameContentItem cashData in myshortSavingList) {
        total += cashData.price;
      }
    }

    debugPrint("totalCash - $total");

    return total;
  }

  int? get totalShortSaving {
    // 리스트를 순회하면서 price 합산
    final myshortSavingList = currentRoom?.player?[myIndex].shortSaving;
    int total = 0;

    if (myshortSavingList != null) {
      for (GameContentItem cashData in myshortSavingList) {
        total += cashData.price;
      }
    }
    return total;
  }

  int? get totalLongSaving {
    // 리스트를 순회하면서 price 합산
    final myshortSavingList = currentRoom?.player?[myIndex].longSaving;
    int total = 0;

    if (myshortSavingList != null) {
      for (GameContentItem cashData in myshortSavingList) {
        total += cashData.price;
      }
    }
    return total;
  }

  int? get totalCreditLoan {
    // 리스트를 순회하면서 price 합산
    final myCreditLoanList = currentRoom?.player?[myIndex].creditLoan;
    int total = 0;

    if (myCreditLoanList != null) {
      for (GameContentItem cashData in myCreditLoanList) {
        total += cashData.price;
      }
    }
    return total;
  }

  int? get totalMortgagesLoan {
    // 리스트를 순회하면서 price 합산
    final myLongMortgagesList = currentRoom?.player?[myIndex].mortgageLoan;
    int total = 0;

    if (myLongMortgagesList != null) {
      for (GameContentItem cashData in myLongMortgagesList) {
        total += cashData.price;
      }
    }
    return total;
  }

  int? get totalLoan {
    // 리스트를 순회하면서 price 합산
    final myCreditLoanList = currentRoom?.player?[myIndex].creditLoan;
    final myMortgagesLoanList = currentRoom?.player?[myIndex].mortgageLoan;
    int total = 0;
    if (myCreditLoanList != null) {
      for (GameContentItem cashData in myCreditLoanList) {
        total += cashData.price;
      }
    }

    if (myMortgagesLoanList != null) {
      for (GameContentItem cashData in myMortgagesLoanList) {
        total += cashData.price;
      }
    }

    debugPrint("totalCash - $total");

    return total;
  }

  int? get totalAsset {
    // 리스트를 순회하면서 price 합산
    final myCashList = currentRoom?.player?[myIndex].cash;
    final myshortSavingList = currentRoom?.player?[myIndex].shortSaving;
    final myLongSavingList = currentRoom?.player?[myIndex].longSaving;
    final myCreditLoanList = currentRoom?.player?[myIndex].creditLoan;
    final myMortgagesList = currentRoom?.player?[myIndex].mortgageLoan;
    final myInvestList = currentRoom?.player?[myIndex].investment;
    final playerInsuranceList = currentRoom?.player?[myIndex].insurance;
    int total = 0;
    if (myLongSavingList != null) {
      for (GameContentItem cashData in myLongSavingList) {
        total += cashData.price;
      }
    }

    if (myshortSavingList != null) {
      for (GameContentItem cashData in myshortSavingList) {
        total += cashData.price;
      }
    }

    if (myCreditLoanList != null) {
      for (GameContentItem cashData in myCreditLoanList) {
        total -= cashData.price;
      }
    }

    if (myMortgagesList != null) {
      for (GameContentItem cashData in myMortgagesList) {
        total -= cashData.price;
      }
    }

    if (myInvestList != null) {
      int temp = 0;

      //TODO - 사회보장보험2 효과 적용 완료
      if (currentTotalInvestmentRate < 1) {
        if (playerInsuranceList != null && playerInsuranceList.isNotEmpty) {
          for (final insurance in playerInsuranceList) {
            if (insurance.title == "사회보장보험2") {
              for (GameContentItem cashData in myInvestList) {
                // 투자 손익율 보전
                temp += (cashData.price * cashData.qty! * 1).toInt();
              }
            }
          }
        }
      } else {
        for (GameContentItem cashData in myInvestList) {
          temp += (cashData.price * cashData.qty! * currentTotalInvestmentRate)
              .toInt();
        }
      }

      total += temp;
    }

    if (myCashList != null) {
      for (GameContentItem cashData in myCashList) {
        total += cashData.price;
      }
    }
    return total;
  }

  int playerTotalAsset({required int playerIndex}) {
    // 리스트를 순회하면서 price 합산
    final myCashList = currentRoom?.player?[playerIndex].cash;
    final myshortSavingList = currentRoom?.player?[playerIndex].shortSaving;
    final myLongSavingList = currentRoom?.player?[playerIndex].longSaving;
    final myCreditLoanList = currentRoom?.player?[playerIndex].creditLoan;
    final myMortgagesList = currentRoom?.player?[playerIndex].mortgageLoan;
    final myInvestList = currentRoom?.player?[playerIndex].investment;
    final playerInsuranceList = currentRoom?.player?[playerIndex].insurance;
    int total = 0;
    if (myLongSavingList != null) {
      for (GameContentItem cashData in myLongSavingList) {
        total += cashData.price;
      }
    }

    if (myshortSavingList != null) {
      for (GameContentItem cashData in myshortSavingList) {
        total += cashData.price;
      }
    }

    if (myCreditLoanList != null) {
      for (GameContentItem cashData in myCreditLoanList) {
        total -= cashData.price;
      }
    }

    if (myMortgagesList != null) {
      for (GameContentItem cashData in myMortgagesList) {
        total -= cashData.price;
      }
    }

    if (myInvestList != null) {
      int temp = 0;

      //TODO - 사회보장보험2 효과 적용 완료
      if (currentTotalInvestmentRate < 1) {
        if (playerInsuranceList != null && playerInsuranceList.isNotEmpty) {
          for (final insurance in playerInsuranceList) {
            if (insurance.title == "사회보장보험2") {
              for (GameContentItem cashData in myInvestList) {
                // 투자 손익율 보전
                temp += (cashData.price * cashData.qty! * 1).toInt();
              }
            }
          }
        }
      } else {
        for (GameContentItem cashData in myInvestList) {
          temp += (cashData.price * cashData.qty! * currentTotalInvestmentRate)
              .toInt();
        }
      }

      total += temp;
    }

    if (myCashList != null) {
      for (GameContentItem cashData in myCashList) {
        total += cashData.price;
      }
    }
    return total;
  }

  int get mortgageLoanAvailableAmount {
    final result =
        (totalSaving ?? 0) + (totalInvestment ?? 0) - (totalLoan ?? 0);
    if (result < 0) {
      return 0;
    } else {
      return result;
    }
  }

  List<Player> get currentRanking {
    final players = currentRoom!.player!;
    final List<int> playersTotalAsset = [];
    for (int index = 0; index < players.length; index++) {
      // 플레이어 각각의 총 자산 구해서 리스트에 더함
      playersTotalAsset.add(playerTotalAsset(playerIndex: index));
    }
    List<Player> playerRankingList = sortBySizes(players, playersTotalAsset);
    return playerRankingList;
  }

  List<Player> getCurrentRanking() {
    final players = currentRoom!.player!;
    final List<int> playersTotalAsset = [];
    for (int index = 0; index < players.length; index++) {
      // 플레이어 각각의 총 자산 구해서 리스트에 더함
      playersTotalAsset.add(playerTotalAsset(playerIndex: index));
    }
    List<Player> playerRankingList = sortBySizes(players, playersTotalAsset);
    return playerRankingList;
  }

  List<int> get currentRankingAssetList {
    final players = currentRoom!.player!;
    final List<int> playersTotalAsset = [];
    for (int index = 0; index < players.length; index++) {
      // 플레이어 각각의 총 자산 구해서 리스트에 더함
      playersTotalAsset.add(playerTotalAsset(playerIndex: index));
    }
    playersTotalAsset.sort((a, b) => b.compareTo(a));

    return playersTotalAsset;
  }

  List<int> getCurrentRankingAssetList() {
    final players = currentRoom!.player!;
    final List<int> playersTotalAsset = [];
    for (int index = 0; index < players.length; index++) {
      // 플레이어 각각의 총 자산 구해서 리스트에 더함
      playersTotalAsset.add(playerTotalAsset(playerIndex: index));
    }
    playersTotalAsset.sort((a, b) => b.compareTo(a));

    return playersTotalAsset;
  }

  List<Player> sortBySizes(List<Player> names, List<int> sizes) {
    assert(names.length == sizes.length,
        'Names and sizes must have the same length.');

    List<int> order = List.generate(names.length, (index) => index);

    // 크기가 큰 순서대로 정렬
    order.sort((a, b) => sizes[b].compareTo(sizes[a]));

    // 정렬된 순서에 따라 이름을 가져와 새로운 배열 생성
    List<Player> result = order.map((index) => names[index]).toList();

    return result;
  }

  //MARK: - 플레이어 액션

  Future<Lottery?> getRandomLuckyLottery() async {
    final lottery = await CloudFunctionService.lottery(
        roomId: roomId, playerIndex: myIndex);
    // if (lotteryList.isEmpty) {
    //   throw Exception('행운 복권 콘텐츠 확인 불가.');
    // }

    // Random random = Random();
    // int randomIndex = random.nextInt(lotteryList.length);

    // return lotteryList[randomIndex];
    return lottery;
  }

  Future<void> luckyDrawAction({required Lottery lotteryItem}) async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash +-
        GameContentItem(
            type: "cash",
            title: lotteryItem.title,
            price: lotteryItem.price,
            qty: 1),
      ],
    ));
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  Future<void> endTurn() async {
    if (!isMyTurn) return;
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  Future<void> firstSalary() async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- shortSaving ++
        GameContentItem(type: "cash", title: "월급", price: 2000000, qty: 1),
      ],
    ));
  }

  Future<void> salaryAndIncentive() async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- shortSaving ++
        GameContentItem(type: "cash", title: "월급", price: 2000000, qty: 1),
        GameContentItem(
            type: "cash", title: "인센티브", price: myIncentive, qty: 1),
      ],
    ));
  }

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
        GameContentItem(type: "cash", title: "예금", price: -price, qty: 1),
        GameContentItem(type: "shortSaving", title: "예금", price: price, qty: 1),
      ],
    ));
    // 턴 넘기기
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

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
        GameContentItem(type: "cash", title: "적금", price: -price, qty: 1),
        GameContentItem(type: "longSaving", title: "적금", price: price, qty: 1),
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
        GameContentItem(type: "cash", title: "대출 실행", price: price, qty: 1),
        GameContentItem(
            type: "creditLoan", title: "대출 실행", price: price, qty: 1),
      ],
    ));
  }

  Future<void> creditLoanPaybackAction({
    required String title,
    required int price,
  }) async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash ++ loan ++
        GameContentItem(type: "cash", title: "대출 상환", price: -price, qty: 1),
        GameContentItem(
            type: "creditLoan", title: "대출 상환", price: -price, qty: 1),
      ],
    ));
  }

  Future<void> mortgagesLoanAction({
    required String title,
    required int price,
  }) async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash ++ loan ++
        GameContentItem(type: "cash", title: "대출 실행", price: price, qty: 1),
        GameContentItem(
            type: "mortgageLoan", title: "대출 실행", price: price, qty: 1),
      ],
    ));
  }

  Future<void> mortgagesLoanPaybackAction({
    required String title,
    required int price,
  }) async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash ++ loan ++
        GameContentItem(type: "cash", title: "대출 상환", price: -price, qty: 1),
        GameContentItem(
            type: "mortgageLoan", title: "대출 상환", price: -price, qty: 1),
      ],
    ));
  }

  Future<void> loanRepaymentAction({
    required String title,
    required int price,
  }) async {
    await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- loan --
        GameContentItem(type: "cash", title: "대출 상환", price: -price, qty: 1),
        GameContentItem(type: "loan", title: "대출 상환", price: -price, qty: 1),
      ],
    ));
  }

  Future<void> investAction({
    required String title,
    required int price,
    required int evealuatedPrice,
    required int qty,
  }) async {
    final response = await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- invest ++
        GameContentItem(
            type: "cash",
            title: title,
            price: -(evealuatedPrice * qty),
            qty: 1),
        GameContentItem(
          type: "investment",
          title: title,
          price: price,
          qty: qty,
          isItem: true,
          purchaseRoundIndex: currentRoundIndex,
        ),
      ],
    ));
    if (response?.success == false && response?.message != null) {
      SnackBarUtil.showToastMessage(message: response!.message!);
      return;
    }
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  //정상동작 확인 ✅
  Future<void> expendAction({
    required String title,
    required int price,
    required String? description,
  }) async {
    final response = await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- loan --
        GameContentItem(type: "cash", title: title, price: -price, qty: 1),
        GameContentItem(
          type: "expend",
          title: title,
          price: price,
          qty: 1,
          isItem: true,
          description: description,
        ),
      ],
    ));
    if (response?.success == false && response?.message != null) {
      SnackBarUtil.showToastMessage(message: response!.message!);
      return;
    }
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  Future<void> consumeAction({
    required GameContentItem gameContentItem,
  }) async {
    // TODO - 중복 구매 불가능 처리 필요
    final response = await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- loan --
        gameContentItem.copyWith(purchaseRoundIndex: currentRoundIndex),
        GameContentItem(
            type: "cash",
            title: gameContentItem.title,
            price: -gameContentItem.price,
            qty: 1),
      ],
    ));
    if (response?.success == false && response?.message != null) {
      Get.back(closeOverlays: true);
      SnackBarUtil.showToastMessage(message: response!.message!);
      return;
    }
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
    Get.back();
  }

  Future<void> insuranceAction({
    required GameContentItem gameContentItem,
  }) async {
    debugPrint("${gameContentItem.id!}wow");
    final response = await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- loan --
        gameContentItem,
        GameContentItem(
            type: "cash",
            title: gameContentItem.title,
            price: -gameContentItem.price,
            qty: 1),
      ],
    ));
    if (response?.success == false && response?.message != null) {
      Get.back(closeOverlays: true);
      SnackBarUtil.showToastMessage(message: response!.message!);
      return;
    }

    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
    Get.back();
  }

  Future<void> donationAction({
    required GameContentItem gameContentItem,
  }) async {
    final response = await CloudFunctionService.userAction(
        userAction: PlayerActionDto(
      roomId: roomId,
      playerIndex: myIndex,
      userActions: [
        // cash -- loan --
        gameContentItem,
        GameContentItem(
            type: "cash",
            title: gameContentItem.title,
            price: -gameContentItem.price,
            qty: 1),
      ],
    ));
    if (response?.success == false && response?.message != null) {
      Get.back(closeOverlays: true);
      SnackBarUtil.showToastMessage(message: response!.message!);
      return;
    }
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
    Get.back();
  }

  Future<void> startVacation() async {
    await CloudFunctionService.startVacation(
        roomId: roomId, playerIndex: myIndex);
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  Future<void> useVacation() async {
    await CloudFunctionService.useVacation(
        roomId: roomId, playerIndex: myIndex);
    await CloudFunctionService.endTurn(roomId: roomId, playerIndex: myIndex);
  }

  Future<void> deleteTicket() async {
    await CloudFunctionService.deleteTicket(
        inGameRequest: MCInGameRequest(
      roomId: roomId,
      playerIndex: myIndex,
    ));
    debugPrint("deleteTicket()");
  }

  Future<void> usePrivateInsurance() async {
    final response = await CloudFunctionService.deleteInsurance1(
        inGameRequest: MCInGameRequest(
      roomId: roomId,
      playerIndex: myIndex,
    ));
    if (response?.message != null) {
      SnackBarUtil.showToastMessage(
        message: response!.message!,
      );
    }
    debugPrint("deleteInsurance1()");
  }

  Future<List<int>> calculateRound() async {
    final int previousTotalAsset = totalAsset ?? 0;

    // 예금 계산
    final int previousShrotSaving = totalShortSaving ?? 0;
    final int shortSavingInterest =
        totalShortSaving! * (currentSavingRate) ~/ 100 * 3;
    final int previousTotalShortSaving = totalShortSaving ?? 0;

    // 적금 계산 + 저축 관리 어드바이저 효과 적용
    double preferentialRate = 0;
    if (myConsumptionItems != null) {
      for (final item in myConsumptionItems!) {
        if (item.target == "longSaving") {
          preferentialRate += (item.preferentialRate ?? 0.0);
        }
      }
    }
    if (preferentialRate > 0) {
      debugPrint("저축 관리 어드바이저 존재");
      //TODO - 적금 관리 우대 혜택 적용 팝업 요청시 이 부분에 구현
    }
    final int longSavingInterest = totalLongSaving! *
        (currentSavingRate + 2 + preferentialRate) ~/
        100 *
        3;

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
    } else {
      if (myDonationItems!
          .any((element) => element.id == "dna3" || element.id == "dna4")) {
        final donationItem = myDonationItems!.firstWhere(
            (element) => element.id == "dna3" || element.id == "dna4");
        tax -= donationItem.reductionValue ?? 100000;
      }
    }

    if (tax < 0) {
      tax = 0;
    } else {
      if (myDonationItems!
          .any((element) => element.id == "dna1" || element.id == "dna2")) {
        // 세금 할인
        final donationItem = myDonationItems!.firstWhere(
            (element) => element.id == "dna3" || element.id == "dna4");
        tax = (tax * (donationItem.reductionRate ?? 0.3)).toInt();
      }
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
        GameContentItem(
            type: "cash", title: "예금 출금", price: totalShortSaving!, qty: 1),
        GameContentItem(
            type: "cash", title: "예금 이자", price: shortSavingInterest, qty: 1),
        GameContentItem(
            type: "shortSaving",
            title: "출금",
            price: -totalShortSaving!,
            qty: 1),

        // 2. 적금
        // longSaving sum * 이번 라운드 이자 -> longSaving ++
        GameContentItem(
            type: "longSaving",
            title: "적금 이자",
            price: longSavingInterest,
            qty: 1),

        // 3. 대출
        // loan sum * 이번 라운드 이자 -> cash ++
        // TODO - 담보 신용 대출 금리 따로 적용
        GameContentItem(
            type: "cash", title: "신용대출 이자", price: -creditLoanInterest, qty: 1),
        GameContentItem(
            type: "cash",
            title: "담보대출 이자",
            price: -mortgagesLoanInterest,
            qty: 1),
        // 4. 투자
        // UserAction(
        //     type: "investment",
        //     title: "투자 수익",
        //     price: investmentInterest,
        //     qty: 1),

        // 4. 세금
        GameContentItem(
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

  // MARK : - UI
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

  String get currentDisabledAssetString {
    switch (_curretnActionType.value) {
      case GameActionType.saving:
        return "assets/components/button_square_green_disabled.png";
      case GameActionType.investment:
        return "assets/icons/red_button_disabled.png";
      case GameActionType.expend:
        return "assets/icons/blue_button_disabled.png";
      case GameActionType.loan:
        return "assets/components/button_square_orange_disabled.png";
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
