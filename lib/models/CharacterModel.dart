import 'package:natural_20/models/Meta/AttackModel.dart';
import 'package:natural_20/models/Meta/ProficiencyModel.dart';
import 'package:natural_20/models/API_deprecated/SpellModel.dart';

import 'API_deprecated/LanguageModel.dart';
import 'Meta/SpeedModel.dart';

class Character {
//Main info
  String? name;
  int? level;
  String? classe;
  String? background;
  String? playerName;
  String? race;
  String? alignment;
  String? xp;

//Abilities
  int? strength;
  int? dexterity;
  int? constitution;
  int? intelligence;
  int? wisdom;
  int? charisma;
  int? inspiration;

  int? proficiencyBonus;

//Saving throws
  int? savingStrength;
  int? savingDexterity;
  int? savingConstitution;
  int? savingIntelligence;
  int? savingWisdom;
  int? savingCharisma;

//Skills
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
  List<String>? languages;
  List<String>? proficiencies;

//Battle
  int? armorClass;
  int? initiative;
  int? speed;
  int? hitPoints;
  int? maxHitPoints;
  int? temporaryHitPoints;
  String? hitDice;
  int? deathSaveFail;
  int? deathSaveSuccess;

  List<Attack>? attacks;

//Equipment
  int? cp;
  int? sp;
  int? ep;
  int? gp;
  int? pp;
  List<String>? equipment;

//Character traits
  String? personalityTraits;
  String? ideals;
  String? bonds;
  String? flaws;
  String? features;

//Physical
  int? age;
  double? height;
  double? weight;
  String? eyes;
  String? skin;
  String? hair;
  String? appearance;

  String? backstory;
  String? allies;
  String? treasure;
//Spellcasting
  String? spellcastingAbility;
  int? spellSave;
  int? spellAttackBonus;
  int? spellSlots0;
  List<String>? spells0;
  int? spellSlots1;
  List<String>? spells1;
  int? spellSlots2;
  List<String>? spells2;
  int? spellSlots3;
  List<String>? spells3;
  int? spellSlots4;
  List<String>? spells4;
  int? spellSlots5;
  List<String>? spells5;
  int? spellSlots6;
  List<String>? spells6;
  int? spellSlots7;
  List<String>? spells7;
  int? spellSlots8;
  List<String>? spells8;
  int? spellSlots9;
  List<String>? spells9;

  Character({
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
    this.maxHitPoints,
    this.temporaryHitPoints,
    this.hitDice,
    this.deathSaveFail,
    this.deathSaveSuccess,
    this.attacks,
    this.cp,
    this.sp,
    this.ep,
    this.gp,
    this.pp,
    this.equipment,
    this.personalityTraits,
    this.ideals,
    this.bonds,
    this.flaws,
    this.features,
    this.age,
    this.height,
    this.weight,
    this.eyes,
    this.skin,
    this.hair,
    this.appearance,
    this.backstory,
    this.allies,
    this.treasure,
    this.spellcastingAbility,
    this.spellSave,
    this.spellAttackBonus,
    this.spellSlots0,
    this.spells0,
    this.spellSlots1,
    this.spells1,
    this.spellSlots2,
    this.spells2,
    this.spellSlots3,
    this.spells3,
    this.spellSlots4,
    this.spells4,
    this.spellSlots5,
    this.spells5,
    this.spellSlots6,
    this.spells6,
    this.spellSlots7,
    this.spells7,
    this.spellSlots8,
    this.spells8,
    this.spellSlots9,
    this.spells9,
  });

  factory Character.fromMap(Map <String, dynamic> map) {
    return Character(
      name: map['name'],
      level: map['level'],
      classe: map['class'],
      background: map['background'],
      playerName: map['player_name'],
      race: map['race'],
      alignment: map['alignment'],
      xp: map['xp'],
      strength: map['ability']['strength'],
      dexterity: map['ability']['dexterity'],
      constitution: map['ability']['constitution'],
      intelligence: map['ability']['intelligence'],
      wisdom: map['ability']['wisdom'],
      charisma: map['ability']['charisma'],
      inspiration: map['inspiration'],
      proficiencyBonus: map['proficiency_bonus'],
      savingStrength: map['saving_throws']['strength'],
      savingDexterity: map['saving_throws']['dexterity'],
      savingConstitution: map['saving_throws']['constitution'],
      savingIntelligence: map['saving_throws']['intelligence'],
      savingWisdom: map['saving_throws']['wisdom'],
      savingCharisma: map['saving_throws']['charisma'],
      acrobatics: map['skills']['acrobatics'],
      animalHandling: map['skills']['animal_handling'],
      arcana: map['skills']['arcana'],
      athletics: map['skills']['athletics'],
      deception: map['skills']['deception'],
      history: map['skills']['history'],
      insight: map['skills']['insight'],
      intimidation: map['skills']['intimidation'],
      investigation: map['skills']['investigation'],
      //Aquí te quedaste bue
    );
  }
}