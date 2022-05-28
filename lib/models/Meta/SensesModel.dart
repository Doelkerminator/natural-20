class Senses {
  int? passivePerception;
  String? blindSight;
  String? darkVision;
  String? tremorSense;
  String? trueSight;

  Senses({
    this.passivePerception,
    this.blindSight,
    this.darkVision,
    this.tremorSense,
    this.trueSight
  });

  factory Senses.fromMap(Map<String, dynamic> map) {
    return Senses(
      passivePerception: map['passive_perception'],
      blindSight: map['blindsight'],
      darkVision: map['darkvision'],
      tremorSense: map['tremorsense'],
      trueSight: map['truesight']
    );
  }
}