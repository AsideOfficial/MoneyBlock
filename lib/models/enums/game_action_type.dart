import 'package:flutter/widgets.dart';
import 'package:money_cycle/models/game_action.dart';

import '../../constants.dart';

enum GameActionType { saving, investment, expend, loan }

extension GameActionExtension on GameActionType {
  LinearGradient get linearBackground {
    switch (this) {
      case GameActionType.saving:
        return Constants.greenGradient;
      case GameActionType.investment:
        return Constants.redGradient;
      case GameActionType.expend:
        return Constants.blueGradient;
      case GameActionType.loan:
        return Constants.orangeGradient;
    }
  }

  GameAction get actionData {
    switch (this) {
      case GameActionType.saving:
        return savingModel;
      case GameActionType.investment:
        return investmentModel;
      case GameActionType.expend:
        return expendModel;
      case GameActionType.loan:
        return loanModel;
    }
  }
}
