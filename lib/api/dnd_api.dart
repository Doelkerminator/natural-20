import 'dart:convert';

import 'package:http/http.dart' as http;

class DnDApi {

  //Monster Data
  static Future<List<Map<String, String>>?> getMonsterList() async {
    var URL = Uri.parse(
      'https://www.dnd5eapi.co/api/monsters'
    );
    var response = await http.get(URL);
    if (response.statusCode == 200) {
      var results = jsonDecode(response.body)['results'] as List;
      List<Map<String, String>> monsters = [];
      for (var monster in results) {
        monsters.add({
          "index": monster['index'],
          "name": monster['name']
        });
      }
      return monsters;
    }
    else {
      return null;
    }
  }

}