
class SpellDamage {
  Map<String, String>? damageAtSlotLevel;
  String? damageType;

  SpellDamage({
    this.damageAtSlotLevel,
    this.damageType
  });

  factory SpellDamage.fromMap(Map<String, dynamic> map) {
    return SpellDamage(
      damageAtSlotLevel: map['damage_at_slot_level'],
      damageType: map['damage_type']['name']
    );
  }
}