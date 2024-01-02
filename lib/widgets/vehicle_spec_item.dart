import 'package:flutter/material.dart';

/// Widget Class: Renders vehicle's key specification item
class VehicleSpecItem extends StatelessWidget {
  /// Vehicle's Key Specification item widget
  ///
  /// Renders UI to provides vehicle's spec details. Basically [specHeading]
  /// and [specValue] displayed in in Column widget.
  const VehicleSpecItem(
      {super.key, required this.specHeading, required this.specValue});

  /// Specification Heading String.
  final String specHeading;

  /// Specification Value String.
  final String specValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          specHeading.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Text(
          specValue,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
