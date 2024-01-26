import 'dart:convert';

import 'package:pitstop_service/model/emergency_contact.dart';
import 'package:pitstop_service/model/service_log.dart';
import 'package:pitstop_service/model/vehicle_specification.dart';

/// **Application Data Model class**
///
/// Application data structure to store and load data from the storage.
///
/// VehicleSpecification [vehicleSpec];
/// List<ServiceLog> [serviceHistory];
/// EmergencyContact [primaryContact];
/// EmergencyContact [secondaryContact];
/// int [version].
class AppData {
  /// Creates an [AppData] instance.
  const AppData({
    required this.vehicleSpec,
    required this.serviceHistory,
    required this.primaryContact,
    required this.secondaryContact,
    required this.version,
  });

  /// Vehicle specification data.
  final VehicleSpecification vehicleSpec;

  /// List of service logs.
  final List<ServiceLog> serviceHistory;

  /// Primary emergency contact data.
  final EmergencyContact primaryContact;

  /// Secondary emergency contact data.
  final EmergencyContact secondaryContact;

  /// Version information of App Data Store
  ///
  /// This can be used to detect and migrate old data, if anything updated to
  /// AppData model, after updating app in future.
  final int version;

  /// Get last vehicle service information.
  ///
  /// Returns most recent service details from vehicle's service history,
  /// or null if the history is empty.
  ServiceLog? get lastServiceLog => serviceHistory.firstOrNull;

  /// Get vehicle service due alert status.
  ///
  /// Checks if last service log is not null and the vehicle service is due for
  /// less than or equal to 30 days from today or already passed and returns
  /// true, else returns false.
  bool get showServiceDueAlert {
    if (lastServiceLog != null) {
      return lastServiceLog!.dueServiceDate.difference(DateTime.now()).inDays <=
          30;
    }
    return false;
  }

  /// Get vehicle's vitals due alert status.
  ///
  /// Checks if any of vehicle's vital dates (fitness, insurance and pollution
  /// check) are due for alert and return true or false.
  bool get showVitalsAlert {
    return showFitnessDueAlert ||
        showInsuranceDueAlert ||
        showPollutionCheckDueAlert;
  }

  /// Get vehicle's fitness validity due alert status.
  ///
  /// Checks if the vehicle's fitness is due for less than or equal to 30 days
  /// close to expiry or expired already then returns true, else returns false.
  bool get showFitnessDueAlert {
    return vehicleSpec.fitnessValidUpto.difference(DateTime.now()).inDays <= 30;
  }

  /// Get vehicle's insurance validity due alert status.
  ///
  /// Checks if the vehicle's insurance is due for less than or equal to 30 days
  /// close to expiry or expired already then returns true, else returns false.
  bool get showInsuranceDueAlert {
    return vehicleSpec.insuranceValidUpto.difference(DateTime.now()).inDays <=
        30;
  }

  /// Get vehicle's PUC validity due alert status.
  ///
  /// Checks if the vehicle's pollution check is due for less than or equal to
  /// 30 days close to expiry or expired already then returns true,
  /// else returns false.
  bool get showPollutionCheckDueAlert {
    return vehicleSpec.pucValidUpto.difference(DateTime.now()).inDays <= 30;
  }

  /// Add a new service log to the Service History.
  ///
  /// Inserts [serviceLog] at the beginning of the [serviceHistory] list.
  void addServiceLog(ServiceLog serviceLog) {
    // Insert at beginning of list
    serviceHistory.insert(0, serviceLog);
  }

  /// Update the existing service log.
  ///
  /// Removes the existing service log at [index], and inserts new [serviceLog]
  /// at the same position.
  void updateServiceLog(int index, ServiceLog serviceLog) {
    serviceHistory.removeAt(index);
    serviceHistory.insert(index, serviceLog);
  }

  /// Delete the service log.
  ///
  /// Removes the service log at position [index] from [serviceHistory].
  void deleteServiceLog(int index) {
    serviceHistory.removeAt(index);
  }

  /// Factory constructor for creating a new [AppData] instance
  /// from a map.
  factory AppData.fromJson(Map<String, dynamic> json) {
    return AppData(
      vehicleSpec: VehicleSpecification.fromJson(json['vehicleSpec']),
      serviceHistory: json['serviceHistory']
          // map each history to a Service Log object and return list,
          // if no element in map return empty list
          .map<ServiceLog>((serviceLog) => ServiceLog.fromJson(serviceLog))
          .toList(), // map() returns an Iterable so we convert it to a List
      primaryContact: EmergencyContact.fromJson(json['primaryContact']),
      secondaryContact: EmergencyContact.fromJson(json['secondaryContact']),
      version: json['version'],
    );
  }

  /// Helper method to declare support for serialization to JSON.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicleSpec'] = vehicleSpec.toJson();
    data['serviceHistory'] =
        serviceHistory.map((serviceLog) => serviceLog.toJson()).toList();
    data['primaryContact'] = primaryContact.toJson();
    data['secondaryContact'] = secondaryContact.toJson();
    data['version'] = version;
    return data;
  }
}

/// Demo JSON string representing [AppData] instance.
const demoAppDataJsonString = '''
{
  "vehicleSpec": {
    "manufacturer": "Make",
    "model": "Car",
    "variant": "1.2L MPI Highline",
    "makeYear": 2016,
    "transmission": "manual",
    "fuel": "petrol",
    "licensePlate": "MH11 A 1010",
    "maxPower": "74bhp @ 5400rpm",
    "capacity": "1198cc",
    "cylinder": "3 Inline, 12 Valves, SOHC",
    "fitnessValidUpto": 1949941800000,
    "insuranceValidUpto": 1729103400000,
    "pucValidUpto": 1702751400000
  },
  "serviceHistory": [],
  "primaryContact": {
    "name": "Primary Person",
    "relation": "relative",
    "number": "9876543210"
  },
  "secondaryContact": {
    "name": "Secondary Person",
    "relation": "friend",
    "number": "9876543211"
  },
  "version": 1
}
''';

/// Demo [AppData] instance from JSON string
///
/// Deserialize JSON string [demoAppDataJsonString], parse and create
/// demo instance of [AppData] class.
final AppData jsonDemoAppData =
    AppData.fromJson(json.decode(demoAppDataJsonString));
