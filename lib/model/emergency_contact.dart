enum ContactRelation {
  parent('Parent'),
  spouse('Spouse'),
  relative('Relative'),
  friend('Friend');

  const ContactRelation(this.value);
  final String value;
}

class EmergencyContact {
  const EmergencyContact({
    required this.name,
    required this.relation,
    required this.number,
  });

  final String name;
  final ContactRelation relation;
  final String number;

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'],
      relation: json['relation'],
      number: json['number'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['relation'] = relation;
    data['number'] = number;
    return data;
  }
}
