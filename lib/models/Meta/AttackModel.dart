import 'DamageModel.dart';
import 'DcModel.dart';

class Attack {
  String? name;               //Attack name
  DC? dc;               //DC Value
  Damage? damage;             //Now that's a lot of damage

  Attack({
    this.name,
    this.dc,
    this.damage
  });

  factory Attack.fromMap(Map<String, dynamic> map) {
    return Attack(
      name: map['name'],
      dc: DC.fromMap(map['dc']),
      damage: Damage.fromMap(map['damage'])
    );
  }
}

