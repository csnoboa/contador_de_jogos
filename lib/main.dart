import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/pages/finish_page/finish_page.dart';
import 'package:contador_de_jogos/pages/home_page/home_page.dart';
import 'package:contador_de_jogos/pages/menu_page/menu_page.dart';
import 'package:contador_de_jogos/pages/options_page/options_page.dart';
import 'package:flutter/material.dart';
import 'package:contador_de_jogos/pages/start_page/start_page.dart';

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
