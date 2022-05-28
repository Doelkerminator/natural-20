class Usage {
  String? type;
  List<String>? restTypes;
  int? times;

  Usage({
    this.type,
    this.restTypes,
    this.times
  });

  factory Usage.fromMap(Map<String, dynamic> map) {
    return Usage(
      type: map['type'],
      restTypes: map['rest_types'],
      times: map['times']
    );
  }
}