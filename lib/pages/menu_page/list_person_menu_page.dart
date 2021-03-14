import 'package:contador_de_jogos/controller/app_controller.dart';
import 'package:contador_de_jogos/language/language.dart';
import 'package:flutter/material.dart';

class ListPersonMenuPage extends StatefulWidget {
  ListPersonMenuPage({Key key, @required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _ListPersonMenuPageState createState() => _ListPersonMenuPageState();
}

class _ListPersonMenuPageState extends State<ListPersonMenuPage> {
  @override
  Widget build(BuildContext context) {
    // List to display the players
    List<Widget> listAddedPerson = List.empty(growable: true);

    String dropdownValue = "BRANCO";

    for (int i = 0; i < AppController.instance.sizeListPersonCard(); i++) {
      dropdownValue = AppController.instance.listPersonCard[i].equipe;
      listAddedPerson.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  elevation: 16,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      AppController.instance.listPersonCard[i].equipe =
                          newValue;
                      AppController.instance.listPersonCard[i].color =
                          listColorsEquipes[newValue];
                    });
                  },
                  items: AppController.instance.listColorsEquipesString
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        width: 40,
                        height: 40,
                        color: listColorsEquipes[value],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(width: 20),
              Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.35,
                ),
                child: Text(
                  playerName[AppController.instance.lang] +
                      AppController.instance.listPersonCard[i].name,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    AppController.instance.removePersonCard(i);
                  });
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              peopleButtonMenu[AppController.instance.lang],
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            constraints:
                BoxConstraints(minWidth: MediaQuery.of(context).size.width * 1),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    AppController.instance.scrollController.jumpTo(0);
                    widget.notifyParent();
                  });
                },
              ),
            ),
          ),
          Column(children: listAddedPerson),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                PersonCard person = PersonCard(
                  name: "${AppController.instance.sizeListPersonCard() + 1}",
                  color: AppController.instance.sizeListEquipeCard() > 0
                      ? AppController.instance.listEquipeCard[0].color
                      : Colors.white,
                  selected: false,
                  count: 0,
                  equipe: AppController.instance.sizeListEquipeCard() > 0
                      ? AppController.instance.listEquipeCard[0].name
                      : "BRANCO",
                );
                AppController.instance.addPersonCard(person);
              });
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.grey),
            onPressed: () {
              setState(() {
                List<String> listSortable = List.empty(growable: true);
                listSortable =
                    List.from(AppController.instance.listColorsEquipesString);
                listSortable.remove("BRANCO");
                listSortable.shuffle();
                for (int i = 0;
                    i < AppController.instance.sizeListPersonCard();
                    i++) {
                  if (listSortable.isEmpty) {
                    listSortable = List.from(
                        AppController.instance.listColorsEquipesString);
                    listSortable.remove("BRANCO");
                    listSortable.shuffle();
                  }
                  AppController.instance.listPersonCard[i].equipe =
                      listSortable.removeLast();
                  AppController.instance.listPersonCard[i].color =
                      listColorsEquipes[
                          AppController.instance.listPersonCard[i].equipe];
                }
              });
            },
            child: Text(
              rearrangeButtonMenu[AppController.instance.lang],
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          Container(height: 60),
        ],
      ),
    );
  }
}
