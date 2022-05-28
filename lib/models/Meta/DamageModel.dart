class Damage {
  String? damageType;
  String? damageDice;

  Damage({
    this.damageType,
    this.damageDice
  });

  factory Damage.fromMap(Map<String, dynamic> map) {
    return Damage(
      damageType: map['damage_type']['name'],
      damageDice: map['damage_dice']
    );
  }
}