import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pitstop_service/model/service_log.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:provider/provider.dart';

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
  // late DateTime lastServiceDate;
  // late int lastOdometer;
  // late List<String> worknotes;
  late ServiceLog? _lastServiceLog;

  @override
  void initState() {
    // Initialize last service information
    _lastServiceLog = context.read<AppDataNotifier>().appData.lastServiceLog;
    // lastServiceDate = DateTime(2023, 1, 12);
    // lastOdometer = 600;
    // worknotes = 'Brake Oil,Calliper Pin'
    //     .split(',')
    //     .where((e) => e.trim().isNotEmpty)
    //     .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (_lastServiceLog != null)
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
                                  .format(_lastServiceLog!.lastServiceDate),
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
                              '${_lastServiceLog!.lastOdometer} kms',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  if (_lastServiceLog!.worknotes.isNotEmpty)
                    Text(
                      'Worknotes'.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  if (_lastServiceLog!.worknotes.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      children: _lastServiceLog!.worknotesList
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
