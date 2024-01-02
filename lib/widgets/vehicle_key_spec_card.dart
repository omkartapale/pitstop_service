import 'package:flutter/material.dart';
import 'package:pitstop_service/widgets/vehicle_spec_item.dart';

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
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VehicleSpecItem(
                    specHeading: 'Manufacturer',
                    specValue: 'Volkswagen',
                  ),
                  SizedBox(height: 8.0),
                  VehicleSpecItem(
                    specHeading: 'Model',
                    specValue: 'Ameo',
                  ),
                  SizedBox(height: 8.0),
                  VehicleSpecItem(
                    specHeading: 'Variant / Trim',
                    specValue: '1.2L MPI Highline Plus',
                  ),
                ],
              )
            else
              const Row(
                children: [
                  Expanded(
                    child: VehicleSpecItem(
                      specHeading: 'Manufacturer',
                      specValue: 'Volkswagen',
                    ),
                  ),
                  Expanded(
                    child: VehicleSpecItem(
                      specHeading: 'Model',
                      specValue: 'Ameo',
                    ),
                  ),
                  Expanded(
                    child: VehicleSpecItem(
                      specHeading: 'Variant / Trim',
                      specValue: '1.2L MPI Highline Plus',
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 8.0),
            if (MediaQuery.of(context).size.width < 600)
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VehicleSpecItem(
                    specHeading: 'Make Year',
                    specValue: '2016',
                  ),
                  SizedBox(height: 8.0),
                  VehicleSpecItem(
                    specHeading: 'Trasmission',
                    specValue: 'Manual',
                  ),
                  SizedBox(height: 8.0),
                  VehicleSpecItem(
                    specHeading: 'Fuel',
                    specValue: 'Petrol',
                  ),
                ],
              )
            else
              const Row(
                children: [
                  Expanded(
                    child: VehicleSpecItem(
                      specHeading: 'Make Year',
                      specValue: '2016',
                    ),
                  ),
                  Expanded(
                    child: VehicleSpecItem(
                      specHeading: 'Trasmission',
                      specValue: 'Manual',
                    ),
                  ),
                  Expanded(
                    child: VehicleSpecItem(
                      specHeading: 'Fuel',
                      specValue: 'Petrol',
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
