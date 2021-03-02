import 'package:flutter/material.dart';
import 'package:contador_de_jogos/start_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador de Jogos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MyHomePage(),
        '/start': (context) => StartPage(),
      },
      initialRoute: '/',
    );
  }
}

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
            child: Text('CONTADOR DE JOGOS', style: TextStyle(fontSize: 28)),
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
                  child: Text('COMEÇAR',
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
                  setState(() {});
                },
                child: Text(
                  'MENU',
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
                  setState(() {});
                },
                child: Text(
                  'OPÇÕES',
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
