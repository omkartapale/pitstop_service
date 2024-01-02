import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget Class: Renders vehicle's vital specification item
class VehicleVitalSpecItem extends StatelessWidget {
  /// Vehicle's Vital Specification item widget
  ///
  /// Renders UI to provides vehicle's spec details.
  /// Basically [specHeading] and [specValue] displayed in in Column widget.
  ///
  /// [isAlert] is used to decide whether show alert status.
  ///
  /// The update button is only displayed if [onUpdate] a void callback function
  /// is supplied and callback executed on button press.
  const VehicleVitalSpecItem(
      {super.key,
      required this.specHeading,
      required this.specDate,
      required this.isAlert,
      this.onUpdate});

  /// Specification Heading String.
  final String specHeading;

  /// Specification Validation upto date.
  final DateTime specDate;

  /// Boolean to decide if alert status should be set.
  final bool isAlert;

  /// Callback function to call on update button is clicked.
  final VoidCallback? onUpdate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              specHeading.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Row(
              children: [
                Text(
                  DateFormat("dd MMM ''yy").format(specDate),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: 8.0),
                isAlert
                    ? const Icon(
                        Icons.error_outline_rounded,
                        color: Colors.deepOrange,
                      )
                    : const Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.green,
                      ),
              ],
            ),
          ],
        ),
        const Spacer(),
        if (onUpdate != null)
          IconButton(
            iconSize: 16,
            padding: const EdgeInsets.all(0),
            visualDensity: VisualDensity.compact,
            onPressed: onUpdate,
            icon: const Icon(Icons.edit_calendar_outlined),
          ),
      ],
    );
  }
}
