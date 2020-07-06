import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantada/data/player.dart';
import 'package:plantada/utils/data_provider.dart';

class PlayerNameMapping {
  final Player player;
  final String name;

  const PlayerNameMapping(this.player, this.name);
}

class PlayerNameInput extends StatelessWidget {
  final Player player;

  PlayerNameInput({Key key, this.player}) : super(key: key);

  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    inputController.text = ProviderFactory.activeProvider().playerName(player);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 12,
        ),
        Text(
          'Imię gracza ${player.displayName()}',
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: inputController,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
        ),
      ],
    );
  }

  PlayerNameMapping playerName() {
    return PlayerNameMapping(player, inputController.text);
  }
}
