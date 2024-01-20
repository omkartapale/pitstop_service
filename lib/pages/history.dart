import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pitstop_service/model/service_log.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ServiceLog> serviceHistory =
        context.watch<AppDataNotifier>().appData.serviceHistory;

    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 4.0, right: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Text(
              'Vehicle service log',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Expanded(
            child: Card(
              color: Colors.amber[50],
              shadowColor: Colors.transparent,
              clipBehavior: Clip.hardEdge,
              child: Container(
                padding: const EdgeInsets.only(top: 4.0),
                alignment: Alignment.center,
                child: (serviceHistory.isNotEmpty)
                    // Show list of service history records
                    ? ListView.separated(
                        itemCount: serviceHistory.length,
                        itemBuilder: (BuildContext context, int index) {
                          ServiceLog serviceLogItem = serviceHistory[index];
                          return ListTile(
                            isThreeLine: true,
                            title: Row(
                              children: [
                                const Icon(Icons.event_available),
                                const SizedBox(width: 8.0),
                                Text(DateFormat("dd MMM ''yy")
                                    .format(serviceLogItem.lastServiceDate)),
                                const SizedBox(width: 24.0),
                                const Icon(Icons.speed_outlined),
                                const SizedBox(width: 8.0),
                                Flexible(
                                    child: Text(
                                        '${serviceLogItem.lastOdometer} kms')),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4.0),
                                Text(
                                    'Next service advised on ${DateFormat("dd MMM ''yy").format(serviceLogItem.dueServiceDate)} or ${serviceLogItem.lastOdometer} kms'),
                              ],
                            ),
                            onTap: () => _showDetails(context, serviceLogItem),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const Divider(thickness: 1, height: 1),
                      )
                    // Show no service history records screen
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'No previous service history!',
                          ),
                        ],
                      ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
        ],
      ),
    );
  }

  Future<void> _showDetails(BuildContext context, ServiceLog serviceLog) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Service log details'),
        scrollable: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Serviced on',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Icon(Icons.event_available, size: 18.0),
                          const SizedBox(width: 4.0),
                          Text(DateFormat("dd MMM ''yy")
                              .format(serviceLog.lastServiceDate)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.speed_outlined, size: 18.0),
                          const SizedBox(width: 4.0),
                          Text('${serviceLog.lastOdometer} kms'),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      if (serviceLog.worknotesList.isNotEmpty)
                        const Row(
                          children: [
                            Icon(Icons.assignment_turned_in_outlined,
                                size: 18.0),
                            SizedBox(width: 4.0),
                            Text('Worknotes:'),
                          ],
                        ),
                      // Text(serviceLog.worknotes),
                      if (serviceLog.worknotesList.isNotEmpty)
                        Wrap(
                          spacing: 8.0,
                          children: serviceLog.worknotesList
                              .map(
                                (note) => Chip(
                                  visualDensity: VisualDensity.compact,
                                  padding: const EdgeInsets.all(0.0),
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                  label: Text(note.trim()),
                                ),
                              )
                              .toList(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Next Service Due',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Icon(Icons.event, size: 18.0),
                          const SizedBox(width: 4.0),
                          Text(DateFormat("dd MMM ''yy")
                              .format(serviceLog.dueServiceDate)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.speed_outlined, size: 18.0),
                          const SizedBox(width: 4.0),
                          Text('${serviceLog.dueOdometer} kms'),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      if (serviceLog.suggestionsList.isNotEmpty)
                        const Row(
                          children: [
                            Icon(Icons.assignment_outlined, size: 18.0),
                            SizedBox(width: 4.0),
                            Text('Suggestions:'),
                          ],
                        ),
                      // Text(serviceLog.suggestions),
                      if (serviceLog.suggestionsList.isNotEmpty)
                        Wrap(
                          spacing: 8.0,
                          children: serviceLog.suggestionsList
                              .map(
                                (note) => Chip(
                                  visualDensity: VisualDensity.compact,
                                  padding: const EdgeInsets.all(0.0),
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                  label: Text(note.trim()),
                                ),
                              )
                              .toList(),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
