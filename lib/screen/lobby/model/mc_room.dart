import 'package:cloud_firestore/cloud_firestore.dart';

class MCRoom {
  final String roomName;
  final String hostId;
  final int roomCode;
  final String gameMode;
  final bool isTeamMode;
  final double savingsInterestRate;
  final double loanInterestRate;
  final double investmentChangeRate;
  final Map<String, dynamic> participants;
  final bool isPlaying;

  MCRoom({
    required this.roomName,
    required this.hostId,
    required this.roomCode,
    required this.gameMode,
    required this.isTeamMode,
    required this.savingsInterestRate,
    required this.loanInterestRate,
    required this.investmentChangeRate,
    required this.participants,
    required this.isPlaying,
  });

  factory MCRoom.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return MCRoom(
      roomName: data?['roomName'] as String,
      hostId: data?['hostId'] as String,
      roomCode: data?['roomCode'] as int,
      gameMode: data?['gameMode'] as String,
      isTeamMode: data?['isTeamMode'] as bool,
      savingsInterestRate: data?['savingsInterestRate'] as double,
      loanInterestRate: data?['loanInterestRate'] as double,
      investmentChangeRate: data?['investmentChangeRate'] as double,
      participants: data?['participants'] as Map<String, dynamic>,
      isPlaying: data?['isPlaying'] as bool,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'roomName': roomName,
      'hostId': hostId,
      'roomCode': roomCode,
      'gameMode': gameMode,
      'isTeamMode': isTeamMode,
      'savingsInterestRate': savingsInterestRate,
      'loanInterestRate': loanInterestRate,
      'investmentChangeRate': investmentChangeRate,
      'participants': participants,
      'isPlaying': isPlaying,
    };
  }
}