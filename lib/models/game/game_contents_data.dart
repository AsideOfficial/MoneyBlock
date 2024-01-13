import 'package:money_cycle/models/game/game_contents_category.dart';

class GameContentsDto {
  final List<GameContentAction>? contentsData;

  GameContentsDto({
    required this.contentsData,
  });

  factory GameContentsDto.fromJson(dynamic json) {
    return GameContentsDto(
      contentsData: (json['contentsData'] as List<dynamic>?)
          ?.map((action) => GameContentAction.fromJson(action))
          .toList(),
    );
  }
}
