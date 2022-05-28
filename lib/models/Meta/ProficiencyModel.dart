class Proficiency {
  String? index;
  String? name;
  String? type;

  Proficiency({
    this.index,
    this.name,
    this.type
  });

  factory Proficiency.fromMap(Map<String, dynamic> map) {
    return Proficiency(
      index: map['index'],
      name: map['name'],
      type: map['type']
    );
  }
}