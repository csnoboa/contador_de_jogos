import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/language/language.dart';
import 'package:flutter/material.dart';

class TimerMenuPage extends StatefulWidget {
  TimerMenuPage({Key key}) : super(key: key);

  @override
  _TimerMenuPageState createState() => _TimerMenuPageState();
}

class _TimerMenuPageState extends State<TimerMenuPage> {
  int _counter = AppController.instance.time;

  String _stopwatchText;

  @override
  Widget build(BuildContext context) {
    _stopwatchText = (_counter ~/ 60).toString() +
        ' m ' +
        (_counter % 60).toString().padLeft(2, '0') +
        ' s';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                switchTimerVisible[AppController.instance.lang],
                style: TextStyle(fontSize: 20),
              ),
              Switch(
                value: AppController.instance.isTimerVisible,
                onChanged: (value) {
                  setState(
                    () {
                      AppController.instance.changeTimerVisible();
                    },
                  );
                },
              )
            ],
          ),
        ),
        Visibility(
          visible: AppController.instance.isTimerVisible,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(timerButtonMenu[AppController.instance.lang],
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 60,
                        height: 60,
                        child: ElevatedButton(
                          child: Text('-10'),
                          onPressed: () {
                            setState(() {
                              if (_counter < 10) {
                                _counter = 0;
                              } else {
                                _counter -= 10;
                              }
                              AppController.instance.changeTime(_counter);
                            });
                          },
                        ),
                      ),
                    ),
                    Container(width: 5),
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          if (_counter > 0) {
                            _counter--;
                            AppController.instance.changeTime(_counter);
                          }
                        });
                      },
                    ),
                    Container(width: 5),
                    Text(
                      '$_stopwatchText',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(width: 5),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        setState(() {
                          _counter++;

                          AppController.instance.changeTime(_counter);
                        });
                      },
                    ),
                    Container(width: 5),
                    ClipOval(
                      child: Container(
                        width: 60,
                        height: 60,
                        child: ElevatedButton(
                          child: Text('+10'),
                          onPressed: () {
                            setState(() {
                              _counter += 10;
                              AppController.instance.changeTime(_counter);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
