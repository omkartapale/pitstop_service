import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pitstop_service/model/service_log.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:provider/provider.dart';

/// Widget Class: Renders Due Service card for dashboard
class DueServiceCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // Get last service information
    final ServiceLog? lastServiceLog =
        context.watch<AppDataNotifier>().appData.lastServiceLog;

    return (lastServiceLog != null)
        ? Card(
            color: context.watch<AppDataNotifier>().appData.showServiceDueAlert
                ? Colors.red.shade100
                : Colors.yellow.shade100,
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
                      context
                              .watch<AppDataNotifier>()
                              .appData
                              .showServiceDueAlert
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
                              DateFormat("dd MMM ''yy")
                                  .format(lastServiceLog.dueServiceDate),
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
                              '${lastServiceLog.dueOdometer} kms',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  if (lastServiceLog.suggestionsList.isNotEmpty)
                    Text(
                      'Suggestions'.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  if (lastServiceLog.suggestionsList.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      children: lastServiceLog.suggestionsList
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
