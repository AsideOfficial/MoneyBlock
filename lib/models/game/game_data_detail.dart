import 'package:money_cycle/models/game/news_article.dart';
import 'package:money_cycle/models/game/player.dart';

class GameDataDetails {
  // 플레이 정보
  int turnIndex;
  int roundIndex;
  bool? isEnd;
  bool? isPlaying;
  List<Player>? player;

  // 환경 변수
  List<double>? investmentRateInfo;
  List<double>? loanRateInfo;
  List<double>? savingRateInfo;
  // 콘텐츠
  List<NewsArticle>? news;

  bool? isFull;

  int? max;
  String? theme;
  String? type;

  GameDataDetails({
    required this.investmentRateInfo,
    required this.isEnd,
    required this.isFull,
    required this.isPlaying,
    required this.loanRateInfo,
    required this.max,
    required this.news,
    required this.player,
    required this.roundIndex,
    required this.savingRateInfo,
    required this.theme,
    required this.turnIndex,
    required this.type,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'investmentRateInfo': investmentRateInfo,
  //     'isEnd': isEnd,
  //     'isFull': isFull,
  //     'isPlaying': isPlaying,
  //     'loanRateInfo': loanRateInfo,
  //     'max': max,
  //     'news': news?.map((article) => article.toJson()).toList(),
  //     'player': player?.map((player) => player.toJson()).toList(),
  //     'roundIndex': roundIndex,
  //     'savingRateInfo': savingRateInfo,
  //     'theme': theme,
  //     'turnIndex': turnIndex,
  //     'type': type,
  //   };
  // }

  factory GameDataDetails.fromJson(Map<String, dynamic> json) {
    return GameDataDetails(
      theme: json['theme'] ?? '',
      turnIndex: json['turnIndex'] ?? 0,
      type: json['type'] ?? '',
      isEnd: json['isEnd'] ?? false,
      isFull: json['isFull'] ?? false,
      isPlaying: json['isPlaying'] ?? false,
      max: json['max'] ?? 0,
      roundIndex: json['roundIndex'] ?? 0,
      investmentRateInfo: (json['investmentRateInfo'] as List<dynamic>?)
              ?.sublist(1)
              .map((item) => (item as num).toDouble())
              .toList() ??
          [],
      loanRateInfo: (json['loanRateInfo'] as List<dynamic>?)
              ?.sublist(1)
              .map((item) => (item as num).toDouble())
              .toList() ??
          [],
      savingRateInfo: (json['savingRateInfo'] as List<dynamic>?)
              ?.sublist(1)
              .map((item) => (item as num).toDouble())
              .toList() ??
          [],
      news: (json['news'] as List<dynamic>?)
              ?.map((data) => Map<String, dynamic>.from(data))
              .map((json) => NewsArticle.fromJson(json))
              .toList() ??
          [],
      player: (json['player'] as List<dynamic>?)
              ?.map((data) => Map<String, dynamic>.from(data))
              .map((json) => Player.fromJson(json))
              .toList() ??
          [],
    );
  }
}
