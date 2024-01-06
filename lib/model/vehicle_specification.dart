import 'dart:convert';

/// Fuel Types Enum
enum FuelType {
  /// Petrol Fuel
  petrol('Petrol'),

  /// Diesel Fuel
  diesel('Diesel'),

  /// CNG Fuel
  cng('CNG'),

  /// Petrol + CNG Fuel
  petrolcng('Petrol+CNG'),

  /// Electricity / Battery
  electric('Electric'),

  /// Hybrid / Regenerative Fuel
  hybrid('Hybrid'),

  /// Hydrogen Fuel
  hydrogen('Hydrogen'),

  /// Flex Fuel
  flex('Flex'),

  /// Ethanol Fuel
  ethanol('Ethanol'),

  /// Methanol Fuel
  methanol('Methanol'),

  /// LPG Fuel
  lpg('LPG'),

  /// Petrol + LPG Fuel
  petrollpg('Petrol+LPG');

  const FuelType(this.value);
  final String value;
}

/// Parse string to FuelType enum.
///
/// Convert string [value] to FuelType enum. Useful to parse string value from
/// stored json.
///
/// Searches for enum name matching with the [value] param and
/// return the first matching enum element, if no match found for named value
/// in enum then returns the first element of enum as default.
///
/// Example:
/// ``` dart
/// enum FuelType {petrol, diesel};
/// var FuelType fuel;
/// fuel = stringToFuelType('petrol');    // Returns FuelType.petrol
/// fuel = stringToFuelType('diesel');    // Returns FuelType.diesel
/// fuel = stringToFuelType('biodiesel'); // No-match: Returns FuelType.petrol
/// ```
///
/// Iterates through enum elements and returns the first element that satisfies
/// the given predicate [value]. If no element satisfies [value], the first
/// element of FuelType enum i.e. [FuelType.petrol] is returned.
FuelType stringToFuelType(String value) {
  return FuelType.values.firstWhere(
    // (element) => element.toString().split('.').last == value,
    (element) => element.name == value,
    orElse: () => FuelType.values.first,
  );
}

/// Transmission Types Enum
enum Transmission {
  /// Manual Transmission
  manual('Manual'),

  /// Automatic Transmission
  automatic('Automatic'),

  /// Clutchless Manual Transmission
  cutchlessmanual('Clutchless Manual');

  const Transmission(this.value);
  final String value;
}

/// Parse string to Transmission enum.
///
/// Convert string [value] to Transmission enum. Useful to parse string value
/// from stored json.
///
/// Searches for enum name matching with the [value] param and
/// return the first matching enum element, if no match found for named value
/// in enum then returns the first element of enum as default.
///
/// Example:
/// ``` dart
/// enum Transmission {manual, automatic};
/// var Transmission result;
/// result = stringToTransmission('manual');  // Returns Transmission.manual
/// result =
///   stringToTransmission('automatic');      // Returns Transmission.automatic
/// result =
///   stringToTransmission('sports');         // No-match: Returns Transmission.manual
/// ```
///
/// Iterates through enum elements and returns the first element that satisfies
/// the given predicate [value]. If no element satisfies [value], the first
/// element of Transmission enum i.e. [Transmission.manual] is returned.
Transmission stringToTransmission(String value) {
  return Transmission.values.firstWhere(
    // (element) => element.toString().split('.').last == value,
    (element) => element.name == value,
    orElse: () => Transmission.manual,
  );
}

/// **Vehicle Specification Model class**
///
/// Key Specifications
///
/// String [manufacturer],
/// String [model],
/// String [variant],
/// int [makeYear],
/// enum [transmission] as [Transmission],
/// enum [fuel] as [FuelType],
/// String [licensePlate].
///
/// Engine Specifications
///
/// String [maxPower],
/// String [capacity],
/// String [cylinder].
///
/// Vital Dates in milliseconds since Epoch
///
/// DateTime [fitnessValidUpto],
/// DateTime [insuranceValidUpto],
/// DateTime [pucValidUpto].
class VehicleSpecification {
  /// Creates an instance of [VehicleSpecification] model class.
  const VehicleSpecification({
    required this.manufacturer,
    required this.model,
    required this.variant,
    required this.makeYear,
    required this.transmission,
    required this.fuel,
    required this.licensePlate,
    required this.maxPower,
    required this.capacity,
    required this.cylinder,
    required this.fitnessValidUpto,
    required this.insuranceValidUpto,
    required this.pucValidUpto,
  });

  /// **Vehicle Key Specification**
  ///
  /// Vehicle's Manufacturer.
  final String manufacturer;

  /// **Vehicle Key Specification**
  ///
  /// Vehicle's Model.
  final String model;

  /// **Vehicle Key Specification**
  ///
  /// Vehicle's Variant or Trim.
  final String variant;

  /// **Vehicle Key Specification**
  ///
  /// Vehicle's Manufacturing year.
  final int makeYear;

  /// **Vehicle Key Specification**
  ///
  /// Vehicle's Engine Transmission. One of the [Transmission].
  final Transmission transmission;

  /// **Vehicle Key Specification**
  ///
  /// Vehicle's Fuel type. One of the [FuelType].
  final FuelType fuel;

  /// **Vehicle Key Specification**
  ///
  /// Vehicle's RTO license number.
  final String licensePlate;

  /// **Vehicle Engine Specification**
  ///
  /// Vehicle's Maximum power bhp@rpm for normal vehicles,
  /// for electric this can be bhp nm.
  final String maxPower;

  /// **Vehicle Engine Specification**
  ///
  /// Vehicle's Cubic Capacity (cc) for normal vehicles.
  /// For electric vehicles this can be Battery capacity (kWh) with maximum
  /// driving range (km).
  final String capacity;

  /// **Vehicle Engine Specification**
  ///
  /// Vehicle's Engine cylinder capacity with valves per cylinder.
  /// For EV it is Not Applicable (NA).
  final String cylinder;

  /// **Vehicle Vital Specification**
  ///
  /// Vehicle's fiteness expiry date in milliseconds since Epoch.
  final DateTime fitnessValidUpto;

  /// **Vehicle Vital Specification**
  ///
  /// Vehicle's insurance expiry date in milliseconds since Epoch.
  final DateTime insuranceValidUpto;

  /// **Vehicle Vital Specification**
  ///
  /// Vehicle's pollution check expiry date in milliseconds since Epoch.
  final DateTime pucValidUpto;

  /// Factory constructor for creating a new [VehicleSpecification] instance
  /// from a map.
  factory VehicleSpecification.fromJson(Map<String, dynamic> json) {
    return VehicleSpecification(
      manufacturer: json['manufacturer'],
      model: json['model'],
      variant: json['variant'],
      makeYear: json['makeYear'],
      transmission: stringToTransmission(json['transmission']),
      fuel: stringToFuelType(json['fuel']),
      licensePlate: json['licensePlate'],
      maxPower: json['maxPower'],
      capacity: json['capacity'],
      cylinder: json['cylinder'],
      fitnessValidUpto:
          DateTime.fromMillisecondsSinceEpoch(json['fitnessValidUpto']),
      insuranceValidUpto:
          DateTime.fromMillisecondsSinceEpoch(json['insuranceValidUpto']),
      pucValidUpto: DateTime.fromMillisecondsSinceEpoch(json['pucValidUpto']),
    );
  }

  /// Helper method to declare support for serialization to JSON.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['manufacturer'] = manufacturer;
    data['model'] = model;
    data['variant'] = variant;
    data['makeYear'] = makeYear;
    data['transmission'] = transmission.name;
    data['fuel'] = fuel.name;
    data['licensePlate'] = licensePlate;
    data['maxPower'] = maxPower;
    data['capacity'] = capacity;
    data['cylinder'] = cylinder;
    data['fitnessValidUpto'] = fitnessValidUpto.millisecondsSinceEpoch;
    data['insuranceValidUpto'] = insuranceValidUpto.millisecondsSinceEpoch;
    data['pucValidUpto'] = pucValidUpto.millisecondsSinceEpoch;
    return data;
  }
}

/// Demo instance of [VehicleSpecification] class.
final VehicleSpecification demoVehicleSpec = VehicleSpecification(
  manufacturer: 'Volkswagen',
  model: 'Ameo',
  variant: '1.2L MPI Highline',
  makeYear: 2016,
  transmission: Transmission.manual,
  fuel: FuelType.petrol,
  licensePlate: 'MH11 BV 8183',
  maxPower: '74bhp @ 5400rpm',
  capacity: '1198cc',
  cylinder: '3 Inline, SOHC',
  fitnessValidUpto: DateTime.fromMillisecondsSinceEpoch(1949941800000),
  insuranceValidUpto: DateTime.fromMillisecondsSinceEpoch(1729103400000),
  pucValidUpto: DateTime.fromMillisecondsSinceEpoch(1702751400000),
);

/// Demo JSON string representing instance of [VehicleSpecification] class.
const demoVehicleSpecJsonString = '''
{
  "manufacturer": "Volkswagen",
  "model": "Ameo",
  "variant": "1.2L MPI Highline",
  "makeYear": 2016,
  "transmission": "manual",
  "fuel": "petrol",
  "licensePlate": "MH11 BV 8183",
  "maxPower": "74bhp @ 5400rpm",
  "capacity": "1198cc",
  "cylinder": "3 Inline, SOHC",
  "fitnessValidUpto": 1949941800000,
  "insuranceValidUpto": 1729103400000,
  "pucValidUpto": 1702751400000
}
''';

/// Demo instance from JSON string
///
/// Deserialize JSON string [demoVehicleSpecJsonString], parse and create
/// demo instance of [VehicleSpecification] class.
final VehicleSpecification jsonDemoVehicleSpec =
    VehicleSpecification.fromJson(json.decode(demoVehicleSpecJsonString));
