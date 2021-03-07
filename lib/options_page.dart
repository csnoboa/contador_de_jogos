import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:contador_de_jogos/language/language.dart';

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
        title: Text(titleOptionsPage[AppController.instance.lang]),
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
                  switchAlarm[AppController.instance.lang],
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
                  switchDarkTheme[AppController.instance.lang],
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
            Container(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textLanguage[AppController.instance.lang],
                  style: TextStyle(fontSize: 20),
                ),
                Column(
                  children: [
                    Container(
                      width: 220,
                      child: CheckboxListTile(
                        value: AppController.instance.isPortuguese,
                        onChanged: (value) {
                          setState(() {
                            AppController.instance.isPortuguese = true;
                            AppController.instance.changeLanguage('port');
                          });
                        },
                        title: Text(
                          "PORTUGUÊS",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      width: 220,
                      child: CheckboxListTile(
                        value: !AppController.instance.isPortuguese,
                        onChanged: (value) {
                          setState(() {
                            AppController.instance.isPortuguese = false;
                            AppController.instance.changeLanguage('eng');
                          });
                        },
                        title: Text(
                          "ENGLISH",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
