import 'package:money_cycle/models/game/game_content_item.dart';

class GameAction {
  final String title; // 예: 저축, 지출, 대출
  final String description; // 예 : 예금: 은행에 자유롭게 맡기는 돈\n적금: 은행에 라운드마다 정기적으로 맡기는 돈
  final String? rateTitle; // 예: 저축금리, 투자변동률, 대출금리
  final String? rateDescription; // 예: {rateTitle}란? "맡긴 돈에 대한 이자"
  final List<Rate>? rates; // 금리 콘텐츠
  final List<SpecifitGameAction> actions; // 세부적인 액션들 예 : 예금, 적금

  GameAction({
    required this.title,
    required this.description,
    required this.actions,
    this.rateTitle,
    this.rateDescription,
    this.rates,
  });
}

class Rate {
  final String title; // 금리의 이름 예 : 예금금리, 적금금리, 투자변동률
  final List<double> rateFluctuation; // 금리 변동 추이 예 : [2, 3, 4, 2]

  Rate({required this.title, required this.rateFluctuation});
}

class SpecifitGameAction {
  final String title; // 예 : 예금, 적금, 주식, 실물자산, 부동산
  final List<GameContentItem> items; // 저축, 대출은 필요 X
  final String? priceTitle;

  SpecifitGameAction(
      {required this.title, required this.items, this.priceTitle});
}

// class GameContentItem {
//   final String title;
//   final String? subTitle;
//   final int price;
//   final String? description;
//   // final String? priceTitle;

//   GameContentItem({
//     required this.title,
//     this.subTitle,
//     this.description,
//     required this.price,
//   });
// }

final savingModel = GameAction(
  title: "저축",
  description: """
예금: 은행에 자유롭게 1번 맡기는 돈
적금: 은행에 라운드마다 정기적으로 맡기는 돈
""",
  rateTitle: "저축금리",
  rateDescription: "맡긴 돈에 대한 이자",
  rates: [
    Rate(title: "예금금리", rateFluctuation: [2, 4]),
    Rate(title: "저축금리", rateFluctuation: [4, 6])
  ],
  actions: [
    SpecifitGameAction(title: '예금', items: [
      GameContentItem(
          title: "예금1", description: "예금 상품 1에 대한 설명", price: 100000),
      GameContentItem(
          title: "예금2", description: "예금 상품 1에 대한 설명", price: 300000),
      GameContentItem(
          title: "예금3", description: "예금 상품 1에 대한 설명", price: 500000),
      GameContentItem(
          title: "예금4", description: "예금 상품 1에 대한 설명", price: 1000000),
    ]),
    SpecifitGameAction(title: '적금', items: [
      GameContentItem(
          title: "적금1", description: "적금 상품 1에 대한 설명", price: 100000),
      GameContentItem(
          title: "적금2", description: "적금 상품 2에 대한 설명", price: 300000),
      GameContentItem(
          title: "적금3", description: "적금 상품 3에 대한 설명", price: 500000),
      GameContentItem(
          title: "적금4", description: "적금 상품 4에 대한 설명", price: 1000000),
    ])
  ],
);

final investmentModel = GameAction(
  title: "투자",
  description: """
주식: 회사에 돈을 투자하는 것.
실물자산: 금, 보석철럼 가치있는 물건에 돈을 투자하는 것.
부동산: 땅, 건물에 돈을 투자하는 것.
펀드: 전문가를 통해 돈을 투자하는 것.
""",
  rateTitle: "투자변동률",
  rateDescription: "투자한 돈이 오르거나 내려가는 변동률",
  rates: [
    Rate(title: "변동률", rateFluctuation: [10])
  ],
  actions: [
    SpecifitGameAction(title: '주식', priceTitle: "한 주 가격", items: [
      GameContentItem(title: "전기전자", price: 1000000),
      GameContentItem(title: "금융", price: 100000),
      GameContentItem(title: "철강", price: 300000),
      GameContentItem(title: "제약", price: 70000),
    ]),
    SpecifitGameAction(title: '실물자산', priceTitle: "구매 가격", items: [
      GameContentItem(title: "금", price: 200000),
      GameContentItem(title: "미술품", price: 500000),
      GameContentItem(title: "다이아몬드", price: 700000),
      GameContentItem(title: "기념주화", price: 50000),
    ]),
    SpecifitGameAction(title: '부동산', priceTitle: "매매 가격", items: [
      GameContentItem(title: "서울", price: 3000000),
      GameContentItem(title: "대전", price: 4300000),
      GameContentItem(title: "광주", price: 1200000),
      GameContentItem(title: "부산", price: 650000),
    ]),
    SpecifitGameAction(title: '펀드', priceTitle: "구매 가격", items: [
      GameContentItem(title: "카이마루\n부자시리즈", price: 100000),
      GameContentItem(title: "안전에셋\n더드림", price: 300000),
      GameContentItem(title: "탁월해\n투자신탁", price: 500000),
      GameContentItem(title: "글로벌\n베스트", price: 1000000),
    ]),
  ],
);

final expendModel = GameAction(
  title: "지출",
  description: """
소비: 현금으로 사는, 게임 Play 혜택!
보험: 현금으로 위험 대비! 나를 지켜줘!
기부: 현금으로 하는 좋은 일, 세금 혜택 팡팡!
""",
  actions: [
    SpecifitGameAction(title: '소비', items: [
      GameContentItem(
          title: "저축관리\n어드바이저", description: "금리우대 혜약", price: 100000),
      GameContentItem(
          title: "투자관리\n어드바이저", description: "투자상승률 우대 혜택", price: 300000),
      GameContentItem(
          title: "주사위\n특권",
          description: "홀짝 골라서 그 중에서만 결과값 나오도록",
          price: 500000),
      GameContentItem(
          title: "주사위\n1회권",
          description: "라운즈 중, 한번 더 주사위 굴리고 한 턴 더 진행하기 가능",
          price: 1000000),
    ]),
    SpecifitGameAction(title: '보험', items: [
      GameContentItem(
          title: "민영보험1", description: "행운복권에서 불운 1번 피하기 가능", price: 100000),
      GameContentItem(
          title: "민영보험2", description: "행운복권에서 불운 무제한 피하기 가능", price: 300000),
      GameContentItem(
          title: "사회보장보험1",
          description: "무급휴가 칸에서 쉬지 않고 게임진행 가능",
          price: 70000),
      GameContentItem(
          title: "사회보장보험2",
          description: "마이너스 투자수익률시 0%로 손실 보전",
          price: 300000),
    ]),
    SpecifitGameAction(title: '기부', items: [
      GameContentItem(
          title: "기부금 공제 1",
          description: "한 라운드에서 기부 금액만큼 세금감면",
          price: 100000),
      GameContentItem(
          title: "기부금 공제 2",
          description: "한 라운드에서 기부 금액만큼 세금감면",
          price: 300000),
      GameContentItem(
          title: "기부금 공제 3", description: "한 라운드에서 3% 세금감면", price: 100000),
      GameContentItem(
          title: "기부금 공제 4", description: "한 라운드에서 7% 세금감면", price: 300000),
    ]),
  ],
);

final loanModel = GameAction(
  title: "대출",
  description: """
신용대출: 자신의 신용을 바탕으로 빌려주는 돈(보유 현금대비)
담보대출: 보유한 자산을 기준으로 빌려주는 돈(보유자산대비)
""",
  rateTitle: "대출금리",
  rateDescription: "빌린돈에 대한 이자",
  rates: [
    Rate(title: "신용대출", rateFluctuation: [8, 10]),
    Rate(title: "담보대출", rateFluctuation: [7, 5])
  ],
  actions: [
    SpecifitGameAction(title: '대출', items: [
      GameContentItem(
          title: "신용대출21", description: "신용대출 상품 1에 대한 설명", price: 100000),
      GameContentItem(
          title: "신용대출2", description: "신용대출 상품 1에 대한 설명", price: 300000),
      GameContentItem(
          title: "신용대출3", description: "신용대출 상품 1에 대한 설명", price: 500000),
      GameContentItem(
          title: "신용대출4", description: "신용대출 상품 1에 대한 설명", price: 1000000),
    ]),
    SpecifitGameAction(title: '상환', items: [
      GameContentItem(
          title: "담보대출1", description: "담보대출 상품 1에 대한 설명", price: 100000),
      GameContentItem(
          title: "담보대출2", description: "담보대출 상품 2에 대한 설명", price: 300000),
      GameContentItem(
          title: "담보대출3", description: "담보대출 상품 3에 대한 설명", price: 500000),
      GameContentItem(
          title: "담보대출4", description: "담보대출 상품 4에 대한 설명", price: 1000000),
    ]),
  ],
);
