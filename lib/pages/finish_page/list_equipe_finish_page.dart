import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/language/language.dart';
import 'package:flutter/material.dart';

class ListEquipeFinishPage extends StatefulWidget {
  ListEquipeFinishPage({Key key}) : super(key: key);

  @override
  _ListEquipeFinishPageState createState() => _ListEquipeFinishPageState();
}

class _ListEquipeFinishPageState extends State<ListEquipeFinishPage> {
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

    return Container(
      constraints:
          BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.9),
      child: Column(
        children: listEquipesWidget,
      ),
    );
  }
}
