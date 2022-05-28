class Condition {
  String? index;
  String? name;
  List<String>? desc;

  Condition({
    this.index,
    this.name,
    this.desc
  });

  factory Condition.fromMap(Map<String, dynamic> map) {
    return Condition(
      index: map['index'],
      name: map['name'],
      desc: map['desc']
    );
  }
}