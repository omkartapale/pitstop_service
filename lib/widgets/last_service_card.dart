import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget Class: Renders Last Service card for dashboard
class LastServiceCard extends StatefulWidget {
  /// Last service card widget
  ///
  /// Renders Card UI to provides vehicle's last servicing details like last
  /// service date, odometer reading and worknotes about the last service.
  const LastServiceCard({super.key});

  @override
  State<LastServiceCard> createState() => _LastServiceCardState();
}

class _LastServiceCardState extends State<LastServiceCard> {
  late DateTime lastServiceDate;
  late int lastOdometer;
  late List<String> worknotes;

  @override
  void initState() {
    // initialize last service data
    lastServiceDate = DateTime(2023, 1, 12);
    lastOdometer = 600;
    worknotes = 'Brake Oil,Calliper Pin'
        .split(',')
        .where((e) => e.trim().isNotEmpty)
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow.shade100,
      shadowColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Service',
              style: Theme.of(context).textTheme.titleLarge,
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
                        DateFormat("dd MMM ''yy").format(lastServiceDate),
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
                        '$lastOdometer kms',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (worknotes.isNotEmpty)
              Text(
                'Worknotes'.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            if (worknotes.isNotEmpty)
              Wrap(
                spacing: 8.0,
                children: worknotes
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
}
