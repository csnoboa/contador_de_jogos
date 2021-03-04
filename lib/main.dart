import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/home_page.dart';
import 'package:contador_de_jogos/options_page.dart';
import 'package:flutter/material.dart';
import 'package:contador_de_jogos/start_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return MaterialApp(
          title: 'Contador de Jogos',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (context) => MyHomePage(),
            '/start': (context) => StartPage(),
            '/options': (context) => OptionsPage(),
          },
          initialRoute: '/',
        );
      },
      animation: AppController.instance,
    );
  }
}
