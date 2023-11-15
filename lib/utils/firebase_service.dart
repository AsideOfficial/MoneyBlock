import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:money_cycle/screen/lobby/model/mc_room.dart';
import 'package:money_cycle/start/model/mc_user.dart';

class FirebaseService {
  static final db = FirebaseFirestore.instance;

  static final roomRef =
      FirebaseFirestore.instance.collection('Room').withConverter(
            fromFirestore: MCRoom.fromFirestore,
            toFirestore: (MCRoom room, _) => room.toFirestore(),
          );

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

  static Future<void> createRoom({required MCRoom roomData}) async {
    await roomRef.add(roomData);
  }

  static Future<int> createUniqueCode() async {
    Random random = Random();
    int randomInt = random.nextInt(900000) + 100000;
    var result = await roomRef.where('roomCode', isEqualTo: randomInt).get();

    while (result.docs.isNotEmpty) {
      randomInt = random.nextInt(900000) + 100000;
      result = await roomRef.where('roomCode', isEqualTo: randomInt).get();
    }

    return randomInt;
  }

  static Future<void> updateRoom({
    required String roomId,
    required String key,
    required dynamic value,
  }) async {
    roomRef.doc(roomId).update({key: value}).then(
        (value) => debugPrint("DocumentSnapshot successfully updated!"),
        onError: (e) => debugPrint("Error updating document $e"));
  }

  static Future<String> getRoomId({required int code}) async {
    final snapshot = await roomRef.where('roomCode', isEqualTo: code).get();
    final id = snapshot.docs[0].id;

    return id;
  }

  static Future<void> removeRoom({required String roomID}) async {
    await roomRef.doc(roomID).delete();
  }

  static Future<(bool, String)> participateRoom(
      {required String roomCode}) async {
    try {
      final roomId = await getRoomId(code: int.parse(roomCode));
      final roomData = await roomRef.doc(roomId).get();
      var currentParticipants = roomData.data()?.participants;
      final newParticipant = <String, bool>{
        FirebaseAuth.instance.currentUser!.uid: false
      };
      currentParticipants?.addAll(newParticipant);

      await updateRoom(
          roomId: roomId, key: 'participants', value: currentParticipants);

      return (true, roomId);
    } catch (e) {
      debugPrint('participate failed: $e');
      return (false, '');
    }
  }
}
