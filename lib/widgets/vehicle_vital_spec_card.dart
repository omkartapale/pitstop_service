import 'package:flutter/material.dart';
import 'package:pitstop_service/widgets/vehicle_vital_spec_item.dart';

/// Widget Class: Renders vehicle's vital information card
class VehicleVitalSpecCard extends StatefulWidget {
  /// Vehicle's Key Specification card widget
  ///
  /// Renders Card UI to provides vehicle's vitals like vehicle's fitness valid
  /// upto date, insurance valid upto date, pollution check valid upto date.
  ///
  /// The buttons next to these details enable user to update these details.
  /// The status of these details is marked to alert if dates are less than or
  /// equal to 30 days close from today or already passed.
  const VehicleVitalSpecCard({super.key});

  @override
  State<VehicleVitalSpecCard> createState() => _VehicleVitalSpecCardState();
}

class _VehicleVitalSpecCardState extends State<VehicleVitalSpecCard> {
  late DateTime fitnessExpiry, insuranceExpiry, pucExpiry;

  @override
  void initState() {
    // initiate vital dates for vehicle
    fitnessExpiry = DateTime.fromMillisecondsSinceEpoch(1949941800000);
    insuranceExpiry = DateTime.fromMillisecondsSinceEpoch(1729103400000);
    pucExpiry = DateTime.fromMillisecondsSinceEpoch(1702751400000);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple.shade100,
      shadowColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(
            left: 16.0, top: 16.0, right: 8.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vital Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            if (MediaQuery.of(context).size.width < 600)
              Column(
                children: [
                  VehicleVitalSpecItem(
                    specHeading: 'Vehicle Fitness',
                    specDate: fitnessExpiry,
                    isAlert: _isFitnessNearExpiry,
                    onUpdate: () => _updateRC(context),
                  ),
                  const SizedBox(height: 8.0),
                  VehicleVitalSpecItem(
                    specHeading: 'Insurance',
                    specDate: insuranceExpiry,
                    isAlert: _isInsuranceNearExpiry,
                    onUpdate: () => _updateInsurance(context),
                  ),
                  const SizedBox(height: 8.0),
                  VehicleVitalSpecItem(
                    specHeading: 'Pollution Check',
                    specDate: pucExpiry,
                    isAlert: _isPucNearExpiry,
                    onUpdate: () => _updatePUC(context),
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: VehicleVitalSpecItem(
                      specHeading: 'Vehicle Fitness',
                      specDate: fitnessExpiry,
                      isAlert: _isFitnessNearExpiry,
                      onUpdate: () => _updateRC(context),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: VehicleVitalSpecItem(
                      specHeading: 'Insurance',
                      specDate: insuranceExpiry,
                      isAlert: _isInsuranceNearExpiry,
                      onUpdate: () => _updateInsurance(context),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: VehicleVitalSpecItem(
                      specHeading: 'Pollution Check',
                      specDate: pucExpiry,
                      isAlert: _isPucNearExpiry,
                      onUpdate: () => _updatePUC(context),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  /// Vehicle RC Fitness Validity Date update dialog
  ///
  /// Shows a Date Picker
  ///
  /// Once a new date is selected / provided, vehicle fitness date is updated
  /// and check for [_isFitnessNearExpiry] to set status for new date.
  Future<void> _updateRC(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      // firstDate: DateTime(2016, 10, 17), // registration date or todays date can be good too
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: fitnessExpiry, // current expiry date
      helpText: 'Vehicle Fitness',
      confirmText: 'Update Fitness',
      fieldLabelText: 'Valid upto',
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          fitnessExpiry = pickedDate;
        });
      }
    });
  }

  /// Vehicle Insurance Expiry Date update dialog
  ///
  /// Shows a Date Picker
  ///
  /// Once a new date is selected / provided, vehicle insurance expiry date
  /// is updated and check for [_isInsuranceNearExpiry] to set status for
  /// new date.
  Future<void> _updateInsurance(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      // firstDate: insuranceExpiry, // current expiry date
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: insuranceExpiry, // current expiry date
      helpText: 'Insurance',
      confirmText: 'Update Insurance',
      fieldLabelText: 'Valid upto',
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          insuranceExpiry = pickedDate;
        });
      }
    });
  }

  /// Vehicle Pollution Check Validity Date update dialog
  ///
  /// Shows a Date Picker
  ///
  /// Once a new date is selected / provided, vehicle PUC expiry date is
  /// updated and check for [_isPucNearExpiry] to set status for new date.
  Future<void> _updatePUC(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: pucExpiry, // current expiry date
      helpText: 'Pollution Check',
      confirmText: 'Update PUC',
      fieldLabelText: 'Valid upto',
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          pucExpiry = pickedDate;
        });
      }
    });
  }

  /// Checks if the vehicle fitness is less than or equal to 30 days
  /// close to expiry or expired already.
  bool get _isFitnessNearExpiry {
    return fitnessExpiry.difference(DateTime.now()).inDays <= 30;
  }

  /// Checks if the vehicle insurance is less than or equal to 30 days
  /// close to expiry or expired already.
  bool get _isInsuranceNearExpiry {
    return insuranceExpiry.difference(DateTime.now()).inDays <= 30;
  }

  /// Checks if the vehicle pollution check is less than or equal to 30 days
  /// close to expiry or expired already.
  bool get _isPucNearExpiry {
    return pucExpiry.difference(DateTime.now()).inDays <= 30;
  }
}
