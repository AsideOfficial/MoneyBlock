class LuckyLottery {
  final String? title;
  final String? guide;
  final String? description;
  final int? price;

  LuckyLottery(
      {required this.title,
      required this.guide,
      required this.description,
      required this.price});

  factory LuckyLottery.fromJson(Map<String, dynamic> json) {
    return LuckyLottery(
      title: json['title'] as String?,
      guide: json['guide'] as String?,
      description: json['description'] as String?,
      price: json['price'] as int?,
    );
  }
}

// Mock 데이터
List<Map<String, dynamic>> mockLotteryData = [
  {
    "description": "복권에 당첨되었습니다.",
    "guide": "당첨금을 받아가세요.",
    "price": 500000,
    "title": "행운복권 당첨!",
  },
  {
    "description": "건강을 위한 검사입니다.",
    "guide": "건강 검진비를 납부하세요.",
    "price": -100000,
    "title": "건강 검진",
  },
  {
    "description": "저런, 사고가 났습니다.",
    "guide": "자동차 수리비를 납부하세요.",
    "price": -500000,
    "title": "자동차 사고",
  },
  {
    "description": "공모전에서 1등을 했습니다.",
    "guide": "상금을 받아가세요.",
    "price": 300000,
    "title": "공모전 당선!",
  },
  {
    "description": "과속운전은 절대 안됩니다.",
    "guide": "벌금을 납부하세요.",
    "price": -200000,
    "title": "과속운전",
  },
  {
    "description": "친척 모임에서 용돈을 주셨습니다.",
    "guide": "용돈을 받아가세요.",
    "price": 200000,
    "title": "친척모임",
  },
];
