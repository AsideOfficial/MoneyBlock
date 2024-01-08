class GameContentItem {
  final String? id;
  final String? title;
  final String? subTitle;
  final String? description;
  final String? guide;
  final int? price;

  GameContentItem({
    this.id,
    this.title,
    this.subTitle,
    this.description,
    this.guide,
    this.price,
  });

  factory GameContentItem.fromJson(Map<dynamic, dynamic> json) {
    return GameContentItem(
      id: json['id'],
      title: json['title'],
      subTitle: json['subTitle'],
      description: json['description'],
      guide: json['guide'],
      price: json['price'],
    );
  }
}

class GameContentCategory {
  final List<GameContentItem>? contents;
  final String? type;

  GameContentCategory({
    required this.contents,
    required this.type,
  });

  factory GameContentCategory.fromJson(Map<dynamic, dynamic> json) {
    return GameContentCategory(
      contents: (json['contents'] as List<dynamic>?)
          ?.map((item) => GameContentItem.fromJson(item))
          .toList(),
      type: json['type'],
    );
  }
}

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

class GameContentsData {
  final List<GameContentAction>? contentsData;

  GameContentsData({
    required this.contentsData,
  });

  factory GameContentsData.fromJson(Map<String, dynamic> json) {
    return GameContentsData(
      contentsData: (json['contentsData'] as List<dynamic>?)
          ?.map((action) => GameContentAction.fromJson(action))
          .toList(),
    );
  }
}
