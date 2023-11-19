// MARK: - 플레이어 데이터
import 'package:money_cycle/models/game/user_action.dart';

class Player {
  List<UserAction>? cash; // 현금
  List<UserAction>? shortSaving; // 예금
  List<UserAction>? longSaving; // 적금
  List<UserAction>? invest; // 투자
  List<UserAction>? expend; // 지출
  List<UserAction>? loan; // 저축

  bool? isReady;
  String? name;

  Player({
    required this.isReady,
    required this.name,
    this.cash,
    this.shortSaving,
    this.longSaving,
    this.invest,
    this.expend,
    this.loan,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      isReady: json['isReady'],
      name: json['name'],
      // cash: (json['cash'] as List<dynamic>?)
      //     ?.map((data) => Map<String, dynamic>.from(data))
      //     .map((json) => UserAction.fromJson(json))
      //     .toList(),
      // shortSaving: (json['shortSaving'] as List<dynamic>?)
      //     ?.map((data) => Map<String, dynamic>.from(data))
      //     .map((json) => UserAction.fromJson(json))
      //     .toList(),
      // longSaving: convertDataToJson(json['longSaving'])

      //     // ?.map((data) => Map<String, dynamic>.from(data))
      //     ?.map((json) => UserAction.fromJson(json))
      //     .toList(),
      // invest: (json['invest'] as List<dynamic>?)
      //     ?.map((data) => Map<String, dynamic>.from(data))
      //     .map((json) => UserAction.fromJson(json))
      //     .toList(),
      // expend: (json['expend'] as List<dynamic>?)
      //     ?.map((data) => Map<String, dynamic>.from(data))
      //     .map((json) => UserAction.fromJson(json))
      //     .toList(),
      // loan: (json['loan'] as List<dynamic>?)
      //     ?.map((data) => Map<String, dynamic>.from(data))
      //     .map((json) => UserAction.fromJson(json))
      //     .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isReady': isReady,
      'name': name,
      'cash': cash?.map((action) => action.toJson()).toList(),
      'shortSaving': shortSaving?.map((action) => action.toJson()).toList(),
      'longSaving': longSaving?.map((action) => action.toJson()).toList(),
      'invest': invest?.map((action) => action.toJson()).toList(),
      'expend': expend?.map((action) => action.toJson()).toList(),
      'loan': loan?.map((action) => action.toJson()).toList(),
    };
  }
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
