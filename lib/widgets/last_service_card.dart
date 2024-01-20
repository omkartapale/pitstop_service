import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pitstop_service/model/service_log.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:provider/provider.dart';

/// Widget Class: Renders Last Service card for dashboard
class LastServiceCard extends StatelessWidget {
  /// Last service card widget
  ///
  /// Renders Card UI to provides vehicle's last servicing details like last
  /// service date, odometer reading and worknotes about the last service.
  const LastServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Get last service information
    final ServiceLog? lastServiceLog =
        context.watch<AppDataNotifier>().appData.lastServiceLog;

    return (lastServiceLog != null)
        ? Card(
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
                              DateFormat("dd MMM ''yy")
                                  .format(lastServiceLog.lastServiceDate),
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
                              '${lastServiceLog.lastOdometer} kms',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  if (lastServiceLog.worknotes.isNotEmpty)
                    Text(
                      'Worknotes'.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  if (lastServiceLog.worknotes.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      children: lastServiceLog.worknotesList
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
          )
        : Container();
  }
}
