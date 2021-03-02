import 'package:flutter/material.dart';

class PartidaPage extends StatefulWidget {
  PartidaPage({Key key}) : super(key: key);

  @override
  _PartidaPageState createState() => _PartidaPageState();
}

class _PartidaPageState extends State<PartidaPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
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
      ),
    );
  }
}
