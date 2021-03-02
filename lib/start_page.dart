import 'package:flutter/material.dart';
import 'package:contador_de_jogos/card_start_game.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('PARTIDA'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CardStartGame(
              colorEquipe: Colors.blue,
              nameEquipe: 'AZUL',
            ),
            CardStartGame(
              colorEquipe: Colors.red,
              nameEquipe: 'VERM',
            ),
            Text('VERM'),
            Text('Contador'),
          ],
        ),
      ),
    );
  }
}
