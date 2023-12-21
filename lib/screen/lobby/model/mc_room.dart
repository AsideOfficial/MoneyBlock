class WaitingRoom {
  WaitingRoom({
    required this.roomId,
    this.roomData,
  });
  late final String roomId;
  late final RoomData? roomData;

  WaitingRoom.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'] ?? '';
    roomData = json['data'] != null ? RoomData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['roomId'] = roomId;
    data['data'] = roomData?.toJson();
    return data;
  }

  @override
  String toString() {
    return 'WaitingRoom: {roomId: $roomId}, data: $roomData}';
  }
}

class RoomData {
  RoomData({
    required this.isPlaying,
    required this.isFull,
    required this.isEnd,
    required this.roundIndex,
    required this.turnIndex,
    required this.player,
    required this.theme,
    required this.type,
    required this.max,
    required this.news,
    required this.savingRateInfo,
    required this.loanRateInfo,
    required this.investmentRateInfo,
  });
  late final bool isPlaying;
  late final bool isFull;
  late final bool isEnd;
  late final int roundIndex;
  late final int turnIndex;
  late final List<Player>? player;
  late final String theme;
  late final String type;
  late final int max;
  late final List<News> news;
  late final List<double> savingRateInfo;
  late final List<double> loanRateInfo;
  late final List<double> investmentRateInfo;

  RoomData.fromJson(Map<String, dynamic> json) {
    isPlaying = json['isPlaying'];
    isFull = json['isFull'];
    isEnd = json['isEnd'];
    roundIndex = json['roundIndex'];
    turnIndex = json['turnIndex'];
    player = List.from(json['player'] ?? [])
        .map((e) => Player.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    theme = json['theme'];
    type = json['type'];
    max = json['max'];
    news = List.from(json['news'])
        .map((e) => News.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    savingRateInfo = List.castFrom<dynamic, dynamic>((json['savingRateInfo']))
        .map((e) => double.parse(e.toString()))
        .toList();
    loanRateInfo = List.castFrom<dynamic, dynamic>(json['loanRateInfo'])
        .map((e) => double.parse(e.toString()))
        .toList();
    investmentRateInfo =
        List.castFrom<dynamic, dynamic>(json['investmentRateInfo'])
            .map((e) => double.parse(e.toString()))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isPlaying'] = isPlaying;
    data['isFull'] = isFull;
    data['isEnd'] = isEnd;
    data['roundIndex'] = roundIndex;
    data['turnIndex'] = turnIndex;
    data['player'] = player?.map((e) => e.toJson()).toList();
    data['theme'] = theme;
    data['type'] = type;
    data['max'] = max;
    data['news'] = news.map((e) => e.toJson()).toList();
    data['savingRateInfo'] = savingRateInfo;
    data['loanRateInfo'] = loanRateInfo;
    data['investmentRateInfo'] = investmentRateInfo;
    return data;
  }
}

class Player {
  Player({
    required this.uid,
    required this.name,
    required this.characterIndex,
    required this.isReady,
  });

  late final String uid;
  late final String name;
  late final int characterIndex;
  late final bool isReady;

  Player.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    characterIndex = json['characterIndex'];
    isReady = json['isReady'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['characterIndex'] = characterIndex;
    data['isReady'] = isReady;
    return data;
  }
}

class News {
  News({
    required this.article1,
    required this.article2,
    required this.article3,
    required this.headline,
    required this.investmentVolatility,
    required this.loanInterest,
    required this.savingsInterest,
  });
  late final String article1;
  late final String article2;
  late final String article3;
  late final String headline;
  late final double investmentVolatility;
  late final double loanInterest;
  late final double savingsInterest;

  News.fromJson(Map<String, dynamic> json) {
    article1 = json['article1'];
    article2 = json['article2'];
    article3 = json['article3'];
    headline = json['headline'];
    investmentVolatility =
        double.parse(json['investmentVolatility'].toString());
    loanInterest = double.parse(json['loanInterest'].toString());
    savingsInterest = double.parse(json['savingsInterest'].toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['article1'] = article1;
    data['article2'] = article2;
    data['article3'] = article3;
    data['headline'] = headline;
    data['investmentVolatility'] = investmentVolatility;
    data['loanInterest'] = loanInterest;
    data['savingsInterest'] = savingsInterest;
    return data;
  }
}
