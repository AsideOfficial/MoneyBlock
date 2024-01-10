import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_cycle/models/game/lottery.dart';
import 'package:money_cycle/models/game/player.dart';

class MCResponse {
  final bool? success;
  final String? message;

  MCResponse({required this.success, required this.message});

  factory MCResponse.fromJson(Map<String, dynamic> json) {
    return MCResponse(
      success: json['success'] as bool?,
      message: json['message'],
    );
  }
}

class MCInGameRequest {
  final String roomId;
  final int playerIndex;

  MCInGameRequest({required this.roomId, required this.playerIndex});

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'playerIndex': playerIndex,
    };
  }
}

class CloudFunctionService {
  static Future<MCResponse?> userAction({
    required PlayerActionDto userAction,
  }) async {
    const String cloudFunctionUrl =
        'https://useraction-nq7btx6efq-du.a.run.app';
    final uri = Uri.parse(cloudFunctionUrl);

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(userAction.toJson()),
      );

      if (response.statusCode == 200) {
        debugPrint('클라우드 함수 응답: ${response.body}');
        Map<String, dynamic> jsonMap =
            Map<String, dynamic>.from(json.decode(response.body));

        MCResponse mcResponse = MCResponse.fromJson(jsonMap);
        debugPrint("CloudFunctionService - userAction ${mcResponse.success}");
        debugPrint("CloudFunctionService - userAction ${mcResponse.message}");
        return mcResponse;
      } else {
        debugPrint(
            '클라우드 함수 요청 실패 \n- HTTP 오류 코드: ${response.statusCode} \n - 에러 메세지: ${response.body}');
      }
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final mcResponse = MCResponse.fromJson(jsonData);
      return mcResponse;
    } catch (e) {
      debugPrint('클라우드 함수 요청 실패 - 예외 발생: $e');
    }
    return null;
  }

  static Future<MCResponse?> deleteTicket(
      {required MCInGameRequest inGameRequest}) async {
    const String cloudFunctionUrl =
        'https://deleteTickets-nq7btx6efq-du.a.run.app';
    final uri = Uri.parse(cloudFunctionUrl);

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(inGameRequest.toJson()),
      );

      final json = jsonDecode(response.body);
      final mcResponse = MCResponse.fromJson(json);

      if (response.statusCode == 200) {
        debugPrint('클라우드 함수 응답: ${response.body}');
        return mcResponse;
      } else {
        debugPrint(
            '클라우드 함수 요청 실패 \n- HTTP 오류 코드: ${response.statusCode} \n - 에러 메세지: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('클라우드 함수 요청 실패 - 예외 발생: $e');
      return null;
    }
  }

  static Future<MCResponse?> deleteInsurance1(
      {required MCInGameRequest inGameRequest}) async {
    const String cloudFunctionUrl =
        'https://deleteInsurance1-nq7btx6efq-du.a.run.app';
    final uri = Uri.parse(cloudFunctionUrl);

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(inGameRequest.toJson()),
      );

      final json = jsonDecode(response.body);
      final mcResponse = MCResponse.fromJson(json);

      if (response.statusCode == 200) {
        debugPrint('클라우드 함수 응답: ${response.body}');
        return mcResponse;
      } else {
        debugPrint(
            '클라우드 함수 요청 실패 \n- HTTP 오류 코드: ${response.statusCode} \n - 에러 메세지: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('클라우드 함수 요청 실패 - 예외 발생: $e');
      return null;
    }
  }

  static Future<void> startVacation(
      {required String roomId, required num playerIndex}) async {
    const String cloudFunctionUrl =
        'https://startvacation-nq7btx6efq-du.a.run.app';
    final uri = Uri.parse(cloudFunctionUrl);

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "roomId": roomId,
          "playerIndex": playerIndex,
        }),
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

  static Future<void> useVacation(
      {required String roomId, required num playerIndex}) async {
    const String cloudFunctionUrl =
        'https://usevacation-nq7btx6efq-du.a.run.app';
    final uri = Uri.parse(cloudFunctionUrl);

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "roomId": roomId,
          "playerIndex": playerIndex,
        }),
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

  static Future<Lottery?> lottery({
    required String roomId,
    required num playerIndex,
  }) async {
    const String cloudFunctionUrl = 'https://lottery-nq7btx6efq-du.a.run.app/';
    final uri = Uri.parse(cloudFunctionUrl);

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "roomId": roomId,
          "playerIndex": playerIndex,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('클라우드 함수 응답: ${response.body}');
        // TODO: 성공 핸들링
        // JSON을 Lottery 모델로 파싱
        final lottery = Lottery.fromJson(json.decode(response.body));
        debugPrint(lottery.description);
        return lottery;
      } else {
        debugPrint(
            '클라우드 함수 요청 실패 \n- HTTP 오류 코드: ${response.statusCode} \n - 에러 메세지: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('클라우드 함수 요청 실패 - 예외 발생: $e');
      // TODO: 실패 핸들링
      return null;
    }
  }

  static Future<void> endTurn(
      {required String roomId, required num playerIndex}) async {
    const String cloudFunctionUrl = 'https://turnended-nq7btx6efq-du.a.run.app';
    final uri = Uri.parse(cloudFunctionUrl);

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "roomId": roomId,
          "playerIndex": playerIndex,
        }),
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

// ... (the rest of the classes remain the same)
