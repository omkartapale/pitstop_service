import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget Class: Renders Due Service card for dashboard
class DueServiceCard extends StatefulWidget {
  /// Connect with us widget
  ///
  /// Renders Card UI to provides vehicle's next servicing due details like next
  /// service date, odometer reading and suggestion to work on in the next
  /// service.
  ///
  /// This card observes suggested service due date and if due date is less than
  /// or equal to 30 days from today or already passed then the card status
  /// changes to alert.
  const DueServiceCard({super.key});

  @override
  State<DueServiceCard> createState() => _DueServiceCardState();
}

class _DueServiceCardState extends State<DueServiceCard> {
  late DateTime dueServiceDate;
  late int dueOdometer;
  late List<String> suggestions;

  @override
  void initState() {
    // initialize
    dueServiceDate = DateTime(2024, 1, 24);
    dueOdometer = 1600;
    suggestions = 'Gear Oil,Throttle Cleanup'
        .split(',')
        .where((e) => e.trim().isNotEmpty)
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _isServiceDueNear ? Colors.red.shade100 : Colors.yellow.shade100,
      shadowColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Due Service',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 8.0),
                _isServiceDueNear
                    ? const Icon(
                        Icons.error_outline_rounded,
                        color: Colors.deepOrange,
                      )
                    : Container(),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Service Date'.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        DateFormat("dd MMM ''yy").format(dueServiceDate),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Odometer Reading'.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        '$dueOdometer kms',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (suggestions.isNotEmpty)
              Text(
                'Suggestions'.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            if (suggestions.isNotEmpty)
              Wrap(
                spacing: 8.0,
                children: suggestions
                    .map(
                      (note) => Chip(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.all(0.0),
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        label: Text(note.trim()),
                      ),
                    )
                    .toList(),
              )
          ],
        ),
      ),
    );
  }

  /// Checks if the vehicle service is due for less than or equal to 30 days
  /// from today or already passed.
  bool get _isServiceDueNear {
    return dueServiceDate.difference(DateTime.now()).inDays <= 30;
  }
}
