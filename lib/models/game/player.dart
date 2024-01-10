// MARK: - 플레이어 데이터
import 'package:money_cycle/models/game/user_action.dart';

class Player {
  List<UserAction>? cash; // 현금
  List<UserAction>? shortSaving; // 예금
  List<UserAction>? longSaving; // 적금
  List<UserAction>? investment; // 투자
  List<UserAction>? expend; // 지출
  List<UserAction>? consumption; // 소비
  List<UserAction>? insurance; // 보험
  List<UserAction>? donation; // 기부
  List<UserAction>? creditLoan; // 신용대출
  List<UserAction>? mortgageLoan; // 담보대출

  bool? isReady;
  bool? isVacation;
  String? name;
  int? characterIndex;

  Player({
    required this.isReady,
    required this.name,
    this.cash,
    this.shortSaving,
    this.longSaving,
    this.investment,
    this.expend,
    this.consumption,
    this.insurance,
    this.donation,
    this.creditLoan,
    this.mortgageLoan,
    this.characterIndex,
    this.isVacation,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      isReady: json['isReady'],
      name: json['name'],
      characterIndex: json["characterIndex"],
      isVacation:
          (json["isVacation"] != null) ? json["isVacation"] as bool : false,
      cash: (json['cash'] as List<dynamic>?)
          ?.sublist(1)
          .map((data) => Map<String, dynamic>.from(data))
          .map((json) => UserAction.fromJson(json))
          .toList(),
      shortSaving: (json['shortSaving'] as List<dynamic>?)
          ?.sublist(1)
          .map((data) => Map<String, dynamic>.from(data))
          .map((json) => UserAction.fromJson(json))
          .toList(),
      longSaving: (json['longSaving'] as List<dynamic>?)
          ?.sublist(1)
          .map((data) => Map<String, dynamic>.from(data))
          .map((json) => UserAction.fromJson(json))
          .toList(),
      investment: (json['investment'] as List<dynamic>?)
          ?.sublist(1)
          .map((data) => Map<String, dynamic>.from(data))
          .map((json) => UserAction.fromJson(json))
          .toList(),
      expend: (json['expend'] as List<dynamic>?)
          ?.sublist(1)
          .map((data) => Map<String, dynamic>.from(data))
          .map((json) => UserAction.fromJson(json))
          .toList(),
      consumption: (json['consumption'] as List<dynamic>?)
          ?.sublist(1)
          .map((data) => Map<String, dynamic>.from(data))
          .map((json) => UserAction.fromJson(json))
          .toList(),
      insurance: (json['insurance'] as List<dynamic>?)
          ?.sublist(1)
          .map((data) => Map<String, dynamic>.from(data))
          .map((json) => UserAction.fromJson(json))
          .toList(),
      donation: (json['donation'] as List<dynamic>?)
          ?.sublist(1)
          .map((data) => Map<String, dynamic>.from(data))
          .map((json) => UserAction.fromJson(json))
          .toList(),
      creditLoan: (json['creditLoan'] as List<dynamic>?)
          ?.sublist(1)
          .map((data) => Map<String, dynamic>.from(data))
          .map((json) => UserAction.fromJson(json))
          .toList(),
      mortgageLoan: (json['mortgageLoan'] as List<dynamic>?)
          ?.sublist(1)
          .map((data) => Map<String, dynamic>.from(data))
          .map((json) => UserAction.fromJson(json))
          .toList(),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'isReady': isReady,
  //     'name': name,
  //     'cash': cash?.map((action) => action.toJson()).toList(),
  //     'shortSaving':
  //         shortSaving?.sublist(1).map((action) => action.toJson()).toList(),
  //     'longSaving':
  //         longSaving?.sublist(1).map((action) => action.toJson()).toList(),
  //     'invest': invest?.sublist(1).map((action) => action.toJson()).toList(),
  //     'expend': expend?.sublist(1).map((action) => action.toJson()).toList(),
  //     'loan': loan?.sublist(1).map((action) => action.toJson()).toList(),
  //   };
  // }
}

Map<String, dynamic>? convertDataToJson(Map<dynamic, dynamic>? data) {
  if (data != null) {
    return Map<String, dynamic>.from(data);
  } else {
    return null;
  }
}

class PlayerActionDto {
  String? roomId;
  int? playerIndex;
  List<UserAction>? userActions;

  PlayerActionDto({
    this.roomId,
    this.playerIndex,
    this.userActions,
  });

  factory PlayerActionDto.fromJson(Map<String, dynamic> json) {
    return PlayerActionDto(
      roomId: json['roomId'],
      playerIndex: json['playerIndex'],
      userActions: (json['userActions'] as List<dynamic>?)
          ?.map((item) => UserAction.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'playerIndex': playerIndex,
      'userActions': userActions?.map((action) => action.toJson()).toList(),
    };
  }
}
