import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CloudFunctionService {
  static Future<void> userAction({required RoomData roomData}) async {
    const String cloudFunctionUrl =
        'https://useraction-nq7btx6efq-du.a.run.app';
    final uri = Uri.parse(cloudFunctionUrl);

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(roomData.toJson()),
      );

      if (response.statusCode == 200) {
        debugPrint('클라우드 함수 응답: ${response.body}');
        // TODO: 성공 핸들링
      } else {
        debugPrint(
            '클라우드 함수 요청 실패 \n- HTTP 오류 코드: ${response.statusCode} \n - 에러 메세지: ${response.body}');
      }
    } catch (e) {
      debugPrint('클라우드 함수 요청 실패 - 예외 발생: $e');
      // TODO: 실패 핸들링
    }
  }
}

class UserAction {
  String type;
  String title;
  int price;
  int qty;

  UserAction({
    required this.type,
    required this.title,
    required this.price,
    required this.qty,
  });

  factory UserAction.fromJson(Map<String, dynamic> json) {
    return UserAction(
      type: json['type'],
      title: json['title'],
      price: json['price'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'price': price,
      'qty': qty,
    };
  }
}

class RoomData {
  String roomId;
  int playerIndex;
  List<UserAction> userActions;

  RoomData({
    required this.roomId,
    required this.playerIndex,
    required this.userActions,
  });

  factory RoomData.fromJson(Map<String, dynamic> json) {
    List<dynamic> actionsList = json['userActions'];
    List<UserAction> actions =
        actionsList.map((e) => UserAction.fromJson(e)).toList();

    return RoomData(
      roomId: json['roomId'],
      playerIndex: json['playerIndex'],
      userActions: actions,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> actions =
        userActions.map((e) => e.toJson()).toList();

    return {
      'roomId': roomId,
      'playerIndex': playerIndex,
      'userActions': actions,
    };
  }
}
