import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:flutter/material.dart';

class OptionsPage extends StatefulWidget {
  OptionsPage({Key key}) : super(key: key);

  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OPÇÕES"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ALARME: ',
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                  value: AppController.instance.isSoundOn,
                  onChanged: (value) {
                    setState(
                      () {
                        AppController.instance.changeSound();
                      },
                    );
                  },
                )
              ],
            ),
            Container(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TEMA DARK: ',
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                  value: AppController.instance.isDarkTheme,
                  onChanged: (value) {
                    setState(
                      () {
                        AppController.instance.changeTheme();
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
