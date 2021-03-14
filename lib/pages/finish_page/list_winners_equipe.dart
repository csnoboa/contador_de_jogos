import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/language/language.dart';
import 'package:flutter/material.dart';

class ListWinnersEquipe extends StatefulWidget {
  ListWinnersEquipe({Key key}) : super(key: key);

  @override
  _ListWinnersEquipeState createState() => _ListWinnersEquipeState();
}

class _ListWinnersEquipeState extends State<ListWinnersEquipe> {
  @override
  Widget build(BuildContext context) {
    List<Widget> listWinnersEquipe = List.empty(growable: true);

    List<int> listWinnersEquipeInt = List.empty(growable: true);
    int bigger = AppController.instance.listEquipeCard[0].count;
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
    return Column(
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
      ],
    );
  }
}
