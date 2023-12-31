import 'package:flutter/material.dart';

/// Widget Class: Renders vehicle registration box for dashboard
class VehicleRegistrationInfoBox extends StatelessWidget {
  /// Vehicle registration info widget
  ///
  /// Renders SizedBox UI to provides vehicle's registration info like
  /// manufacturer, model and licensed/registered number plate.
  const VehicleRegistrationInfoBox({
    super.key,
    required this.manufacturer,
    required this.model,
    required this.registrationNumber,
  });

  final String manufacturer;
  final String model;
  final String registrationNumber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(manufacturer.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall),
          Text(model, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16.0),
          Chip(
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.all(0.0),
            side: const BorderSide(width: 2.0),
            labelStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            label: Text(registrationNumber),
            avatar: Image.asset(
              'assets/number_plate_ind_logo.webp',
              // fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
