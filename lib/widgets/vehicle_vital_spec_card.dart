import 'package:flutter/material.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:pitstop_service/widgets/vehicle_vital_spec_item.dart';
import 'package:provider/provider.dart';

/// Widget Class: Renders vehicle's vital information card
class VehicleVitalSpecCard extends StatelessWidget {
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
                    specDate: context
                        .watch<AppDataNotifier>()
                        .appData
                        .vehicleSpec
                        .fitnessValidUpto,
                    isAlert: context
                        .watch<AppDataNotifier>()
                        .appData
                        .showFitnessDueAlert,
                    onUpdate: () => _updateRC(context),
                  ),
                  const SizedBox(height: 8.0),
                  VehicleVitalSpecItem(
                    specHeading: 'Insurance',
                    specDate: context
                        .watch<AppDataNotifier>()
                        .appData
                        .vehicleSpec
                        .insuranceValidUpto,
                    isAlert: context
                        .watch<AppDataNotifier>()
                        .appData
                        .showInsuranceDueAlert,
                    onUpdate: () => _updateInsurance(context),
                  ),
                  const SizedBox(height: 8.0),
                  VehicleVitalSpecItem(
                    specHeading: 'Pollution Check',
                    specDate: context
                        .watch<AppDataNotifier>()
                        .appData
                        .vehicleSpec
                        .pucValidUpto,
                    isAlert: context
                        .watch<AppDataNotifier>()
                        .appData
                        .showPollutionCheckDueAlert,
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
                      specDate: context
                          .watch<AppDataNotifier>()
                          .appData
                          .vehicleSpec
                          .fitnessValidUpto,
                      isAlert: context
                          .watch<AppDataNotifier>()
                          .appData
                          .showFitnessDueAlert,
                      onUpdate: () => _updateRC(context),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: VehicleVitalSpecItem(
                      specHeading: 'Insurance',
                      specDate: context
                          .watch<AppDataNotifier>()
                          .appData
                          .vehicleSpec
                          .insuranceValidUpto,
                      isAlert: context
                          .watch<AppDataNotifier>()
                          .appData
                          .showInsuranceDueAlert,
                      onUpdate: () => _updateInsurance(context),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: VehicleVitalSpecItem(
                      specHeading: 'Pollution Check',
                      specDate: context
                          .watch<AppDataNotifier>()
                          .appData
                          .vehicleSpec
                          .pucValidUpto,
                      isAlert: context
                          .watch<AppDataNotifier>()
                          .appData
                          .showPollutionCheckDueAlert,
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
  /// and check for Fitness validity status to set alert for new date.
  Future<void> _updateRC(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      // firstDate: DateTime(2016, 10, 17), // registration date or todays date can be good too
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: context
          .read<AppDataNotifier>()
          .appData
          .vehicleSpec
          .fitnessValidUpto, // current expiry date
      helpText: 'Vehicle Fitness',
      confirmText: 'Update Fitness',
      fieldLabelText: 'Valid upto',
    ).then((pickedDate) {
      if (pickedDate != null) {
        context.read<AppDataNotifier>().updateFitnessDate(pickedDate);
      }
    });
  }

  /// Vehicle Insurance Expiry Date update dialog
  ///
  /// Shows a Date Picker
  ///
  /// Once a new date is selected / provided, vehicle insurance expiry date
  /// is updated and check for Insurance validity status to set alert for
  /// new date.
  Future<void> _updateInsurance(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      // firstDate: insuranceExpiry, // current expiry date
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: context
          .read<AppDataNotifier>()
          .appData
          .vehicleSpec
          .insuranceValidUpto, // current expiry date
      helpText: 'Insurance',
      confirmText: 'Update Insurance',
      fieldLabelText: 'Valid upto',
    ).then((pickedDate) {
      if (pickedDate != null) {
        context.read<AppDataNotifier>().updateInsuranceDate(pickedDate);
      }
    });
  }

  /// Vehicle Pollution Check Validity Date update dialog
  ///
  /// Shows a Date Picker
  ///
  /// Once a new date is selected / provided, vehicle PUC expiry date is
  /// updated and check for Pollution Check validity status to set alert for
  /// new date.
  Future<void> _updatePUC(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: context
          .read<AppDataNotifier>()
          .appData
          .vehicleSpec
          .pucValidUpto, // current expiry date
      helpText: 'Pollution Check',
      confirmText: 'Update PUC',
      fieldLabelText: 'Valid upto',
    ).then((pickedDate) {
      if (pickedDate != null) {
        context.read<AppDataNotifier>().updatePucDate(pickedDate);
      }
    });
  }
}
