import 'UsageModel.dart';

class MonsterSpell {
  String? name;
  int? level;
  Usage? usage;

  MonsterSpell({
    this.name,
    this.level,
    this.usage
  });

  factory MonsterSpell.fromMap(Map<String, dynamic> map) {
    return MonsterSpell(
      name: map['name'],
      level: map['level'],
      usage: Usage.fromMap(map['usage'])
    );
  }
}