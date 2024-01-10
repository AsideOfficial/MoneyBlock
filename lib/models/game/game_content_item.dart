class GameContentItem {
  final String? id;
  final String title;
  final String? subTitle;
  final String? description;
  final String? guide;
  final int price;
  final int? purchaseRoundIndex;

  // UserAction 과 통합
  String? type;
  bool? isItem;
  int? qty;

  // 지출 컨텐츠 이자율 우대 혜택 데이터
  int? preferentialRate;
  String? target; // 우대 혜택 적용 대상
  final bool? isDeleted;

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
    this.preferentialRate,
    this.target,
    this.purchaseRoundIndex,
    this.isDeleted,
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
      isItem: json['isItem'] as bool?,
      preferentialRate: json["preferentialRate"] as int?,
      qty: json['qty'],
      target: json["longSaving"],
      purchaseRoundIndex: json["purchaseRoundIndex"],
      isDeleted: json["isDeleted"] as bool?,
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
      "preferentialRate": preferentialRate,
      "target": target,
      "purchaseRoundIndex": purchaseRoundIndex,
      "isDeleted": isDeleted,
    };
  }

  GameContentItem copyWith({
    String? id,
    String? title,
    String? subTitle,
    String? description,
    String? guide,
    int? price,
    int? purchaseRoundIndex,
    String? type,
    bool? isItem,
    int? qty,
    int? preferentialRate,
    String? target,
    bool? isDeleted,
  }) {
    return GameContentItem(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      description: description ?? this.description,
      guide: guide ?? this.guide,
      price: price ?? this.price,
      purchaseRoundIndex: purchaseRoundIndex ?? this.purchaseRoundIndex,
      type: type ?? this.type,
      isItem: isItem ?? this.isItem,
      qty: qty ?? this.qty,
      preferentialRate: preferentialRate ?? this.preferentialRate,
      target: target ?? this.target,
      isDeleted: isDeleted ?? this.isDeleted,
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
          ?.map(
              (item) => GameContentItem.fromJson(item.cast<String, dynamic>()))
          .toList(),
      type: json['type'],
    );
  }
}
