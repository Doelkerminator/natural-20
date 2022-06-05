class DC {
  String? dcType;
  int? dcValue;
  String? successType;

  DC({
    this.dcType,
    this.dcValue,
    this.successType
  });

  factory DC.fromMap(Map<String, dynamic> map) {
    return DC(
      dcType: map['dc_type']['name'],
      dcValue: map['dc_value'],
      successType: map['success_type']
    );
  }
}