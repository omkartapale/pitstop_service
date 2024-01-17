import 'package:flutter/material.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:pitstop_service/widgets/vehicle_spec_item.dart';
import 'package:provider/provider.dart';

/// Widget Class: Renders vehicle's key specification card
class VehicleKeySpecCard extends StatelessWidget {
  /// Vehicle's Key Specification card widget
  ///
  /// Renders Card UI to provide vehicle's manufacturer, model, variant/trim,
  /// make year, transmission and fuel type.
  const VehicleKeySpecCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Key Specification',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            if (MediaQuery.of(context).size.width < 600)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VehicleSpecItem(
                    specHeading: 'Manufacturer',
                    specValue: context
                        .watch<AppDataNotifier>()
                        .appData
                        .vehicleSpec
                        .manufacturer,
                  ),
                  const SizedBox(height: 8.0),
                  VehicleSpecItem(
                    specHeading: 'Model',
                    specValue: context
                        .watch<AppDataNotifier>()
                        .appData
                        .vehicleSpec
                        .model,
                  ),
                  const SizedBox(height: 8.0),
                  VehicleSpecItem(
                    specHeading: 'Variant / Trim',
                    specValue: context
                        .watch<AppDataNotifier>()
                        .appData
                        .vehicleSpec
                        .variant,
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: VehicleSpecItem(
                      specHeading: 'Manufacturer',
                      specValue: context
                          .watch<AppDataNotifier>()
                          .appData
                          .vehicleSpec
                          .manufacturer,
                    ),
                  ),
                  Expanded(
                    child: VehicleSpecItem(
                      specHeading: 'Model',
                      specValue: context
                          .watch<AppDataNotifier>()
                          .appData
                          .vehicleSpec
                          .model,
                    ),
                  ),
                  Expanded(
                    child: VehicleSpecItem(
                      specHeading: 'Variant / Trim',
                      specValue: context
                          .watch<AppDataNotifier>()
                          .appData
                          .vehicleSpec
                          .variant,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 8.0),
            if (MediaQuery.of(context).size.width < 600)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VehicleSpecItem(
                    specHeading: 'Make Year',
                    specValue: context
                        .watch<AppDataNotifier>()
                        .appData
                        .vehicleSpec
                        .makeYear
                        .toString(),
                  ),
                  const SizedBox(height: 8.0),
                  VehicleSpecItem(
                    specHeading: 'Trasmission',
                    specValue: context
                        .watch<AppDataNotifier>()
                        .appData
                        .vehicleSpec
                        .transmission
                        .value,
                  ),
                  const SizedBox(height: 8.0),
                  VehicleSpecItem(
                    specHeading: 'Fuel',
                    specValue: context
                        .watch<AppDataNotifier>()
                        .appData
                        .vehicleSpec
                        .fuel
                        .value,
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: VehicleSpecItem(
                      specHeading: 'Make Year',
                      specValue: context
                          .watch<AppDataNotifier>()
                          .appData
                          .vehicleSpec
                          .makeYear
                          .toString(),
                    ),
                  ),
                  Expanded(
                    child: VehicleSpecItem(
                      specHeading: 'Trasmission',
                      specValue: context
                          .watch<AppDataNotifier>()
                          .appData
                          .vehicleSpec
                          .transmission
                          .value,
                    ),
                  ),
                  Expanded(
                    child: VehicleSpecItem(
                      specHeading: 'Fuel',
                      specValue: context
                          .watch<AppDataNotifier>()
                          .appData
                          .vehicleSpec
                          .fuel
                          .value,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
