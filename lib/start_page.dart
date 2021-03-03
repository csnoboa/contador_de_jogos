import 'package:flutter/material.dart';
import 'package:contador_de_jogos/card_start_game.dart';
import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String _stopwatchText = '03 m 00 s';
  int _counter = 150;
  int _counterInit = 150;
  Timer _timer;
  bool _running = false;

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
          FlutterRingtonePlayer.playNotification();
        }
        _setCounterText();
      });
    });
  }

  void _setCounterText() {
    _stopwatchText = (_counter ~/ 60).toString().padLeft(2, '0') +
        ' m ' +
        (_counter % 60).toString().padLeft(2, '0') +
        ' s';
  }

  void _startStopButtonPressed() {
    setState(() {
      if (_running) {
        _running = false;
        _timer.cancel();
      } else {
        _running = true;
        _startTimer();
      }
    });
  }

  void _resetButtonPressed() {
    if (_running) {
      _startStopButtonPressed();
    }
    setState(() {
      _counter = _counterInit;
      _setCounterText();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('PARTIDA'),
          centerTitle: true,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15, top: 30, bottom: 30),
          child: Container(
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
                  Container(height: 25),
                  CardStartGame(
                    colorEquipe: Colors.red,
                    nameEquipe: 'VERM',
                  ),
                  Container(height: 25),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'TEMPO: 3 MINUTOS',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(height: 25),
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
    );
  }
}
