
import '../../Meta/AttackModel.dart';
import '../../Meta/DamageModel.dart';
import 'DcModel.dart';

class Action {
  String? name;                   //Action name
  String? desc;                   //Action description
  int? optionsChoose;             //Number of options to choose per action
  List<String>? options;          //List of options to choose from
  int? attackBonus;               //Bonus to the attack
  DC? dc;                         //Dice check
  List<Attack>? attacks;          //Attacks related to this action
  List<Damage>? damage;           //Damage related to this action

  Action({
    this.name,
    this.desc,
    this.optionsChoose,
    this.options,
    this.attackBonus,
    this.dc,
    this.attacks,
    this.damage
  });

  factory Action.fromMap(Map<String, dynamic> map) {
    var optionsList = map['options']['from'] as List;
    var attacksList = map['attacks'] as List;
    var damagesList = map['damage'] as List;
    return Action(
      name: map['name'],
      desc: map['desc'],
      optionsChoose: map['options']['choose'],
      options: optionsList.map((option) => option['name'] as String).toList(),
      attackBonus: map['attack_bonus'],
      dc: DC.fromMap(map['dc']),
      attacks: attacksList.map((attack) => Attack.fromMap(attack)).toList(),
      damage: damagesList.map((damage) => Damage.fromMap(damage)).toList()
    );
  }
}