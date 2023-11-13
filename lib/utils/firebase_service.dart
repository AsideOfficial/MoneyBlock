import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
}
