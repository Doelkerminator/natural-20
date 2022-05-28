import 'package:natural_20/models/Meta/ProficiencyModel.dart';
import 'package:natural_20/models/SpellModel.dart';

import 'LanguageModel.dart';
import 'Meta/SpeedModel.dart';

class Character {
  String? index;
  String? name;
  int? level;
  String? classe;
  String? background;
  String? playerName;
  String? race;
  String? alignment;
  String? xp;
  int? strength;
  int? dexterity;
  int? constitution;
  int? intelligence;
  int? wisdom;
  int? charisma;
  int? inspiration;
  int? proficiencyBonus;
  int? savingStrength;
  int? savingDexterity;
  int? savingConstitution;
  int? savingIntelligence;
  int? savingWisdom;
  int? savingCharisma;
  int? acrobatics;
  int? animalHandling;
  int? arcana;
  int? athletics;
  int? deception;
  int? history;
  int? insight;
  int? intimidation;
  int? investigation;
  int? medicine;
  int? nature;
  int? perception;
  int? performance;
  int? persuasion;
  int? religion;
  int? sleightOfHand;
  int? stealth;
  int? survival;
  int? passiveWisdom;
  List<Language>? languages;
  List<Proficiency>? proficiencies;
  int? armorClass;
  int? initiative;
  Speed? speed;
  int? hitPoints;
  String? hitDice;
  int? cp;
  int? sp;
  int? ep;
  int? gp;
  int? pp;
  List<String>? equipment;
  int? age;
  String? height;
  String? weight;
  String? eyes;
  String? skin;
  String? hair;
  String? appearance;
  String? backstory;
  String? spellcastingClass;
  String? spellcastingAbility;
  String? spellSaveAbility;
  String? spellAttackBonus;
  List<Spell>? spells;

  Character({
    this.index,
    this.name,
    this.level,
    this.classe,
    this.background,
    this.playerName,
    this.race,
    this.alignment,
    this.xp,
    this.strength,
    this.dexterity,
    this.constitution,
    this.intelligence,
    this.wisdom,
    this.charisma,
    this.inspiration,
    this.proficiencyBonus,
    this.savingStrength,
    this.savingDexterity,
    this.savingConstitution,
    this.savingIntelligence,
    this.savingWisdom,
    this.savingCharisma,
    this.acrobatics,
    this.animalHandling,
    this.arcana,
    this.athletics,
    this.deception,
    this.history,
    this.insight,
    this.intimidation,
    this.investigation,
    this.medicine,
    this.nature,
    this.perception,
    this.performance,
    this.persuasion,
    this.religion,
    this.sleightOfHand,
    this.stealth,
    this.survival,
    this.passiveWisdom,
    this.languages,
    this.proficiencies,
    this.armorClass,
    this.initiative,
    this.speed,
    this.hitPoints,
    this.hitDice,
    this.cp,
    this.sp,
    this.ep,
    this.gp,
    this.pp,
    this.equipment,
    this.age,
    this.height,
    this.weight,
    this.eyes,
    this.skin,
    this.hair,
    this.appearance,
    this.backstory,
    this.spellcastingClass,
    this.spellcastingAbility,
    this.spellSaveAbility,
    this.spellAttackBonus,
    this.spells
  });
}