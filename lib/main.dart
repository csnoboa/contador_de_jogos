import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/finish_page.dart';
import 'package:contador_de_jogos/home_page.dart';
import 'package:contador_de_jogos/menu_page.dart';
import 'package:contador_de_jogos/options_page.dart';
import 'package:flutter/material.dart';
import 'package:contador_de_jogos/start_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppController.instance.importFileConfig();
    return AnimatedBuilder(
      builder: (context, child) {
        return MaterialApp(
          title: 'Contador de Jogos',
          routes: {
            '/': (context) => MyHomePage(),
            '/start': (context) => StartPage(),
            '/options': (context) => OptionsPage(),
            '/menu': (context) => MenuPage(),
            '/finish': (context) => FinishPage(),
          },
          initialRoute: '/',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: AppController.instance.isDarkTheme
                ? Brightness.dark
                : Brightness.light,
          ),
        );
      },
      animation: AppController.instance,
    );
  }
}
