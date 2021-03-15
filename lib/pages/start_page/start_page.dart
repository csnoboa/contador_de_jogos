import 'dart:math';
import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/language/language.dart';
import 'package:contador_de_jogos/pages/start_page/person_card_game.dart';
import 'package:contador_de_jogos/pages/start_page/timer_start_page.dart';
import 'package:flutter/material.dart';
import 'package:contador_de_jogos/pages/start_page/card_start_game.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int selected = 0;

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<EquipeCardGame> listWidgets = List.empty(growable: true);

    for (int i = 0; i < AppController.instance.sizeListEquipeCard(); i++) {
      listWidgets.add(
        EquipeCardGame(
          colorEquipe: AppController.instance.listEquipeCard[i].color,
          nameEquipe: AppController.instance.listEquipeCard[i].name,
          arrowSelected: AppController.instance.listEquipeCard[i].selected,
          count: AppController.instance.listEquipeCard[i].count,
          index: i,
          notifyParent: refresh,
        ),
      );
    }

    List<PersonCardWidget> listPersonWidget = List.empty(growable: true);

    for (int i = 0; i < AppController.instance.sizeListPersonCard(); i++) {
      listPersonWidget.add(
        PersonCardWidget(
          colorEquipe: AppController.instance.listPersonCard[i].color,
          nameEquipe: AppController.instance.listPersonCard[i].equipe,
          namePerson: AppController.instance.listPersonCard[i].name,
          arrowSelected: AppController.instance.listPersonCard[i].selected,
          count: AppController.instance.listPersonCard[i].count,
          index: i,
          notifyParent: refresh,
        ),
      );
    }

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(matchStart[AppController.instance.lang]),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10, top: 30, bottom: 30),
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.78,
              ),
              color: AppController.instance.isDarkTheme
                  ? Colors.grey[700]
                  : Colors.amber[100],
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),
                            child: Text(
                              sortButtonStart[AppController.instance.lang],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                int selected = Random().nextInt(AppController
                                    .instance
                                    .sizeListEquipeCard());

                                for (int i = 0;
                                    i <
                                        AppController.instance
                                            .sizeListEquipeCard();
                                    i++) {
                                  AppController.instance
                                      .changeSelectedEquipe(i, false);
                                }

                                AppController.instance
                                    .changeSelectedEquipe(selected, true);

                                selected = Random().nextInt(AppController
                                    .instance
                                    .sizeListPersonCard());

                                for (int i = 0;
                                    i <
                                        AppController.instance
                                            .sizeListPersonCard();
                                    i++) {
                                  AppController.instance
                                      .changeSelectedPerson(i, false);
                                }

                                AppController.instance
                                    .changeSelectedPerson(selected, true);
                              });
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),
                            child: Text(
                              resetButtonStart[AppController.instance.lang],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                for (int i = 0;
                                    i <
                                        AppController.instance
                                            .sizeListEquipeCard();
                                    i++) {
                                  AppController
                                      .instance.listEquipeCard[i].count = 0;
                                }
                                for (int i = 0;
                                    i <
                                        AppController.instance
                                            .sizeListPersonCard();
                                    i++) {
                                  AppController
                                      .instance.listPersonCard[i].count = 0;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: AppController.instance.scrollController,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth:
                                          MediaQuery.of(context).size.width *
                                              0.9),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_forward),
                                      onPressed: () {
                                        setState(
                                          () {
                                            AppController
                                                .instance.scrollController
                                                .jumpTo(MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Column(children: listWidgets),
                              ],
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width * 0.9,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth:
                                          MediaQuery.of(context).size.width *
                                              0.9),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_back),
                                      onPressed: () {
                                        setState(
                                          () {
                                            AppController
                                                .instance.scrollController
                                                .jumpTo(0);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Column(children: listPersonWidget),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    TimerStartPage(),
                    Container(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/finish');
                          },
                          child: Text(
                            finishGame[AppController.instance.lang],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
