import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:money_cycle/screen/lobby/model/mc_room.dart';
import 'package:money_cycle/start/model/mc_user.dart';

class FirebaseService {
  static final db = FirebaseFirestore.instance;

  static Future<MCUser?> getUserData({required String userID}) async {
    final userRef =
        FirebaseFirestore.instance.collection('User').doc(userID).withConverter(
              fromFirestore: MCUser.fromFirestore,
              toFirestore: (MCUser user, _) => user.toFirestore(),
            );
    final docSnap = await userRef.get();
    final user = docSnap.data();

    return user;
  }

  static Future<void> updateUserData({required MCUser userData}) async {
    final userRef = FirebaseFirestore.instance
        .collection('User')
        .doc(userData.uid)
        .withConverter(
          fromFirestore: MCUser.fromFirestore,
          toFirestore: (MCUser user, _) => user.toFirestore(),
        );
    await userRef
        .set(userData)
        .onError((e, _) => debugPrint("Error writing document: $e"));
  }

  static String defaultUrl({required String method}) {
    return 'https://$method-nq7btx6efq-du.a.run.app';
  }

  static Future<WaitingRoom?> createRoom({
    required double savingRate,
    required double loanRate,
    required double investmentRate,
    required String uid,
    required String name,
    required int characterIndex,
  }) async {
    final uri = defaultUrl(method: 'createroom');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'savingRate': savingRate,
      'loanRate': loanRate,
      'investmentRate': investmentRate,
      'owner': {
        'uid': uid,
        'name': name,
        'characterIndex': characterIndex,
      }
    });

    try {
      http.Response response =
          await http.post(Uri.parse(uri), headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        final result = WaitingRoom.fromJson(data);
        debugPrint('Create Room Succeed: ${result.toString()}');
        return result;
      } else {
        debugPrint("Error: ${response.statusCode}");
        debugPrint("Response: ${response.body}");
      }
    } catch (e) {
      debugPrint('Failed to Create Room: $e');
    }

    return null;
  }

  static Future<WaitingRoom?> enterRoom({
    required String roomId,
    required String uid,
    required int characterIndex,
  }) async {
    final uri = defaultUrl(method: 'enterroom');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'roomId': roomId,
      'user': {
        'uid': uid,
        'characterIndex': characterIndex,
      }
    });

    try {
      http.Response response =
          await http.post(Uri.parse(uri), headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        final result = WaitingRoom.fromJson(data);
        debugPrint('Enter Room Succeed: ${result.toString()}');
        return result;
      } else {
        debugPrint("Error: ${response.statusCode}");
        debugPrint("Response: ${response.body}");
      }
    } catch (e) {
      debugPrint('Failed to Enter Room: $e');
    }

    return null;
  }

  static Future<WaitingRoom?> updateRateSetting({
    required double savigRate,
    loanRate,
    investmentRate,
    required String roomId,
  }) async {
    final uri = defaultUrl(method: 'updateratesetting');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'savingRate': savigRate,
      'loanRate': loanRate,
      'investmentRate': investmentRate,
      'roomId': roomId,
    });

    try {
      http.Response response =
          await http.post(Uri.parse(uri), headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        final result = WaitingRoom.fromJson(data);
        debugPrint('Update Rate Setting Succeed: ${result.toString()}');
        return result;
      } else {
        debugPrint("Error: ${response.statusCode}");
        debugPrint("Response: ${response.body}");
      }
    } catch (e) {
      debugPrint('Failed to Update Rate Setting: $e');
    }

    return null;
  }

  static Future<WaitingRoom?> readyToggle({
    required String roomId,
    required String uid,
  }) async {
    final uri = defaultUrl(method: 'readytoggle');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'roomId': roomId,
      'uid': uid,
    });

    try {
      http.Response response =
          await http.post(Uri.parse(uri), headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        final result = WaitingRoom.fromJson(data);
        debugPrint('Ready Toggle Succeed: ${result.toString()}');
        return result;
      } else {
        debugPrint("Error: ${response.statusCode}");
        debugPrint("Response: ${response.body}");
      }
    } catch (e) {
      debugPrint('Failed to Toggle Ready: $e');
    }

    return null;
  }

  static Future<WaitingRoom?> startGame({
    required String roomId,
  }) async {
    final uri = defaultUrl(method: 'gamestart');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'roomId': roomId,
    });

    try {
      http.Response response =
          await http.post(Uri.parse(uri), headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        final result = WaitingRoom.fromJson(data);
        debugPrint('Start Game Succeed: ${result.toString()}');
        return result;
      } else {
        debugPrint("Error: ${response.statusCode}");
        debugPrint("Response: ${response.body}");
      }
    } catch (e) {
      debugPrint('Failed to Start Game: $e');
    }

    return null;
  }

  static Future<WaitingRoom?> exitRoom({
    required String roomId,
    required String uid,
  }) async {
    final uri = defaultUrl(method: 'exitroom');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'roomId': roomId,
      'uid': uid,
    });

    try {
      http.Response response =
          await http.post(Uri.parse(uri), headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        final result = WaitingRoom.fromJson(data);
        debugPrint('Exit Room Succeed: ${result.toString()}');
        return result;
      } else {
        debugPrint("Error: ${response.statusCode}");
        debugPrint("Response: ${response.body}");
      }
    } catch (e) {
      debugPrint('Failed to Exit Room: $e');
    }

    return null;
  }
}
