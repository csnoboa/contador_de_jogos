import 'dart:math';
import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:contador_de_jogos/language/language.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _counter = AppController.instance.time;

  String _stopwatchText;

  List<String> listNamesString = [
    "ROXO",
    "ROSA",
    "LARANJA",
    "CINZA",
    "MARROM",
    "PRETO",
    "AZUL",
    "VERDE",
    "AMARELO",
    "VERMELHO",
  ];

  List<Color> listColors = [
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.grey,
    Colors.brown,
    Colors.black,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red
  ];

  var listColorsEquipes = {
    "ROXO": Colors.purple,
    "ROSA": Colors.pink,
    "LARANJA": Colors.orange,
    "CINZA": Colors.grey,
    "MARROM": Colors.brown,
    "PRETO": Colors.black,
    "AZUL": Colors.blue,
    "VERDE": Colors.green,
    "AMARELO": Colors.yellow,
    "VERMELHO": Colors.red,
    "BRANCO": Colors.white,
  };

  @override
  Widget build(BuildContext context) {
    List<String> listColorsEquipesString = List.empty(growable: true);

    for (int i = 0; i < AppController.instance.sizeListEquipeCard(); i++) {
      listColorsEquipesString
          .add(AppController.instance.listEquipeCard[i].name);
    }
    listColorsEquipesString.add("BRANCO");

    // Add the cards to display the Equipe Cards
    List<Widget> listAddedWidgets = List.empty(growable: true);

    for (int i = 0; i < AppController.instance.sizeListEquipeCard(); i++) {
      listNamesString.remove(AppController.instance.listEquipeCard[i].name);
      listColors.remove(AppController.instance.listEquipeCard[i].color);

      listAddedWidgets.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                color: AppController.instance.listEquipeCard[i].color,
              ),
              Container(width: 20),
              Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.35,
                ),
                child: Text(
                  AppController.instance.isPortuguese
                      ? AppController.instance.listEquipeCard[i].name
                      : listNames[
                          AppController.instance.listEquipeCard[i].name],
                  style: TextStyle(fontSize: 20),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    listNamesString
                        .add(AppController.instance.listEquipeCard[i].name);

                    listColors
                        .add(AppController.instance.listEquipeCard[i].color);

                    for (int j = 0;
                        j < AppController.instance.sizeListPersonCard();
                        j++) {
                      if (AppController.instance.listPersonCard[j].equipe ==
                          AppController.instance.listEquipeCard[i].name) {
                        AppController.instance.listPersonCard[j].equipe =
                            "BRANCO";
                        AppController.instance.listPersonCard[j].color =
                            Colors.white;
                      }
                    }

                    listColorsEquipesString
                        .remove(AppController.instance.listEquipeCard[i].name);

                    AppController.instance.removeEquipeCard(i);
                  });
                },
                icon: Icon(Icons.remove_circle_outline),
              ),
            ],
          ),
        ),
      );
    }

    // List to display the players
    List<Widget> listAddedPerson = List.empty(growable: true);

    String dropdownValue = "BRANCO";

    for (int i = 0; i < AppController.instance.sizeListPersonCard(); i++) {
      dropdownValue = AppController.instance.listPersonCard[i].equipe;
      listAddedPerson.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  elevation: 16,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      AppController.instance.listPersonCard[i].equipe =
                          newValue;
                      AppController.instance.listPersonCard[i].color =
                          listColorsEquipes[newValue];
                    });
                  },
                  items: listColorsEquipesString
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        width: 40,
                        height: 40,
                        color: listColorsEquipes[value],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(width: 20),
              Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.35,
                ),
                child: Text(
                  AppController.instance.listPersonCard[i].name,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    AppController.instance.removePersonCard(i);
                  });
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                ),
              ),
            ],
          ),
        ),
      );
    }

    _stopwatchText = (_counter ~/ 60).toString() +
        ' m ' +
        (_counter % 60).toString().padLeft(2, '0') +
        ' s';
    return WillPopScope(
      onWillPop: () async {
        AppController.instance.changeTime(_counter);
        AppController.instance.saveFileConfig();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('MENU'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      switchTimerVisible[AppController.instance.lang],
                      style: TextStyle(fontSize: 20),
                    ),
                    Switch(
                      value: AppController.instance.isTimerVisible,
                      onChanged: (value) {
                        setState(
                          () {
                            AppController.instance.changeTimerVisible();
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              Visibility(
                visible: AppController.instance.isTimerVisible,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(timerButtonMenu[AppController.instance.lang],
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Container(
                              width: 60,
                              height: 60,
                              child: ElevatedButton(
                                child: Text('-10'),
                                onPressed: () {
                                  setState(() {
                                    if (_counter < 10) {
                                      _counter = 0;
                                    } else {
                                      _counter -= 10;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(width: 5),
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                if (_counter > 0) {
                                  _counter--;
                                }
                              });
                            },
                          ),
                          Container(width: 5),
                          Text(
                            '$_stopwatchText',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(width: 5),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                _counter++;
                              });
                            },
                          ),
                          Container(width: 5),
                          ClipOval(
                            child: Container(
                              width: 60,
                              height: 60,
                              child: ElevatedButton(
                                child: Text('+10'),
                                onPressed: () {
                                  setState(() {
                                    _counter += 10;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width * 1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: Text(
                              teamButtonMenu[AppController.instance.lang],
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                            children: listAddedWidgets,
                          ),
                          Visibility(
                            child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  EquipeCard equipe = EquipeCard(
                                    name: listNamesString.removeLast(),
                                    color: listColors.removeLast(),
                                    selected: false,
                                    count: 0,
                                  );
                                  AppController.instance.addEquipeCard(equipe);
                                });
                              },
                            ),
                            visible: (listColors.isEmpty ? false : true),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width * 1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: Text(
                              peopleButtonMenu[AppController.instance.lang],
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                            children: listAddedPerson,
                          ),
                          Visibility(
                            child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  PersonCard equipe = PersonCard(
                                    name: "Player" +
                                        "${AppController.instance.sizeListPersonCard() + 1}",
                                    color: AppController
                                            .instance.listEquipeCard[0].color ??
                                        Colors.white,
                                    selected: false,
                                    count: 0,
                                    equipe: AppController
                                            .instance.listEquipeCard[0].name ??
                                        "BRANCO",
                                  );
                                  AppController.instance.addPersonCard(equipe);
                                });
                              },
                            ),
                            visible:
                                (AppController.instance.sizeListEquipeCard() >
                                    0),
                          ),
                          ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.grey),
                            onPressed: () {
                              setState(() {
                                List<String> listSortable =
                                    List.empty(growable: true);
                                listSortable =
                                    List.from(listColorsEquipesString);
                                listSortable.remove("BRANCO");
                                listSortable.shuffle();
                                for (int i = 0;
                                    i <
                                        AppController.instance
                                            .sizeListPersonCard();
                                    i++) {
                                  if (listSortable.isEmpty) {
                                    listSortable =
                                        List.from(listColorsEquipesString);
                                    listSortable.remove("BRANCO");
                                    listSortable.shuffle();
                                  }
                                  AppController.instance.listPersonCard[i]
                                      .equipe = listSortable.removeLast();
                                  AppController
                                          .instance.listPersonCard[i].color =
                                      listColorsEquipes[AppController
                                          .instance.listPersonCard[i].equipe];
                                }
                                // for (int i = 0;
                                //     i <
                                //         AppController.instance
                                //             .sizeListPersonCard();
                                //     i++) {
                                //   List listSortable = listColorsEquipesString;
                                //   listSortable.remove("BRANCO");
                                //   listSortable.shuffle();
                                //   while (listSortable.isNotEmpty &&
                                //       i <
                                //           AppController.instance
                                //               .sizeListPersonCard()) {
                                //     AppController.instance.listPersonCard[i]
                                //         .equipe = listSortable.removeLast();
                                //     AppController
                                //             .instance.listPersonCard[i].color =
                                //         listColorsEquipes[AppController
                                //             .instance.listPersonCard[i].equipe];
                                //     i++;
                                //   }
                                // }
                              });
                            },
                            child: Text(
                              rearrangeButtonMenu[AppController.instance.lang],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(height: 60),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
