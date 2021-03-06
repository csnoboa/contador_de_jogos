// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppController extends ChangeNotifier {
  static AppController instance = AppController();

  int time = 60;

  bool isSoundOn = true;
  changeSound() {
    isSoundOn = !isSoundOn;
    notifyListeners();
  }

  String lang = "port";
  changeLanguage(String _lang) {
    lang = _lang;
    notifyListeners();
  }

  List<EquipeCard> listEquipeCard = [
    EquipeCard(name: "AZUL", color: Colors.blue),
    EquipeCard(name: "AMARELO", color: Colors.yellow)
  ];

  changeTime(int newTime) {
    time = newTime;
    notifyListeners();
  }

  bool isDarkTheme = false;
  changeTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  void addEquipeCard(EquipeCard equipeCard) {
    listEquipeCard.add(equipeCard);
  }

  void removeEquipeCard(int index) {
    listEquipeCard.removeAt(index);
  }

  int sizeListCard() {
    return listEquipeCard.length;
  }
}

class EquipeCard {
  EquipeCard({this.name, this.color});
  String name;
  Color color;
}
