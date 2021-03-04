import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CardStartStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/cardstart.txt');
  }

  Future<Map<String, dynamic>> readCard() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();
      Map<String, dynamic> user = jsonDecode(contents);

      return user;
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<File> writeCounter(String card) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('{\n "name": "AMAR", "color" : "yellow"');
  }
}
