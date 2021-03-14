import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/pages/finish_page/list_equipe_finish_page.dart';
import 'package:contador_de_jogos/pages/finish_page/list_person_finish_page.dart';
import 'package:contador_de_jogos/pages/finish_page/list_winners_equipe.dart';
import 'package:contador_de_jogos/pages/finish_page/list_winners_players.dart';
import 'package:flutter/material.dart';

import '../../language/language.dart';

class FinishPage extends StatefulWidget {
  FinishPage({Key key}) : super(key: key);

  @override
  _FinishPageState createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
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
                        ListEquipeFinishPage(),
                        ListPersonFinishPage(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 40),
                    child: Column(
                      children: [
                        ListWinnersEquipe(),
                        Container(height: 20),
                        ListWinnersPlayers(),
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
