class Station {
  final String id;
  final String name;

  Station({required this.id, required this.name});

  factory Station.fromMap(Map<String, dynamic> map) {
    final fields = map['fields'] as Map<String, dynamic>;
    return Station(
      id: map['name'],
      name: fields['name']['stringValue'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': {'stringValue': name},
    };
  }
}
