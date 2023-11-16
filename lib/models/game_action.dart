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
  final List<GameActionItem> items; // 저축, 대출은 필요 X

  SpecifitGameAction({required this.title, required this.items});
}

class GameActionItem {
  final String title;
  final int price;
  final String? description;

  GameActionItem(
      {required this.title, required this.description, required this.price});
}

final savingModel = GameAction(
  title: "저축",
  description: """
예금: 은행에 자유롭게 1번 맡기는 돈
적금: 은행에 라운드마다 정기적으로 맡기는 돈
""",
  actions: [
    SpecifitGameAction(title: '예금', items: [
      GameActionItem(
          title: "예금1", description: "예금 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "예금2", description: "예금 상품 1에 대한 설명", price: 300000),
      GameActionItem(
          title: "예금3", description: "예금 상품 1에 대한 설명", price: 500000),
      GameActionItem(
          title: "예금4", description: "예금 상품 1에 대한 설명", price: 1000000),
    ]),
    SpecifitGameAction(title: '적금', items: [
      GameActionItem(
          title: "적금1", description: "적금 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "적금2", description: "적금 상품 2에 대한 설명", price: 300000),
      GameActionItem(
          title: "적금3", description: "적금 상품 3에 대한 설명", price: 500000),
      GameActionItem(
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
  actions: [
    SpecifitGameAction(title: '주식', items: [
      GameActionItem(
          title: "전기전자", description: "주식 상품 1에 대한 설명", price: 1000000),
      GameActionItem(title: "금융", description: "주식 상품 1에 대한 설명", price: 100000),
      GameActionItem(title: "철강", description: "주식 상품 1에 대한 설명", price: 300000),
      GameActionItem(title: "제약", description: "주식 상품 1에 대한 설명", price: 70000),
    ]),
    SpecifitGameAction(title: '실물자산', items: [
      GameActionItem(
          title: "금", description: "실물자산 상품 1에 대한 설명", price: 200000),
      GameActionItem(
          title: "미술품", description: "실물자산 상품 2에 대한 설명", price: 500000),
      GameActionItem(
          title: "다이아몬드", description: "실물자산 상품 3에 대한 설명", price: 700000),
      GameActionItem(
          title: "기념주화", description: "실물자산 상품 4에 대한 설명", price: 50000),
    ]),
    SpecifitGameAction(title: '부동산', items: [
      GameActionItem(
          title: "서울", description: "부동산 상품 1에 대한 설명", price: 3000000),
      GameActionItem(
          title: "대전", description: "부동산 상품 2에 대한 설명", price: 4300000),
      GameActionItem(
          title: "광주", description: "부동산 상품 3에 대한 설명", price: 1200000),
      GameActionItem(
          title: "부산", description: "부동산 상품 4에 대한 설명", price: 650000),
    ]),
    SpecifitGameAction(title: '펀드', items: [
      GameActionItem(
          title: "카이마루\n부자시리즈", description: "펀드 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "안전에셋\n더드림", description: "펀드 상품 2에 대한 설명", price: 300000),
      GameActionItem(
          title: "탁월해\n투자신탁", description: "펀드 상품 3에 대한 설명", price: 500000),
      GameActionItem(
          title: "글로벌\n베스트", description: "펀드 상품 4에 대한 설명", price: 1000000),
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
      GameActionItem(
          title: "저축관리\n어드바이저", description: "소비 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "투자관리\n어드바이저", description: "소비 상품 1에 대한 설명", price: 300000),
      GameActionItem(
          title: "주사위\n특권", description: "소비 상품 1에 대한 설명", price: 500000),
      GameActionItem(
          title: "주사위\n1회권", description: "소비 상품 1에 대한 설명", price: 1000000),
    ]),
    SpecifitGameAction(title: '적금', items: [
      GameActionItem(
          title: "민영보험1", description: "보험 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "민영보험2", description: "보험 상품 2에 대한 설명", price: 300000),
      GameActionItem(
          title: "사회보장보험1", description: "보험 상품 3에 대한 설명", price: 70000),
      GameActionItem(
          title: "사회보장보험2", description: "보험 상품 4에 대한 설명", price: 300000),
    ]),
    SpecifitGameAction(title: '기부', items: [
      GameActionItem(
          title: "기부공재1", description: "기부 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "기부공재2", description: "기부 상품 2에 대한 설명", price: 300000),
      GameActionItem(
          title: "기부공재3", description: "기부 상품 3에 대한 설명", price: 100000),
      GameActionItem(
          title: "기부공재4", description: "기부 상품 4에 대한 설명", price: 300000),
    ]),
  ],
);

final loanModel = GameAction(
  title: "대출",
  description: "대출에 대한 설명 ~~~",
  actions: [
    SpecifitGameAction(title: '신용대출', items: [
      GameActionItem(
          title: "신용대출21", description: "신용대출 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "신용대출2", description: "신용대출 상품 1에 대한 설명", price: 300000),
      GameActionItem(
          title: "신용대출3", description: "신용대출 상품 1에 대한 설명", price: 500000),
      GameActionItem(
          title: "신용대출4", description: "신용대출 상품 1에 대한 설명", price: 1000000),
    ]),
    SpecifitGameAction(title: '담보대출', items: [
      GameActionItem(
          title: "담보대출1", description: "담보대출 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "담보대출2", description: "담보대출 상품 2에 대한 설명", price: 300000),
      GameActionItem(
          title: "담보대출3", description: "담보대출 상품 3에 대한 설명", price: 500000),
      GameActionItem(
          title: "담보대출4", description: "담보대출 상품 4에 대한 설명", price: 1000000),
    ]),
  ],
);
