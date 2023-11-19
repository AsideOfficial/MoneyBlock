import 'package:money_cycle/models/game/game_data_detail.dart';

class RoomData {
  String? roomId;
  GameDataDetails? data;

  RoomData({
    required this.roomId,
    required this.data,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'roomId': roomId,
  //     'data': data?.toJson(),
  //   };
  // }

  factory RoomData.fromJson(Map<String, dynamic> json) {
    return RoomData(
      roomId: json['roomId'],
      data:
          json['data'] != null ? GameDataDetails.fromJson(json['data']) : null,
    );
  }
}
