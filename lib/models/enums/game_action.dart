import 'package:flutter/widgets.dart';

import '../../constants.dart';

enum GameAction { saving, investment, expend }

extension GameActionExtension on GameAction {
  LinearGradient get linearBackground {
    switch (this) {
      case GameAction.saving:
        return Constants.greenGradient;
      case GameAction.investment:
        return Constants.redGradient;
      case GameAction.expend:
        return Constants.blueGradient;
    }
  }
}
