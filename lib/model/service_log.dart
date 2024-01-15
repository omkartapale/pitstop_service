import 'dart:convert';

/// **Vehicle Service Log Model class**
///
/// DateTime [lastServiceDate],
/// int [lastOdometer],
/// String [worknotes],
/// DateTime [dueServiceDate],
/// int [dueOdometer],
/// String [suggestions].
class ServiceLog {
  /// Creates an instance of [VehicleSpecification] model class.
  const ServiceLog({
    required this.lastServiceDate,
    required this.lastOdometer,
    required this.worknotes,
    required this.dueServiceDate,
    required this.dueOdometer,
    required this.suggestions,
  });

  /// Vehicle's last service date.
  final DateTime lastServiceDate;

  /// Odometer reading when the vehicle last serviced.
  final int lastOdometer;

  /// Worknotes from technician about the tasks performed in vehicle's
  /// last service.
  final String worknotes;

  /// Vehicle's next service due date.
  final DateTime dueServiceDate;

  /// Odometer reading for next service due.
  final int dueOdometer;

  /// Suggestions from technician about work to perform in next service.
  final String suggestions;

  /// Get the list of worknotes.
  ///
  /// Splits the string at commas and returns a list of substrings with
  /// additional checking if substring is not empty.
  List<String> get worknotesList =>
      worknotes.split(',').where((e) => e.trim().isNotEmpty).toList();

  /// Get the list of suggestions.
  ///
  /// Splits the string at commas and returns a list of substrings with
  /// additional checking if substring is not empty.
  List<String> get suggestionsList =>
      suggestions.split(',').where((e) => e.trim().isNotEmpty).toList();

  /// Factory constructor for creating a new [ServiceLog] instance from a map.
  factory ServiceLog.fromJson(Map<String, dynamic> json) {
    return ServiceLog(
      lastServiceDate:
          DateTime.fromMillisecondsSinceEpoch(json['lastServiceDate']),
      lastOdometer: json['lastOdometer'],
      worknotes: json['worknotes'],
      dueServiceDate:
          DateTime.fromMillisecondsSinceEpoch(json['dueServiceDate']),
      dueOdometer: json['dueOdometer'],
      suggestions: json['suggestions'],
    );
  }

  /// Helper method to declare support for serialization to JSON.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastServiceDate'] = lastServiceDate.millisecondsSinceEpoch;
    data['lastOdometer'] = lastOdometer;
    data['worknotes'] = worknotes;
    data['dueServiceDate'] = dueServiceDate.millisecondsSinceEpoch;
    data['dueOdometer'] = dueOdometer;
    data['suggestions'] = suggestions;
    return data;
  }
}

/// Converts a JSON string into a Service Log List.
///
/// Deserialize JSON string [jsonString], parse and return list of [ServiceLog].
/// Useful to parse JSON array of [ServiceLog] objects from stored json.
List<ServiceLog> parseServiceLogs(String jsonString) {
  final parsed = (jsonDecode(jsonString) as List).cast<Map<String, dynamic>>();

  return parsed.map<ServiceLog>((json) => ServiceLog.fromJson(json)).toList();
}

/// Demo instance 1 of [ServiceLog] class.
final ServiceLog demoServiceLog1 = ServiceLog(
  lastServiceDate: DateTime.fromMillisecondsSinceEpoch(1597190400000),
  lastOdometer: 1000,
  worknotes: 'Brake Oil, Brake Pads, Engine Tuneup',
  dueServiceDate: DateTime.fromMillisecondsSinceEpoch(1628467200000),
  dueOdometer: 2000,
  suggestions: 'Brake Oil, Calliper Pin',
);

/// Demo instance 2 of [ServiceLog] class.
final ServiceLog demoServiceLog2 = ServiceLog(
  lastServiceDate: DateTime.fromMillisecondsSinceEpoch(1631145600000),
  lastOdometer: 2000,
  worknotes: 'Brake Oil, Brake Pads, Engine Tuneup',
  dueServiceDate: DateTime.fromMillisecondsSinceEpoch(1659052800000),
  dueOdometer: 3000,
  suggestions: 'Brake Oil, Calliper Pin',
);

/// Demo instance 3 of [ServiceLog] class.
final ServiceLog demoServiceLog3 = ServiceLog(
  lastServiceDate: DateTime.fromMillisecondsSinceEpoch(1664582400000),
  lastOdometer: 3000,
  worknotes: 'Brake Oil, Brake Pads, Engine Tuneup',
  dueServiceDate: DateTime.fromMillisecondsSinceEpoch(1685491200000),
  dueOdometer: 4000,
  suggestions: 'Brake Oil, Calliper Pin',
);

/// Demo instance 4 of [ServiceLog] class.
final ServiceLog demoServiceLog4 = ServiceLog(
  lastServiceDate: DateTime.fromMillisecondsSinceEpoch(1686528000000),
  lastOdometer: 4000,
  worknotes: 'Brake Oil, Brake Pads, Engine Tuneup',
  dueServiceDate: DateTime.fromMillisecondsSinceEpoch(1699747200000),
  dueOdometer: 5000,
  suggestions: 'Brake Oil, Calliper Pin',
);

/// Demo instance 5 of [ServiceLog] class.
final ServiceLog demoServiceLog5 = ServiceLog(
  lastServiceDate: DateTime.fromMillisecondsSinceEpoch(1699747200000),
  lastOdometer: 5000,
  worknotes: 'Brake Oil, Brake Pads, Engine Tuneup',
  dueServiceDate: DateTime.fromMillisecondsSinceEpoch(1710201600000),
  dueOdometer: 6000,
  suggestions: 'Brake Oil, Calliper Pin',
);

/// Demo list of 5 dummy Service logs
final List<ServiceLog> demoListServiceLogs = [
  demoServiceLog1,
  demoServiceLog2,
  demoServiceLog3,
  demoServiceLog4,
  demoServiceLog5
];

/// Demo JSON string representing 5 dummy Service Logs.
const demoListServiceLogsJsonString = '''
[
  {
    "lastServiceDate": 1597190400000,
    "lastOdometer": 1000,
    "worknotes": "Brake Oil, Brake Pads, Engine Tuneup",
    "dueServiceDate": 1628467200000,
    "dueOdometer": 2000,
    "suggestions": "Brake Oil, Calliper Pin"
  },
  {
    "lastServiceDate": 1631145600000,
    "lastOdometer": 2000,
    "worknotes": "Brake Oil, Brake Pads, Engine Tuneup",
    "dueServiceDate": 1659052800000,
    "dueOdometer": 3000,
    "suggestions": "Brake Oil, Calliper Pin"
  },
  {
    "lastServiceDate": 1664582400000,
    "lastOdometer": 3000,
    "worknotes": "Brake Oil, Brake Pads, Engine Tuneup",
    "dueServiceDate": 1685491200000,
    "dueOdometer": 4000,
    "suggestions": "Brake Oil, Calliper Pin"
  },
  {
    "lastServiceDate": 1686528000000,
    "lastOdometer": 4000,
    "worknotes": "Brake Oil, Brake Pads, Engine Tuneup",
    "dueServiceDate": 1699747200000,
    "dueOdometer": 5000,
    "suggestions": "Brake Oil, Calliper Pin"
  },
  {
    "lastServiceDate": 1699747200000,
    "lastOdometer": 5000,
    "worknotes": "Brake Oil, Brake Pads, Engine Tuneup",
    "dueServiceDate": 1710201600000,
    "dueOdometer": 6000,
    "suggestions": "Brake Oil, Calliper Pin"
  }
]
''';

/// Demo list of dummy instances of Service Logs from JSON string
final List<ServiceLog> jsonDemoListServiceLogs =
    parseServiceLogs(demoListServiceLogsJsonString);
