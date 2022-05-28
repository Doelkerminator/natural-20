import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/MonsterModel.dart';

class DnDApi {

  //Monster Data
  static Future<List<Map<String, String>>?> getMonsterList() async {
    var url = Uri.parse(
      'https://www.dnd5eapi.co/api/monsters'
    );
    var response = await http.get(url);
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

  static Future<Monster?> getMonster(index) async {
    var url = Uri.parse(
      'https://www.dnd5eapi.co/api/monsters/$index'
    );
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var monster = jsonDecode(response.body);
      return Monster.fromMap(monster);
    }
    else {
      return null;
    }
  }

}