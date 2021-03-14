import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/language/language.dart';
import 'package:flutter/material.dart';

class ListWinnersPlayers extends StatefulWidget {
  ListWinnersPlayers({Key key}) : super(key: key);

  @override
  _ListWinnersPlayersState createState() => _ListWinnersPlayersState();
}

class _ListWinnersPlayersState extends State<ListWinnersPlayers> {
  @override
  Widget build(BuildContext context) {
    List<Widget> listWinnersPlayers = List.empty(growable: true);

    List<int> listWinnersPlayersInt = List.empty(growable: true);
    int bigger = AppController.instance.listPersonCard[0].count;
    for (int i = 0; i < AppController.instance.sizeListPersonCard(); i++) {
      if (AppController.instance.listPersonCard[i].count > bigger) {
        bigger = AppController.instance.listPersonCard[i].count;
      }
    }
    for (int i = 0; i < AppController.instance.sizeListPersonCard(); i++) {
      if (AppController.instance.listPersonCard[i].count >= bigger) {
        listWinnersPlayersInt.add(i);
      }
    }

    for (int i = 0; i < AppController.instance.sizeListPersonCard(); i++) {
      if (listWinnersPlayersInt.contains(i))
        listWinnersPlayers.add(
          Column(
            children: [
              Row(
                children: [
                  Container(
                    color: AppController.instance.listPersonCard[i].color,
                    width: 50,
                    height: 50,
                  ),
                  Container(width: 15),
                  Container(
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.3),
                    child: Text(
                      playerName[AppController.instance.lang] +
                          AppController.instance.listPersonCard[i].name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 10),
            ],
          ),
        );
    }

    return Column(
      children: [
        Text(
          playerWinners[AppController.instance.lang],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          children: listWinnersPlayers,
        ),
      ],
    );
  }
}
