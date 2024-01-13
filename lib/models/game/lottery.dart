class Lottery {
  String description;
  String guide;
  int price;
  String title;

  Lottery({
    required this.description,
    required this.guide,
    required this.price,
    required this.title,
  });

  factory Lottery.fromJson(Map<String, dynamic> json) {
    return Lottery(
      description: json['lottery']['description'],
      guide: json['lottery']['guide'],
      price: json['lottery']['price'],
      title: json['lottery']['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lottery': {
        'description': description,
        'guide': guide,
        'price': price,
        'title': title,
      },
    };
  }
}
