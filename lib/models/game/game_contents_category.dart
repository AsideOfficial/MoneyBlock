import 'package:money_cycle/models/game/game_content_item.dart';

class GameContentAction {
  final String? actionType;
  final List<GameContentCategory>? categories;

  GameContentAction({
    required this.actionType,
    required this.categories,
  });

  factory GameContentAction.fromJson(Map<dynamic, dynamic> json) {
    return GameContentAction(
      actionType: json['actionType'],
      categories: (json['categories'] as List<dynamic>?)
          ?.map((category) => GameContentCategory.fromJson(category))
          .toList(),
    );
  }
}
