import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pitstop_service/model/service_log.dart';
import 'package:pitstop_service/super/emergency_contacts_form.dart';
import 'package:pitstop_service/super/vehicle_spec_form.dart';
import 'package:pitstop_service/super/widgets/service_log_form.dart';

class SuperServiceLogs extends StatefulWidget {
  const SuperServiceLogs({super.key});

  @override
  State<SuperServiceLogs> createState() => _SuperServiceLogsState();
}

class _SuperServiceLogsState extends State<SuperServiceLogs> {
  late List<ServiceLog> serviceHistory;

  @override
  void initState() {
    // Initialize history list of service logs
    // serviceHistory = [];
    // serviceHistory = demoListServiceLogs.reversed.toList();
    serviceHistory = jsonDemoListServiceLogs.reversed.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName('/'),
            );
          },
          icon: const Icon(Icons.terminal),
        ),
        title: const Text('\$sudo'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const SuperVehicleSpecificationForm(),
                ),
                ModalRoute.withName('/'),
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const SuperEmergencyContactsForm(),
                ),
                ModalRoute.withName('/'),
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
                    // Show list of service history records
                    child: (serviceHistory.isNotEmpty)
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
                                          Text(serviceLogItem.worknotes),
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
                                          Text(serviceLogItem.suggestions),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                onLongPress: () =>
                                    _confirmDelete(context, serviceLogItem),
                                onTap: () => _showBottomSheetForm(
                                    context, serviceLogItem),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(thickness: 1, height: 1),
                          )
                        :
                        // Show no service history records screen
                        const Column(
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
      [ServiceLog? serviceLog]) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: MediaQuery.of(context).viewInsets,
            child: ServiceLogForm(
              serviceLogItem: serviceLog,
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context, ServiceLog serviceLog) {
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
