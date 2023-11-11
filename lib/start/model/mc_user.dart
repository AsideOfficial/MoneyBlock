import 'package:cloud_firestore/cloud_firestore.dart';

class MCUser {
  final String name;
  final String phoneNumber;
  final String birthday;
  final String gender;
  final String? parentInfo;
  final String? location;

  const MCUser({
    required this.name,
    required this.phoneNumber,
    required this.birthday,
    required this.gender,
    this.parentInfo,
    this.location,
  });

  factory MCUser.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return MCUser(
      name: data?['name'] as String,
      phoneNumber: data?['phoneNumber'] as String,
      birthday: data?['birthday'] as String,
      gender: data?['gender'] as String,
      parentInfo: data?['parentInfo'] as String?,
      location: data?['location'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'birthday': birthday,
      'gender': gender,
      'parentInfo': parentInfo,
      'location': location,
    };
  }
}
