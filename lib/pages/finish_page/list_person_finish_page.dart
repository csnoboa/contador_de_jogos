import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/language/language.dart';
import 'package:flutter/material.dart';

class ListPersonFinishPage extends StatefulWidget {
  ListPersonFinishPage({Key key}) : super(key: key);

  @override
  _ListPersonFinishPageState createState() => _ListPersonFinishPageState();
}

class _ListPersonFinishPageState extends State<ListPersonFinishPage> {
  @override
  Widget build(BuildContext context) {
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

    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 0.95),
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  AppController.instance.scrollController.jumpTo(0);
                  // widget.notifyParent();
                });
              },
            ),
          ),
        ),
        Column(
          children: listPersonWidget,
        ),
      ],
    );
  }
}
