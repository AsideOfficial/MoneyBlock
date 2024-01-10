class GameContentItem {
  final String? id;
  final String title;
  final String? subTitle;
  final String? description;
  final String? guide;
  final int price;

  // UserAction 과 통합
  String? type;
  bool? isItem;
  int? qty;

  GameContentItem({
    this.id,
    required this.title,
    this.subTitle,
    this.description,
    this.guide,
    required this.price,
    this.isItem,
    this.qty,
    this.type,
  });

  factory GameContentItem.fromJson(Map<String, dynamic> json) {
    return GameContentItem(
      id: json['id'],
      title: json['title'],
      subTitle: json['subTitle'],
      description: json['description'],
      guide: json['guide'],
      price: json['price'],
      type: json['type'],
      isItem: json['isItem'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subTitle': subTitle,
      'description': description,
      'guide': guide,
      'price': price,
      'type': type,
      'isItem': isItem,
      'qty': qty,
    };
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
          ?.map(
              (item) => GameContentItem.fromJson(item.cast<String, dynamic>()))
          .toList(),
      type: json['type'],
    );
  }
}
