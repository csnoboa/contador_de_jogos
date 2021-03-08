// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contador_de_jogos/storage/config_storage.dart';

class AppController extends ChangeNotifier {
  static AppController instance = AppController();

  int time = 60;

  bool isSoundOn = true;
  bool isPortuguese = true;
  bool isDarkTheme = false;
  bool isTimerVisible = true;

  String lang = 'port';

  List<EquipeCard> listEquipeCard = [
    EquipeCard(name: "AZUL", color: Colors.blue),
    EquipeCard(name: "AMARELO", color: Colors.yellow)
  ];

  importFileConfig() {
    ConfigStorage().readConfig().then((Config value) {
      print(value);
      changeTime(value.time);
      isDarkTheme = value.isDarkTheme;
      isSoundOn = value.isSoundOn;
      isTimerVisible = value.isTimerVisible;
      changeLanguage(value.lang);
    });
    notifyListeners();
  }

  saveFileConfig() {
    ConfigStorage().writeConfig(
      Config(
        time: this.time,
        isDarkTheme: this.isDarkTheme,
        isPortuguese: this.isPortuguese,
        isSoundOn: this.isSoundOn,
        isTimerVisible: this.isTimerVisible,
        lang: this.lang,
      ),
    );
  }

  changeSound() {
    isSoundOn = !isSoundOn;
    notifyListeners();
  }

  changeTimerVisible() {
    isTimerVisible = !isTimerVisible;
    notifyListeners();
  }

  changeLanguage(String _lang) {
    lang = _lang;
    if (lang == 'port') {
      isPortuguese = true;
    } else {
      isPortuguese = false;
    }
    notifyListeners();
  }

  changeTime(int newTime) {
    time = newTime;
    notifyListeners();
  }

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
  var name;
  Color color;
}
