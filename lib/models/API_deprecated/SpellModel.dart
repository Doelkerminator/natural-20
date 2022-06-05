import 'package:natural_20/models/API_deprecated/Meta/SpellDamageModel.dart';

class Spell {
  String? index;
  String? name;
  List<String>? desc;
  List<String>? higherLevel;
  String? range;
  List<String>? components;
  String? material;
  bool? ritual;
  String? duration;
  bool? concentration;
  String? castingTime;
  int? level;
  String? attackType;
  SpellDamage? damage;
  List<String>? school;
  List<String>? classes;
  List<String>? subclasses;

  Spell({
    this.index,
    this.name,
    this.desc,
    this.higherLevel,
    this.range,
    this.components,
    this.material,
    this.ritual,
    this.duration,
    this.concentration,
    this.castingTime,
    this.level,
    this.attackType,
    this.damage,
    this.school,
    this.classes,
    this.subclasses
  });

  factory Spell.fromMap(Map<String, dynamic> map) {
    var classesList = map['classes'] as List;
    var subclassesList = map['subclasses'] as List;
    return Spell(
      index: map['index'],
      name: map['name'],
      desc: map['desc'],
      higherLevel: map['higher_level'],
      range: map['range'],
      components: map['components'],
      material: map['material'],
      ritual: map['ritual'],
      duration: map['duration'],
      concentration: map['concentration'],
      castingTime: map['casting_time'],
      level: map['level'],
      attackType: map['attack_type'],
      damage: SpellDamage.fromMap(map['damage']),
      school: map['school']['name'],
      classes: classesList.map((classe) => classe['name'] as String).toList(),
      subclasses: subclassesList.map((subclass) => subclass['name'] as String).toList()
    );
  }
}