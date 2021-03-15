import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/language/language.dart';
import 'package:flutter/material.dart';

class ListEquipeMenuPage extends StatefulWidget {
  ListEquipeMenuPage({Key key, @required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _ListEquipeMenuPageState createState() => _ListEquipeMenuPageState();
}

class _ListEquipeMenuPageState extends State<ListEquipeMenuPage> {
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

                    AppController.instance.listColorsEquipesStringRemove(
                        AppController.instance.listEquipeCard[i].name);

                    AppController.instance.removeEquipeCard(i);
                    widget.notifyParent();
                  });
                },
                icon: Icon(Icons.remove_circle_outline),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              teamButtonMenu[AppController.instance.lang],
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            constraints:
                BoxConstraints(minWidth: MediaQuery.of(context).size.width * 1),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    AppController.instance.scrollController
                        .jumpTo(MediaQuery.of(context).size.width);
                    widget.notifyParent();
                  });
                },
              ),
            ),
          ),
          Column(children: listAddedWidgets),
          Visibility(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  String nameAux = listNamesString.removeLast();
                  EquipeCard equipe = EquipeCard(
                    name: nameAux,
                    color: listColors.removeLast(),
                    selected: false,
                    count: 0,
                  );
                  AppController.instance.addEquipeCard(equipe);
                  AppController.instance.listColorsEquipesStringAdd(nameAux);
                  widget.notifyParent();
                });
              },
            ),
            visible: (listColors.isEmpty ? false : true),
          ),
        ],
      ),
    );
  }
}
