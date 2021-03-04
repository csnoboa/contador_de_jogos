import 'package:contador_de_jogos/controller/app_controller.dart';
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

  void _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          _running = false;
          _pause = true;
          FlutterRingtonePlayer.playAlarm();
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
      _startStopButtonPressed();
    }
    setState(() {
      _counter = time;
      _setCounterText();
    });
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
                ' MINUTO E ' +
                (time % 60).toString() +
                ' SEGUNDO';
          } else {
            textTempo = (time ~/ 60).toString() +
                ' MINUTO E ' +
                (time % 60).toString() +
                ' SEGUNDOS';
          }
        } else {
          textTempo = (time ~/ 60).toString() +
              ' MINUTOS E ' +
              (time % 60).toString() +
              ' SEGUNDOS';
        }
      } else {
        if (time ~/ 60 == 1) {
          textTempo = (time ~/ 60).toString() + ' MINUTO';
        } else {
          textTempo = (time ~/ 60).toString() + ' MINUTOS';
        }
      }
    } else {
      if (time % 60 == 1) {
        textTempo = (time % 60).toString() + ' SEGUNDO';
      } else {
        textTempo = (time % 60).toString() + ' SEGUNDOS';
      }
    }

    textTempo = "TEMPO: " + textTempo;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('PARTIDA'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15, top: 30, bottom: 30),
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.78,
              ),
              color: Colors.amber[100],
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CardStartGame(
                      colorEquipe: Colors.blue,
                      nameEquipe: 'AZUL',
                    ),
                    CardStartGame(
                      colorEquipe: Colors.red,
                      nameEquipe: 'VERM',
                    ),
                    CardStartGame(
                      colorEquipe: Colors.yellow,
                      nameEquipe: 'AMAR',
                    ),
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
                          ),
                          onPressed: _startStopButtonPressed,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.stop_outlined,
                            size: 40,
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
