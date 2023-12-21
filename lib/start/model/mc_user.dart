import 'package:cloud_firestore/cloud_firestore.dart';

class MCUser {
  final String uid;
  final String name;
  final String nickNm;
  final int profileImageIndex;
  final String? phoneNumber;
  final String? birthday;
  final String? gender;
  final String? parentInfo;
  final String? location;

  const MCUser({
    required this.uid,
    required this.name,
    required this.nickNm,
    required this.profileImageIndex,
    this.phoneNumber,
    this.birthday,
    this.gender,
    this.parentInfo,
    this.location,
  });

  factory MCUser.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return MCUser(
      uid: data?['uid'] as String,
      name: data?['name'] as String,
      nickNm: data?['nickNm'] as String,
      profileImageIndex: data?['profileImageIndex'] as int,
      phoneNumber: data?['phoneNumber'] as String?,
      birthday: data?['birthday'] as String?,
      gender: data?['gender'] as String?,
      parentInfo: data?['parentInfo'] as String?,
      location: data?['location'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'name': name,
      'nickNm': nickNm,
      'profileImageIndex': profileImageIndex,
      'phoneNumber': phoneNumber,
      'birthday': birthday,
      'gender': gender,
      'parentInfo': parentInfo,
      'location': location,
    };
  }
}
