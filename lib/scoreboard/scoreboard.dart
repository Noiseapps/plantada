class ScoreboardConfig {
  const ScoreboardConfig({this.config});

  final Map<Resource, ThresholdData> config;

  void addThresholdForResource(Resource resource, ThresholdData thresholdData) {
    config[resource] = thresholdData;
  }
}

enum Resource {
  cigarettes,
  booze,
  weed,
  guns,
  coke,
}

extension ResourceDisplayName on Resource {
  String name() {
    return this.toString().split('.').last;
  }
}

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
    }
  }
}

class Scoreboard {
  List<ScoreboardColumn> columns;

  static Scoreboard load(ScoreboardConfig configWrapper) {
    final config = configWrapper.config;
    Scoreboard scoreboard = Scoreboard();
    scoreboard.columns = List();
    Resource.values.forEach((resource) {
      var column = ScoreboardColumn(resource, config[resource]);
      column.resetExportValue();
      scoreboard.columns.add(column);
    });

    return scoreboard;
  }

  Map<Player, int> finalizeRound() {
    Map<Player, int> summary = getMoneySummary();
    columns.forEach((col) => col.resetExportValue());
    return summary;
  }

  int scoreForPlayer(Player player, Resource resource) {
    var column = _getColumn(resource);
    return column.countForPlayer(player);
  }

  Map<Player, int> getMoneySummary() {
    var playerMoney = Map<Player, int>();
    Player.values.forEach((player) {
      columns.forEach((column) {
        var currentMoney = playerMoney[player] ?? 0;
        var columnMoney = column.getColumnMoneyForPlayer(player);
        playerMoney[player] = currentMoney + columnMoney;
      });
    });
    return playerMoney;
  }

  void addResourceToPlayer(Player player, Resource resource) {
    var column = _getColumn(resource);
    column.addResourceToPlayer(player);
  }

  int getPlayerResourceCount(Player player, Resource resource) {
    var column = _getColumn(resource);
    return column.countForPlayer(player);
  }

  void resetPlayerResource(Player player, Resource resource) {
    var column = _getColumn(resource);
    column.resetExportForPlayer(player);
  }

  ScoreboardColumn _getColumn(Resource resource) {
    return columns.firstWhere((element) => element.matchesResource(resource));
  }
}

class PlayerSlot {
  PlayerSlot(int count) {
    this.count = count;
  }

  int count;
}

class ScoreboardColumn {
  ScoreboardColumn(this._resource, this._thresholdData);

  final Resource _resource;
  final ThresholdData _thresholdData;
  Map<Player, PlayerSlot> _playerExport;

  void addResourceToPlayer(Player player) {
    var slot = _playerExport[player];
    var slotCount = slot?.count ?? 0;
    _playerExport[player] = PlayerSlot(slotCount + 1);
  }

  bool matchesResource(Resource resource) => this._resource == resource;

  int getColumnMoneyForPlayer(Player player) {
    var exportValue = _playerExport.entries.map<int>((e) => e.value.count).fold(0, (previousValue, element) => previousValue + element);
    var sellValueForItem = _thresholdData.exportValueForExportAmount(exportValue);
    var playerExportValue = _playerExport[player]?.count ?? 0;
    return playerExportValue * sellValueForItem;
  }

  int countForPlayer(Player player) {
    return _playerExport[player]?.count ?? 0;
  }

  void resetExportValue() {
    _playerExport = Map();
  }

  void resetExportForPlayer(Player player) {
    _playerExport[player] = PlayerSlot(0);
  }
}

class ThresholdData {
  final List<ThresholdStep> steps;

  const ThresholdData({this.steps});

  int exportValueForExportAmount(int amount) {
    for (int i = 0; i < steps.length; i++) {
      var start = 0;
      var end = steps[i].max;
      if (i > 0) {
        start = steps[i - 1].max + 1;
      }
      if (start <= amount && amount <= end) {
        return steps[i].exportValue;
      }
    }
    return 0;
  }

  static ThresholdData create() {
    return ThresholdData();
  }

  ThresholdData addStep(ThresholdStep step) {
    steps.add(step);
    return this;
  }
}

class ThresholdStep {
  final int max;
  final int exportValue;

  const ThresholdStep(this.max, this.exportValue);
}
