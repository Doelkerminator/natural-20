import 'package:natural_20/models/Meta/MonsterSpellModel.dart';
import 'UsageModel.dart';

class MonsterSpellcasting {
  String? ability;
  int? dc;
  int? modifier;
  List<String>? componentsRequired;
  String? school;
  Map<String, int>? slots;
  List<MonsterSpell>? spells;
  Usage? usage;

  MonsterSpellcasting({
    this.ability,
    this.dc,
    this.modifier,
    this.componentsRequired,
    this.school,
    this.slots,
    this.spells,
    this.usage
  });

  factory MonsterSpellcasting.fromMap(Map<String, dynamic> map) {
    var spellList = map['spells'] as List;
    return MonsterSpellcasting(
      ability: map['ability']['name'],
      dc: map['dc'],
      modifier: map['modifier'],
      componentsRequired: map['components_required'],
      school: map['school'],
      slots: map['slots'],
      spells: spellList.map((spell) => MonsterSpell.fromMap(spell)).toList(),
      usage: Usage.fromMap(map['usage'])
    );
  }
}