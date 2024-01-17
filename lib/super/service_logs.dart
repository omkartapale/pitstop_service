import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pitstop_service/model/service_log.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:pitstop_service/super/emergency_contacts_form.dart';
import 'package:pitstop_service/super/vehicle_spec_form.dart';
import 'package:pitstop_service/super/widgets/service_log_form.dart';
import 'package:provider/provider.dart';

class SuperServiceLogs extends StatelessWidget {
  const SuperServiceLogs({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ServiceLog> serviceHistory =
        context.watch<AppDataNotifier>().appData.serviceHistory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('\$sudo'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const SuperVehicleSpecificationForm(),
                ),
              );
            },
            icon: const Icon(Icons.type_specimen),
          ),
          IconButton.filledTonal(
            onPressed: () {},
            icon: const Icon(Icons.warehouse),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const SuperEmergencyContactsForm(),
                ),
              );
            },
            icon: const Icon(Icons.emergency),
          ),
          IconButton(
            onPressed: () {
              // Navigator.popUntil(context, (route) => false);
              SystemNavigator.pop();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheetForm(context),
        child: const Icon(Icons.event_available),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                child: Text(
                  'Service Logs',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Card(
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
                                title: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Past Service',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 4.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Service Due',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                subtitle: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              const Icon(Icons.event_available,
                                                  size: 18.0),
                                              const SizedBox(width: 4.0),
                                              Text(DateFormat("dd MMM ''yy")
                                                  .format(serviceLogItem
                                                      .lastServiceDate)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.speed_outlined,
                                                  size: 18.0),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                  '${serviceLogItem.lastOdometer}km'),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          const Row(
                                            children: [
                                              Icon(
                                                  Icons
                                                      .assignment_turned_in_outlined,
                                                  size: 18.0),
                                              SizedBox(width: 4.0),
                                              Text('Worknotes:'),
                                            ],
                                          ),
                                          Text(serviceLogItem
                                                  .worknotes.isNotEmpty
                                              ? serviceLogItem.worknotes
                                              : 'NA'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 4.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              const Icon(Icons.event,
                                                  size: 18.0),
                                              const SizedBox(width: 4.0),
                                              Text(DateFormat("dd MMM ''yy")
                                                  .format(serviceLogItem
                                                      .dueServiceDate)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.speed_outlined,
                                                  size: 18.0),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                  '${serviceLogItem.dueOdometer}km'),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          const Row(
                                            children: [
                                              Icon(Icons.assignment_outlined,
                                                  size: 18.0),
                                              SizedBox(width: 4.0),
                                              Text('Suggestions:'),
                                            ],
                                          ),
                                          Text(serviceLogItem
                                                  .suggestions.isNotEmpty
                                              ? serviceLogItem.suggestions
                                              : 'NA'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                onLongPress: () => _confirmDelete(
                                    context, serviceLogItem, index),
                                onTap: () => _showBottomSheetForm(
                                    context, serviceLogItem, index),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(thickness: 1, height: 1),
                          )
                        // Show no service history records screen
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
      ),
    );
  }

  Future<void> _showBottomSheetForm(BuildContext context,
      [ServiceLog? serviceLog, int? index]) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: MediaQuery.of(context).viewInsets,
            child: ServiceLogForm(
              index: index,
              serviceLogItem: serviceLog,
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, ServiceLog serviceLog, int index) {
    final ThemeData theme = Theme.of(context);
    final TextStyle textStyle = theme.textTheme.bodyMedium!;
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete service log?'),
        content: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  style: textStyle,
                  text: 'Once you delete, you will not be able to retrieve '
                      'this in future. \n\nAre you sure to delete service '
                      'logged on ${DateFormat("dd MMM yyyy").format(serviceLog.lastServiceDate)} at ${serviceLog.lastOdometer}km?'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              // Delete and persist the Service Log
              context.read<AppDataNotifier>().deleteServiceLog(index);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                'Deleted service logged on ${DateFormat("dd MMM ''yy").format(serviceLog.lastServiceDate)} at ${serviceLog.lastOdometer}km.',
                textAlign: TextAlign.center,
              )));
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
