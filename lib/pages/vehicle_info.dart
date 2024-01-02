import 'package:flutter/material.dart';
import 'package:pitstop_service/widgets/vehicle_key_spec_card.dart';
import 'package:pitstop_service/widgets/vehicle_model_graphics.dart';
import 'package:pitstop_service/widgets/vehicle_spec_item.dart';
import 'package:pitstop_service/widgets/vehicle_vital_spec_card.dart';

class VehicleInfo extends StatelessWidget {
  const VehicleInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 4.0, right: 12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              child: Text(
                'Vehicle specifications',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            const SizedBox(height: 16.0),
            const VehicleModelGraphic(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),
                  child: Text('Ameo',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const Divider(
                  indent: 4.0,
                  endIndent: 4.0,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 8.0, right: 8.0, bottom: 24.0),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: VehicleSpecItem(
                          specHeading: 'Max Power',
                          specValue: '74bhp @ 5400rpm',
                        ),
                      ),
                      Expanded(
                        child: VehicleSpecItem(
                          specHeading: 'Cubic Capacity',
                          specValue: '1198cc',
                        ),
                      ),
                      Expanded(
                        child: VehicleSpecItem(
                          specHeading: 'Cylinders',
                          specValue: '3 Inline, SOHC',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const VehicleKeySpecCard(),
            const SizedBox(height: 8.0),
            const VehicleVitalSpecCard(),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}
