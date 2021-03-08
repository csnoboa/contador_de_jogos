import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:contador_de_jogos/language/language.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Text(titleHomeLang[AppController.instance.lang],
                style: TextStyle(fontSize: 28)),
          ),
          centerTitle: true,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: Container(
                width: 250,
                height: 250,
                child: RaisedButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pushNamed('/start');
                    });
                  },
                  child: Text(startButtonHome[AppController.instance.lang],
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            Container(height: 50),
            Container(
              width: 150,
              height: 50,
              child: RaisedButton(
                color: Colors.yellowAccent,
                onPressed: () {
                  Navigator.of(context).pushNamed('/menu');
                },
                child: Text(
                  menuButtonHome[AppController.instance.lang],
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            Container(height: 10),
            Container(
              width: 150,
              height: 50,
              child: RaisedButton(
                color: Colors.yellowAccent,
                onPressed: () {
                  Navigator.of(context).pushNamed('/options');
                },
                child: Text(
                  optionsButtonHome[AppController.instance.lang],
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
