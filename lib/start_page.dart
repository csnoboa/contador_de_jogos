import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/language/language.dart';
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

  Color timerColor = Colors.black;

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
          }
        } else if (_counter == 1) {
          timerColor = Colors.red;
          _counter--;
          _timer.cancel();
          _running = false;
          _pause = true;
          if (AppController.instance.isSoundOn) {
            FlutterRingtonePlayer.playAlarm();
          }
        } else {
          _timer.cancel();
          _running = false;
          _pause = true;
          timerColor = Colors.red;
          if (AppController.instance.isSoundOn) {
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
        _timer.cancel();
      } else {
        _running = true;
        _pause = false;
        _startTimer();
      }
    });
  }

  void _resetButtonPressed() {
    FlutterRingtonePlayer.stop();
    if (_running) {
      // timerColor = Colors.black;
      _startStopButtonPressed();
    } else {
      setState(() {
        timerColor = Colors.black;
        _counter = time;
        // _setCounterText();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

    List<Widget> listWidgets = List.empty(growable: true);

    for (int i = 0; i < AppController.instance.sizeListCard(); i++) {
      listWidgets.add(
        CardStartGame(
          colorEquipe: AppController.instance.listEquipeCard[i].color,
          nameEquipe: AppController.instance.listEquipeCard[i].name,
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
                padding: const EdgeInsets.only(top: 25.0, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(children: listWidgets),
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
            ),
          ),
        ),
      ),
    );
  }
}
