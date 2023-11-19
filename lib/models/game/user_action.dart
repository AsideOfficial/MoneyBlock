//MARK : - 사용자 액션 (장부 기입)
class UserAction {
  String? type;
  String? title;
  int? price;
  int? qty;

  UserAction({
    required this.type,
    required this.title,
    required this.price,
    required this.qty,
  });

  factory UserAction.fromJson(Map<String, dynamic> json) {
    return UserAction(
      type: json['type'],
      title: json['title'],
      price: json['price'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'price': price,
      'qty': qty,
    };
  }
}
