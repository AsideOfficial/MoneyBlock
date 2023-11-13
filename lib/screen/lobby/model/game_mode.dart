enum GameMode { entrepreneur, officeWorker }

extension GameModeExtension on GameMode {
  String get convertToString {
    switch (this) {
      case GameMode.entrepreneur:
        return '사업가 모드';
      case GameMode.officeWorker:
        return '직장인 모드';
    }
  }
}

enum TeamMode { solo, team }

extension TeamModeExtension on TeamMode {
  String get convertToString {
    switch (this) {
      case TeamMode.solo:
        return '개인전';
      case TeamMode.team:
        return '팀전(준비중)';
    }
  }
}
