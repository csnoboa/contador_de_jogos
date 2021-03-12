import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:flutter/material.dart';

import 'language/language.dart';

class FinishPage extends StatefulWidget {
  FinishPage({Key key}) : super(key: key);

  @override
  _FinishPageState createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> listEquipesWidget = List.empty(growable: true);

    for (int i = 0; i < AppController.instance.sizeListEquipeCard(); i++) {
      listEquipesWidget.add(
        Column(
          children: [
            Row(
              children: [
                Container(
                  color: AppController.instance.listEquipeCard[i].color,
                  width: 50,
                  height: 50,
                ),
                Container(width: 15),
                Container(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.3),
                  child: Text(
                    AppController.instance.listEquipeCard[i].name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(width: 5),
                Text(
                  "${AppController.instance.listEquipeCard[i].count}" +
                      points[AppController.instance.lang],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(height: 10),
          ],
        ),
      );
    }

    List<Widget> listPersonWidget = List.empty(growable: true);

    for (int i = 0; i < AppController.instance.sizeListPersonCard(); i++) {
      listPersonWidget.add(
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
                Container(width: 5),
                Text(
                  "${AppController.instance.listPersonCard[i].count}" +
                      points[AppController.instance.lang],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(height: 10),
          ],
        ),
      );
    }
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

    List<Widget> listWinnersEquipe = List.empty(growable: true);

    List<int> listWinnersEquipeInt = List.empty(growable: true);
    bigger = AppController.instance.listEquipeCard[0].count;
    for (int i = 0; i < AppController.instance.sizeListEquipeCard(); i++) {
      if (AppController.instance.listEquipeCard[i].count > bigger) {
        bigger = AppController.instance.listEquipeCard[i].count;
      }
    }
    for (int i = 0; i < AppController.instance.sizeListEquipeCard(); i++) {
      if (AppController.instance.listEquipeCard[i].count >= bigger) {
        listWinnersEquipeInt.add(i);
      }
    }

    for (int i = 0; i < AppController.instance.sizeListEquipeCard(); i++) {
      if (listWinnersEquipeInt.contains(i))
        listWinnersEquipe.add(
          Column(
            children: [
              Row(
                children: [
                  Container(
                    color: AppController.instance.listEquipeCard[i].color,
                    width: 50,
                    height: 50,
                  ),
                  Container(width: 15),
                  Container(
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.3),
                    child: Text(
                      AppController.instance.listEquipeCard[i].name,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(finishPage[AppController.instance.lang]),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10.0, right: 10, top: 30, bottom: 30),
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.78,
            ),
            color: AppController.instance.isDarkTheme
                ? Colors.grey[700]
                : Colors.amber[100],
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.9),
                          child: Column(
                            children: listEquipesWidget,
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.9),
                          child: Column(
                            children: listPersonWidget,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 40),
                    child: Column(
                      children: [
                        Text(
                          teamWinners[AppController.instance.lang],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: listWinnersEquipe,
                        ),
                        Container(height: 20),
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
                        Container(height: 60),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                          ),
                          onPressed: () {
                            for (int i = 0;
                                i < AppController.instance.sizeListEquipeCard();
                                i++) {
                              AppController.instance.listEquipeCard[i].count =
                                  0;
                            }
                            for (int i = 0;
                                i < AppController.instance.sizeListPersonCard();
                                i++) {
                              AppController.instance.listPersonCard[i].count =
                                  0;
                            }
                            Navigator.of(context)
                                .pushReplacementNamed('/start');
                          },
                          child: Text(
                            newGame[AppController.instance.lang],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
