//MARK : - 뉴스 콘텐츠 데이터
class NewsArticle {
  String? article1;
  String? article2;
  String? article3;
  String? headline;
  double? investmentVolatility;
  double? loanInterest;
  double? savingsInterest;

  NewsArticle({
    this.article1,
    this.article2,
    this.article3,
    this.headline,
    this.investmentVolatility,
    this.loanInterest,
    this.savingsInterest,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      article1: json['article1'],
      article2: json['article2'],
      article3: json['article3'],
      headline: json['headline'],
      investmentVolatility: (json['investmentVolatility'] as num?)?.toDouble(),
      loanInterest: (json['loanInterest'] as num?)?.toDouble(),
      savingsInterest: (json['savingsInterest'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article1': article1,
      'article2': article2,
      'article3': article3,
      'headline': headline,
      'investmentVolatility': investmentVolatility,
      'loanInterest': loanInterest,
      'savingsInterest': savingsInterest,
    };
  }
}
