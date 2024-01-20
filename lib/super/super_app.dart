import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pitstop_service/super/emergency_contacts_form.dart';
import 'package:pitstop_service/super/service_logs.dart';
import 'package:pitstop_service/super/vehicle_spec_form.dart';

class SuperApp extends StatelessWidget {
  const SuperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.terminal),
        ),
        title: const Text('\$sudo'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.popUntil(context, (route) => false);
              SystemNavigator.pop();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                child: Text(
                  'Vehicle Onboarding',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Card(
                shadowColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Specifications',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Setup / Update vehicle\'s spec',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Key Information\nEngine Specification\nVehicle Vitals',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),
                      IconButton.filled(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const SuperVehicleSpecificationForm(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                shadowColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Service Logs',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Manage vehicle\'s service history',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Last Service Worknotes\nNext Service Suggestions',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),
                      IconButton.filled(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const SuperServiceLogs(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                shadowColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Emergency Help',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Manage Emergency Contacts',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Primary and Secondary contact information',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),
                      IconButton.filled(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const SuperEmergencyContactsForm(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
            ]),
          ),
        ),
      ),
    );
  }
}
