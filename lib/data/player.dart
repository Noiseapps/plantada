enum Player {
  player1,
  player2,
  player3,
  player4,
}

extension PlayerDisplayName on Player {
  String displayName() {
    switch (this) {
      case Player.player1:
        return "G1";
      case Player.player2:
        return "G2";
      case Player.player3:
        return "G3";
      case Player.player4:
        return "G4";
      default:
        return "G0";
    }
  }
}