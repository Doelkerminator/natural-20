class Language {
  String? index;
  String? name;
  String? type;
  List<String>? typicalSpeakers;
  String? script;

  Language({
    this.index,
    this.name,
    this.type,
    this.typicalSpeakers,
    this.script
  });

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      index: map['index'],
      name: map['name'],
      type: map['type'],
      typicalSpeakers: map['typical_speakers'],
      script: map['script']
    );
  }
}