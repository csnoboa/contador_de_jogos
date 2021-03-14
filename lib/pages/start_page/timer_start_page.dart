import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/language/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class TimerStartPage extends StatefulWidget {
  TimerStartPage({Key key}) : super(key: key);

  @override
  _TimerStartPageState createState() => _TimerStartPageState();
}

class _TimerStartPageState extends State<TimerStartPage> {
  Timer _timer;
  bool _pause = false;
  int _counter;
  String _stopwatchText;
  bool _running = false;
  int time = AppController.instance.time;
  String textTempo = ' ';
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

    return Visibility(
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
                  _running ? Icons.pause_outlined : Icons.play_arrow_outlined,
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
    );
  }
}
