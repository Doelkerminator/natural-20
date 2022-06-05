import 'MonsterSpellcasting.dart';
import '../../Meta/DamageModel.dart';
import 'DcModel.dart';

class SpecialAbility {
  String? name;
  String? desc;
  int? attackBonus;
  List<Damage>? damage;
  DC? dc;
  MonsterSpellcasting? spellcasting;

  SpecialAbility({
    this.name,
    this.desc,
    this.attackBonus,
    this.damage,
    this.dc,
    this.spellcasting
  });

  factory SpecialAbility.fromMap(Map<String, dynamic> map) {
    var damagesList = map['damage'] as List;
    return SpecialAbility(
      name: map['name'],
      desc: map['desc'],
      damage: damagesList.map((damage) => Damage.fromMap(damage)).toList(),
      dc: DC.fromMap(map['dc']),
      spellcasting: MonsterSpellcasting.fromMap(map['spellcasting'])
    );
  }
}