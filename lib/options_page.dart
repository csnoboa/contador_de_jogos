import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:flutter/material.dart';

class OptionsPage extends StatefulWidget {
  OptionsPage({Key key}) : super(key: key);

  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  int _counter = AppController.instance.time;

  String _stopwatchText;

  @override
  Widget build(BuildContext context) {
    _stopwatchText = (_counter ~/ 60).toString() +
        ' m ' +
        (_counter % 60).toString().padLeft(2, '0') +
        ' s';
    return WillPopScope(
      onWillPop: () async {
        AppController.instance.changeTime(_counter);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('OPÇÕES'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    width: 60,
                    height: 60,
                    child: RaisedButton(
                      child: Text('-10'),
                      onPressed: () {
                        setState(() {
                          if (_counter < 10) {
                            _counter = 0;
                          } else {
                            _counter -= 10;
                          }
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
                    });
                  },
                ),
                Container(width: 5),
                ClipOval(
                  child: Container(
                    width: 60,
                    height: 60,
                    child: RaisedButton(
                      child: Text('+10'),
                      onPressed: () {
                        setState(() {
                          _counter += 10;
                        });
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
