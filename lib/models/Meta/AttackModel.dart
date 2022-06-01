import 'DamageModel.dart';

class Attack {
  String? name;               //Attack name
  int? attackBonus;           //Bonus to attack
  Damage? damage;             //Now that's a lot of damage

  Attack({
    this.name,
    this.attackBonus,
    this.damage
  });

  factory Attack.fromMap(Map<String, dynamic> map) {
    return Attack(
      name: map['name'],
      attackBonus: map['attack_bonus'],
      damage: Damage.fromMap(map['damage'])
    );
  }
}

