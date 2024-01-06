import 'dart:convert';

/// Contact's Relationship with a person.
enum ContactRelation {
  /// Relative of a person.
  relative('Relative'),

  /// Parent of a person.
  parent('Parent'),

  /// Child of a person.
  child('Child'),

  /// Spouse of a person.
  spouse('Spouse'),

  /// Friend of a person.
  friend('Friend');

  const ContactRelation(this.value);
  final String value;
}

/// Parse string to ContactRelation enum.
///
/// Convert string [value] to ContactRelation enum. Useful to parse string
/// value from stored json.
///
/// Searches for enum name matching with the [value] param and
/// returns the first matching enum element, if no match found for named value
/// in enum then returns the first element of enum as default.
///
/// Example:
/// ``` dart
/// enum ContactRelation {parent, relative};
/// var ContactRelation relation;
/// relation = stringToContactRelation('parent'); // ContactRelation.parent
/// relation = stringToContactRelation('relative'); // ContactRelation.relative
/// relation = stringToContactRelation('uncle'); // No-match: ContactRelation.relative
/// ```
///
/// Iterates through enum elements and returns the first element that satisfies
/// the given predicate [value]. If no element satisfies [value], the first
/// element of ContactRelation enum i.e. [ContactRelation.relative] is returned.
ContactRelation stringToContactRelation(String value) {
  return ContactRelation.values.firstWhere(
    // (element) => element.toString().split('.').last == value,
    (element) => element.name == value,
    orElse: () => ContactRelation.values.first,
  );
}

/// **Emergency Contact Model class**
///
/// String [name],
/// enum [relation] as [ContactRelation],
/// String [number].
class EmergencyContact {
  const EmergencyContact({
    required this.name,
    required this.relation,
    required this.number,
  });

  /// Contact person name.
  final String name;

  /// Person's Relation. One of the [ContactRelation].
  final ContactRelation relation;

  /// Person's contact number to connect.
  final String number;

  /// Factory constructor for creating a new [VehicleSpecification] instance
  /// from a map.
  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'],
      relation: stringToContactRelation(json['relation']),
      number: json['number'],
    );
  }

  /// Helper method to declare support for serialization to JSON.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['relation'] = relation.name;
    data['number'] = number;
    return data;
  }
}

/// Demo primary Emergency contact instance of [EmergencyContact] class.
const EmergencyContact demoPrimary = EmergencyContact(
  name: 'Primary Person',
  relation: ContactRelation.relative,
  number: '9876543210',
);

/// Demo secondary Emergency contact instance of [EmergencyContact] class.
const EmergencyContact demoSecondary = EmergencyContact(
  name: 'Secondary Person',
  relation: ContactRelation.friend,
  number: '9876543211',
);

/// Demo primary Emergency contact JSON string representing instance of
/// [EmergencyContact] class.
const demoPrimaryJsonString = '''
{
  "name": "Primary Person",
  "relation": "relative",
  "number": "9876543210"
}
''';

/// Demo secondary Emergency contact JSON string representing instance of
/// [EmergencyContact] class.
const demoSecondaryJsonString = '''
{
  "name": "Secondary Person",
  "relation": "friend",
  "number": "9876543211"
}
''';

/// Demo instance from primary Emergency contact JSON string
///
/// Deserialize JSON string [demoPrimaryJsonString], parse and create
/// demo instance of [EmergencyContact] class.
final EmergencyContact jsonDemoPrimaryContact =
    EmergencyContact.fromJson(json.decode(demoPrimaryJsonString));

/// Demo instance from secondary Emergency contact JSON string
///
/// Deserialize JSON string [demoSecondaryJsonString], parse and create
/// demo instance of [EmergencyContact] class.
final EmergencyContact jsonDemoSecondaryContact =
    EmergencyContact.fromJson(json.decode(demoSecondaryJsonString));
