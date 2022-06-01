class Damage {
  String? type;
  String? damage;

  Damage({
    this.type,
    this.damage,
  });

  factory Damage.fromMap(Map<String, dynamic> map) {
    return Damage(
      damage: map['damage'],
      type: map['type'],
    );
  }
}