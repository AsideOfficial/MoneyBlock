class GameAction {
  final String title;
  final String description;
  final List<SpecifitGameAction> actions;

  GameAction({
    required this.title,
    required this.description,
    required this.actions,
  });
}

class SpecifitGameAction {
  final String title;
  final List<GameActionItem> items;

  SpecifitGameAction({required this.title, required this.items});
}

class GameActionItem {
  final String title;
  final String description;
  final int price;

  GameActionItem(
      {required this.title, required this.description, required this.price});
}

final savingModel = GameAction(
  title: "저축",
  description: "저축에 대한 설명 ~~~",
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
  description: "투자에 대한 설명 ~~~",
  actions: [
    SpecifitGameAction(title: '주식', items: [
      GameActionItem(
          title: "주식1", description: "주식 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "주식2", description: "주식 상품 1에 대한 설명", price: 300000),
      GameActionItem(
          title: "주식3", description: "주식 상품 1에 대한 설명", price: 500000),
      GameActionItem(
          title: "주식4", description: "주식 상품 1에 대한 설명", price: 1000000),
    ]),
    SpecifitGameAction(title: '실물자산', items: [
      GameActionItem(
          title: "실물자산1", description: "실물자산 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "실물자산2", description: "실물자산 상품 2에 대한 설명", price: 300000),
      GameActionItem(
          title: "실물자산3", description: "실물자산 상품 3에 대한 설명", price: 500000),
      GameActionItem(
          title: "실물자산4", description: "실물자산 상품 4에 대한 설명", price: 1000000),
    ]),
    SpecifitGameAction(title: '부동산', items: [
      GameActionItem(
          title: "부동산1", description: "부동산 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "부동산2", description: "부동산 상품 2에 대한 설명", price: 300000),
      GameActionItem(
          title: "부동산3", description: "부동산 상품 3에 대한 설명", price: 500000),
      GameActionItem(
          title: "부동산4", description: "부동산 상품 4에 대한 설명", price: 1000000),
    ]),
    SpecifitGameAction(title: '펀드', items: [
      GameActionItem(
          title: "펀드1", description: "펀드 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "펀드2", description: "펀드 상품 2에 대한 설명", price: 300000),
      GameActionItem(
          title: "펀드3", description: "펀드 상품 3에 대한 설명", price: 500000),
      GameActionItem(
          title: "펀드4", description: "펀드 상품 4에 대한 설명", price: 1000000),
    ]),
  ],
);

final expendModel = GameAction(
  title: "지출",
  description: "저축에 대한 설명 ~~~",
  actions: [
    SpecifitGameAction(title: '소비', items: [
      GameActionItem(
          title: "소비1", description: "소비 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "소비2", description: "소비 상품 1에 대한 설명", price: 300000),
      GameActionItem(
          title: "소비3", description: "소비 상품 1에 대한 설명", price: 500000),
      GameActionItem(
          title: "소비4", description: "소비 상품 1에 대한 설명", price: 1000000),
    ]),
    SpecifitGameAction(title: '적금', items: [
      GameActionItem(
          title: "보험1", description: "보험 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "보험2", description: "보험 상품 2에 대한 설명", price: 300000),
      GameActionItem(
          title: "보험3", description: "보험 상품 3에 대한 설명", price: 500000),
      GameActionItem(
          title: "보험4", description: "보험 상품 4에 대한 설명", price: 1000000),
    ]),
    SpecifitGameAction(title: '적금', items: [
      GameActionItem(
          title: "기부1", description: "기부 상품 1에 대한 설명", price: 100000),
      GameActionItem(
          title: "기부2", description: "기부 상품 2에 대한 설명", price: 300000),
      GameActionItem(
          title: "기부3", description: "기부 상품 3에 대한 설명", price: 500000),
      GameActionItem(
          title: "기부4", description: "기부 상품 4에 대한 설명", price: 1000000),
    ]),
  ],
);
