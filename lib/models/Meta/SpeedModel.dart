class Speed {
  String? walk;
  String? burrow;
  String? climb;
  String? fly;
  String? swim;

  Speed({
    this.walk,
    this.burrow,
    this.climb,
    this.fly,
    this.swim
  });

  factory Speed.fromMap(Map<String, dynamic> map) {
    return Speed(
      walk: map['walk'],
      burrow: map['burrow'],
      climb: map['climb'],
      fly: map['fly'],
      swim: map['swim']
    );
  }
}