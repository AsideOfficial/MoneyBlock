//MARK : - 사용자 액션 (장부 기입)
class UserAction {
  String? type;
  bool? isItem;
  String? title;
  int? price;
  int? qty;
  String? description;

  UserAction({
    required this.type,
    required this.title,
    required this.price,
    required this.qty,
    this.description,
    this.isItem = false,
  });

  factory UserAction.fromJson(Map<String, dynamic> json) {
    return UserAction(
      type: json['type'],
      title: json['title'],
      price: json['price'],
      qty: json['qty'],
      isItem: json["isItem"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'price': price,
      'qty': qty,
      'isItem': isItem,
      "description": description
    };
  }
}
