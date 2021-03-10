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

  @override
  Widget build(BuildContext context) {
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
                    AppController.instance.removeEquipeCard(i);
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
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  teamButtonMenu[AppController.instance.lang],
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
