import 'package:flutter/material.dart';

class CardStartGame extends StatefulWidget {
  CardStartGame({Key key, this.colorEquipe, this.nameEquipe}) : super(key: key);

  final Color colorEquipe;
  final String nameEquipe;

  @override
  _CardStartGameState createState() => _CardStartGameState(
      colorEquipe: this.colorEquipe, nameEquipe: this.nameEquipe);
}

class _CardStartGameState extends State<CardStartGame> {
  _CardStartGameState({
    this.colorEquipe,
    this.nameEquipe,
  });

  Color colorEquipe;
  String nameEquipe;

  int _count = 0;

  void increaseCount() {
    _count++;
  }

  void decreaseCount() {
    _count--;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 50, height: 50, color: colorEquipe),
          Container(width: 10),
          Text(
            nameEquipe,
            style: TextStyle(fontSize: 24),
          ),
          Container(width: 30),
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: () {
              setState(() {
                decreaseCount();
              });
            },
          ),
          Container(width: 10),
          Text(
            '$_count',
            style: TextStyle(fontSize: 24),
          ),
          Container(width: 10),
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              setState(() {
                increaseCount();
              });
            },
          ),
        ],
      ),
    );
  }
}
