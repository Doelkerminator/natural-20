import 'package:natural_20/models/ConditionModel.dart';
import 'package:natural_20/models/Meta/ProficiencyModel.dart';
import 'package:natural_20/models/Meta/SensesModel.dart';
import 'package:natural_20/models/Meta/SpecialAbility.dart';
import 'Meta/ActionModel.dart';
import 'Meta/SpeedModel.dart';

class Monster {
  String? index;
  String? name;
  List<String>? desc;
  int? charisma;
  int? constitution;
  int? dexterity;
  int? intelligence;
  int? strength;
  int? wisdom;
  String? size;
  String? type;
  String? alignments;
  int? armorClass;
  int? hitPoints;
  int? hitDice;
  int? xp;
  List<Action>? actions;
  List<Action>? legendaryActions;
  List<Condition>? conditionImmunities;
  List<String>? damageImmunities;
  List<String>? damageResistances;
  List<String>? damageVulnerabilities;
  List<String>? forms;
  String? languages;
  List<Proficiency>? proficiencies;
  List<Action>? reactions;
  Senses? senses;
  List<SpecialAbility>? specialAbilities;
  Speed? speed;

  Monster({
    this.index,
    this.name,
    this.desc,
    this.charisma,
    this.constitution,
    this.dexterity,
    this.intelligence,
    this.strength,
    this.wisdom,
    this.size,
    this.type,
    this.alignments,
    this.armorClass,
    this.hitPoints,
    this.hitDice,
    this.xp,
    this.actions,
    this.legendaryActions,
    this.conditionImmunities,
    this.damageImmunities,
    this.damageResistances,
    this.damageVulnerabilities,
    this.forms,
    this.languages,
    this.proficiencies,
    this.reactions,
    this.senses,
    this.specialAbilities,
    this.speed
  });

  factory Monster.fromMap(Map<String, dynamic> map) {
    var actionsList = map['actions'] as List;
    var legendaryActionsList = map['legendary_actions'] as List;
    var conditionList = map['condition'] as List;
    var formsList = map['forms'] as List;
    var proficienciesList = map['proficiencies'] as List;
    var reactionsList = map['reactions'] as List;
    var specialAbilitiesList = map['special_abilities'] as List;
    return Monster(
      index: map['index'],
      name: map['name'],
      desc: map['desc'],
      charisma: map['charisma'],
      constitution: map['constitution'],
      dexterity: map['dexterity'],
      intelligence: map['intelligence'],
      strength: map['strength'],
      wisdom: map['wisdom'],
      size: map['size'],
      type: map['type'],
      alignments: map['alignments'],
      armorClass: map['armor_class'],
      hitPoints: map['hit_points'],
      hitDice: map['hit_dice'],
      xp: map['xp'],
      actions: actionsList.map((action) => Action.fromMap(action)).toList(),
      legendaryActions: legendaryActionsList.map((action) => Action.fromMap(action)).toList(),
      conditionImmunities: conditionList.map((condition) => Condition.fromMap(condition)).toList(),
      damageImmunities: map['damage_immunities'],
      damageResistances: map['damage_resistances'],
      damageVulnerabilities: map['damage_vulnerabilities'],
      forms: formsList.map((form) => form['name'] as String).toList(),
      languages: map['languages'],
      proficiencies: proficienciesList.map((proficiency) => Proficiency.fromMap(proficiency)).toList(),
      reactions: reactionsList.map((reaction) => Action.fromMap(reaction)).toList(),
      senses: Senses.fromMap(map['senses']),
      specialAbilities: specialAbilitiesList.map((special) => SpecialAbility.fromMap(special)).toList(),
      speed: Speed.fromMap(map['speed'])
    );
  }
}