import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_cycle/models/game/player.dart';

class CloudFunctionService {
  static Future<void> userAction({required PlayerActionDto userAction}) async {
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
