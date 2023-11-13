enum GameVariable {
  savingsInterestRate,
  loanInterestRate,
  investmentChangeRate,
}

extension GameVariableExtension on GameVariable {
  String get covertToString {
    switch (this) {
      case GameVariable.savingsInterestRate:
        return '저축금리';
      case GameVariable.loanInterestRate:
        return '대출금리';
      case GameVariable.investmentChangeRate:
        return '투자변동률';
    }
  }

  String get sourceUrl {
    switch (this) {
      case GameVariable.savingsInterestRate:
        return 'assets/components/savings_interest_rate.png';
      case GameVariable.loanInterestRate:
        return 'assets/components/loan_interest_rate.png';
      case GameVariable.investmentChangeRate:
        return 'assets/components/investment_change_rate.png';
    }
  }
}
