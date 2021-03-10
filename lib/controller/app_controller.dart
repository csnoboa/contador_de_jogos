// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contador_de_jogos/storage/config_storage.dart';

class AppController extends ChangeNotifier {
  static AppController instance = AppController();

  int time = 60;

  bool isSoundOn = true;
  bool isAlarmOn = true;
  bool isPortuguese = true;
  bool isDarkTheme = false;
  bool isTimerVisible = true;

  String lang = 'port';

  importFileConfig() {
    ConfigStorage().readConfig().then((Config value) {
      print(value);
      changeTime(value.time);
      isDarkTheme = value.isDarkTheme;
      isSoundOn = value.isSoundOn;
      isTimerVisible = value.isTimerVisible;
      isAlarmOn = value.isAlarmOn;
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
        isAlarmOn: this.isAlarmOn,
        isTimerVisible: this.isTimerVisible,
        lang: this.lang,
      ),
    );
  }

  changeSound() {
    isSoundOn = !isSoundOn;
    notifyListeners();
  }

  changeAlarm() {
    isAlarmOn = !isAlarmOn;
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

  List<EquipeCard> listEquipeCard = [
    EquipeCard(name: "AZUL", color: Colors.blue, selected: true, count: 0),
    EquipeCard(name: "AMARELO", color: Colors.yellow, selected: false, count: 0)
  ];

  changeSelectedEquipe(int index, bool newSelected) {
    listEquipeCard[index].changeSelected(newSelected);
    notifyListeners();
  }

  void addEquipeCard(EquipeCard equipeCard) {
    listEquipeCard.add(equipeCard);
  }

  void removeEquipeCard(int index) {
    listEquipeCard.removeAt(index);
  }

  int sizeListEquipeCard() {
    return listEquipeCard.length;
  }

  increaseCountEquipe(int index) {
    listEquipeCard[index].increaseCount();
  }

  decreaseCountEquipe(int index) {
    listEquipeCard[index].decreaseCount();
  }

  List<PersonCard> listPersonCard = [
    PersonCard(
      name: "Person1",
      equipe: "AZUL",
      color: Colors.blue,
      selected: true,
      count: 0,
    ),
    PersonCard(
      name: "Person2",
      equipe: "AMARELO",
      color: Colors.yellow,
      selected: false,
      count: 0,
    ),
  ];

  changeSelectedPerson(int index, bool newSelected) {
    listPersonCard[index].changeSelected(newSelected);
    notifyListeners();
  }

  void addPersonCard(PersonCard personCard) {
    listPersonCard.add(personCard);
  }

  void removePersonCard(int index) {
    listPersonCard.removeAt(index);
  }

  int sizeListPersonCard() {
    return listPersonCard.length;
  }

  increasePersonCount(int index) {
    listPersonCard[index].increaseCount();
  }

  decreasePersonCount(int index) {
    listPersonCard[index].decreaseCount();
  }
}

class PersonCard {
  PersonCard({this.name, this.equipe, this.color, this.selected, this.count});
  String name;
  String equipe;
  Color color;
  bool selected;
  int count;
  increaseCount() {
    count++;
  }

  decreaseCount() {
    count--;
  }

  changeSelected(bool newSelected) {
    selected = newSelected;
  }
}

class EquipeCard {
  EquipeCard({this.name, this.color, this.selected, this.count});
  var name;
  Color color;
  bool selected;
  int count;

  increaseCount() {
    count++;
  }

  decreaseCount() {
    count--;
  }

  changeSelected(bool newSelected) {
    selected = newSelected;
  }
}
