import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ConfigStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/config.json');
  }

  Future<Config> readConfig() async {
    try {
      final file = await _localFile;

      // Read the file

      String contents = await file.readAsString();
      Map userMap = jsonDecode(contents);
      var config = Config.fromJson(userMap);

      return config;
    } catch (e) {
      return Config(
          time: 90,
          isSoundOn: true,
          isDarkTheme: false,
          isPortuguese: true,
          isTimerVisible: true,
          isAlarmOn: true,
          lang: 'port');
    }
  }

  Future<File> writeConfig(Config _config) async {
    final file = await _localFile;
    String json = jsonEncode(_config);

    // Write the file
    return file.writeAsString('$json');
  }
}

class Config {
  int time;

  bool isSoundOn;
  bool isAlarmOn;
  bool isPortuguese;
  bool isDarkTheme;
  bool isTimerVisible;

  String lang;

  Config(
      {this.isSoundOn,
      this.isAlarmOn,
      this.isPortuguese,
      this.isDarkTheme,
      this.lang,
      this.isTimerVisible,
      this.time});

  Config.fromJson(Map<String, dynamic> json)
      : isSoundOn = json['isSoundOn'],
        isAlarmOn = json['isAlarmOn'],
        isPortuguese = json['isPortuguese'],
        isDarkTheme = json['isDarkTheme'],
        isTimerVisible = json['isTimerVisible'],
        lang = json['lang'],
        time = json['time'];

  Map<String, dynamic> toJson() => {
        'isSoundOn': isSoundOn,
        'isAlarmOn': isAlarmOn,
        'isPortuguese': isPortuguese,
        'isDarkTheme': isDarkTheme,
        'isTimerVisible': isTimerVisible,
        'lang': lang,
        'time': time,
      };
}
