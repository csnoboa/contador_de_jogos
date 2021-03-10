import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/language/language.dart';
import 'package:contador_de_jogos/person_card_game.dart';
import 'package:flutter/material.dart';
import 'package:contador_de_jogos/card_start_game.dart';
import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key}) : super(key: key);

  final int time = AppController.instance.time;

  @override
  _StartPageState createState() => _StartPageState(time: this.time);
}

class _StartPageState extends State<StartPage> {
  _StartPageState({this.time});

  String _stopwatchText;
  int time;
  int _counter;
  Timer _timer;
  bool _running = false;
  bool _pause = false;
  String textTempo = ' ';

  int selected = 0;

  Color timerColor = Colors.black;

  AudioPlayer player = new AudioPlayer();
  AudioCache cache = new AudioCache();
  String audioPath = "sounds/tictoc.mp3";

  void playAudio() async {
    player = await cache.loop(audioPath);
  }

  void stopAudio() {
    player?.stop();
  }

  loadAudio() async {
    cache.load(audioPath);
  }

  speedAudio() {
    player.setPlaybackRate(playbackRate: 2);
  }

  void refresh() {
    setState(() {});
  }

  void _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 1) {
          _counter--;
          if (_counter <= 0.2 * time) {
            timerColor = Colors.red;
            if (AppController.instance.isSoundOn) {
              speedAudio();
            }
          }
        } else if (_counter == 1) {
          timerColor = Colors.red;
          _counter--;
          _timer.cancel();
          stopAudio();
          _running = false;
          _pause = true;
          if (AppController.instance.isAlarmOn) {
            FlutterRingtonePlayer.playAlarm();
          }
        } else {
          _timer.cancel();
          stopAudio();
          _running = false;
          _pause = true;
          timerColor = Colors.red;
          if (AppController.instance.isAlarmOn) {
            FlutterRingtonePlayer.playAlarm();
          }
        }
        _setCounterText();
      });
    });
  }

  void _setCounterText() {
    _stopwatchText = (_counter ~/ 60).toString() +
        ' m ' +
        (_counter % 60).toString().padLeft(2, '0') +
        ' s';
  }

  void _startStopButtonPressed() {
    FlutterRingtonePlayer.stop();
    setState(() {
      if (_running) {
        _running = false;
        _pause = true;
        stopAudio();
        _timer.cancel();
      } else {
        _running = true;
        _pause = false;
        _startTimer();
        if (AppController.instance.isSoundOn) {
          playAudio();
        }
      }
    });
  }

  void _resetButtonPressed() {
    FlutterRingtonePlayer.stop();
    if (_running) {
      _startStopButtonPressed();
    } else {
      setState(() {
        stopAudio();
        timerColor = Colors.black;
        _counter = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (AppController.instance.isSoundOn) {
      loadAudio();
    }

    _counter = (_running || _pause) ? _counter : _counter = time;

    _stopwatchText = (_counter ~/ 60).toString() +
        ' m ' +
        (_counter % 60).toString().padLeft(2, '0') +
        ' s';

    if (time ~/ 60 > 0) {
      if (time % 60 != 0) {
        if (time ~/ 60 == 1) {
          if (time % 60 == 1) {
            textTempo = (time ~/ 60).toString() +
                minuteAndStart[AppController.instance.lang] +
                (time % 60).toString() +
                secondStart[AppController.instance.lang];
          } else {
            textTempo = (time ~/ 60).toString() +
                minuteAndStart[AppController.instance.lang] +
                (time % 60).toString() +
                secondsStart[AppController.instance.lang];
          }
        } else {
          textTempo = (time ~/ 60).toString() +
              minutesAndStart[AppController.instance.lang] +
              (time % 60).toString() +
              secondsStart[AppController.instance.lang];
        }
      } else {
        if (time ~/ 60 == 1) {
          textTempo = (time ~/ 60).toString() +
              minuteStart[AppController.instance.lang];
        } else {
          textTempo = (time ~/ 60).toString() +
              minutesStart[AppController.instance.lang];
        }
      }
    } else {
      if (time % 60 == 1) {
        textTempo =
            (time % 60).toString() + secondStart[AppController.instance.lang];
      } else {
        textTempo =
            (time % 60).toString() + secondsStart[AppController.instance.lang];
      }
    }

    textTempo = timerButtonMenu[AppController.instance.lang] + textTempo;

    List<EquipeCardGame> listWidgets = List.empty(growable: true);

    for (int i = 0; i < AppController.instance.sizeListEquipeCard(); i++) {
      listWidgets.add(
        EquipeCardGame(
          colorEquipe: AppController.instance.listEquipeCard[i].color,
          nameEquipe: AppController.instance.listEquipeCard[i].name,
          arrowSelected: AppController.instance.listEquipeCard[i].selected,
          count: AppController.instance.listEquipeCard[i].count,
          index: i,
          notifyParent: refresh,
        ),
      );
    }

    List<PersonCardWidget> listPersonWidget = List.empty(growable: true);

    for (int i = 0; i < AppController.instance.sizeListPersonCard(); i++) {
      listPersonWidget.add(
        PersonCardWidget(
          colorEquipe: AppController.instance.listPersonCard[i].color,
          nameEquipe: AppController.instance.listPersonCard[i].equipe,
          namePerson: AppController.instance.listPersonCard[i].name,
          arrowSelected: AppController.instance.listPersonCard[i].selected,
          count: AppController.instance.listPersonCard[i].count,
          index: i,
          notifyParent: refresh,
        ),
      );
    }

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(matchStart[AppController.instance.lang]),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10, top: 30, bottom: 30),
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.78,
              ),
              color: AppController.instance.isDarkTheme
                  ? Colors.grey[700]
                  : Colors.amber[100],
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),
                            child: Text(
                              sortButtonStart[AppController.instance.lang],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                int selected = Random().nextInt(AppController
                                    .instance
                                    .sizeListEquipeCard());

                                for (int i = 0;
                                    i <
                                        AppController.instance
                                            .sizeListEquipeCard();
                                    i++) {
                                  AppController.instance
                                      .changeSelectedEquipe(i, false);
                                }

                                AppController.instance
                                    .changeSelectedEquipe(selected, true);

                                selected = Random().nextInt(AppController
                                    .instance
                                    .sizeListPersonCard());

                                for (int i = 0;
                                    i <
                                        AppController.instance
                                            .sizeListPersonCard();
                                    i++) {
                                  AppController.instance
                                      .changeSelectedPerson(i, false);
                                }

                                AppController.instance
                                    .changeSelectedPerson(selected, true);
                              });
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),
                            child: Text(
                              resetButtonStart[AppController.instance.lang],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                for (int i = 0;
                                    i <
                                        AppController.instance
                                            .sizeListEquipeCard();
                                    i++) {
                                  AppController
                                      .instance.listEquipeCard[i].count = 0;
                                }
                                for (int i = 0;
                                    i <
                                        AppController.instance
                                            .sizeListPersonCard();
                                    i++) {
                                  AppController
                                      .instance.listPersonCard[i].count = 0;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width * 0.9,
                            ),
                            child: Column(children: listWidgets),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width * 0.9,
                            ),
                            child: Column(children: listPersonWidget),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    Visibility(
                      visible: AppController.instance.isTimerVisible,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              textTempo,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(height: 50),
                          FittedBox(
                            fit: BoxFit.none,
                            child: Text(
                              _stopwatchText,
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: timerColor,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  _running
                                      ? Icons.pause_outlined
                                      : Icons.play_arrow_outlined,
                                  size: 40,
                                  color: Colors.black,
                                ),
                                onPressed: _startStopButtonPressed,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.stop_outlined,
                                  size: 40,
                                  color: Colors.black,
                                ),
                                onPressed: _resetButtonPressed,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
