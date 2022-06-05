class Cost {
  int? quantity;
  String? unit;

  Cost({
    this.quantity,
    this.unit
  });

  factory Cost.fromMap(Map<String, dynamic> map) {
    return Cost(
      quantity: map['quantity'],
      unit: map['unit']
    );
  }
}