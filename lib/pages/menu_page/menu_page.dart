import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/pages/menu_page/list_equipe_menu_page.dart';
import 'package:contador_de_jogos/pages/menu_page/list_person_menu_page.dart';
import 'package:contador_de_jogos/pages/menu_page/timer_menu_page.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AppController.instance.saveFileConfig();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('MENU'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TimerMenuPage(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListEquipeMenuPage(notifyParent: refresh),
                    ListPersonMenuPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
