import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/language/language.dart';
import 'package:flutter/material.dart';

class PersonCardWidget extends StatelessWidget {
  PersonCardWidget(
      {this.colorEquipe,
      this.nameEquipe,
      this.namePerson,
      this.arrowSelected,
      this.index,
      this.count,
      this.notifyParent});

  final Function() notifyParent;
  final Color colorEquipe;
  final String nameEquipe;
  final String namePerson;
  final bool arrowSelected;
  final index;
  final int count;

  void increaseCount() {
    AppController.instance.increasePersonCount(index);
    notifyParent();
  }

  void decreaseCount() {
    AppController.instance.decreasePersonCount(index);
    notifyParent();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: arrowSelected,
                child: Icon(Icons.arrow_right_alt),
              ),
              Container(width: 50, height: 50, color: colorEquipe),
              Container(width: 10),
              Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                ),
                child: Text(
                  playerName[AppController.instance.lang] + namePerson,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.black,
                ),
                onPressed: () {
                  decreaseCount();
                },
              ),
              Container(width: 5),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(width: 5),
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.black,
                ),
                onPressed: () {
                  increaseCount();
                },
              ),
            ],
          ),
          Container(height: 25),
        ],
      ),
    );
  }
}
