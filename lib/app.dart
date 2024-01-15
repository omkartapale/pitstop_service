import 'package:flutter/material.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:pitstop_service/pages/about.dart';
import 'package:pitstop_service/pages/contact.dart';
import 'package:pitstop_service/pages/history.dart';
import 'package:pitstop_service/pages/last_service.dart';
import 'package:pitstop_service/pages/vehicle_info.dart';
import 'package:provider/provider.dart';

class ServiceApp extends StatefulWidget {
  const ServiceApp({super.key});

  @override
  State<ServiceApp> createState() => _ServiceAppState();
}

class _ServiceAppState extends State<ServiceApp> {
  // The contents of views
  // Only the content associated with the selected tab is displayed on the screen
  final List<Widget> _mainContents = [
    // Content for Home tab
    const LastService(),

    // Content for Vehicle Information tab
    const VehicleInfo(),

    // Content for Contact tab
    const Contact(),

    // Content for History tab
    const History(),

    //Content for About tab
    const About()
  ];

  // The index of the selected tab
  // In the beginning, the Home tab is selected
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.published_with_changes),
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        ),
        leadingWidth: 80,
        title: const Text('KD\'s Pitstop Service'),
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            NavigationRail(
              // leading: Column(
              //   children: [
              //     IconButton(
              //         icon: const Icon(Icons.published_with_changes),
              //         onPressed: () {}),
              //     const SizedBox(height: 8.0),
              //   ],
              // ),
              // leading:
              //     IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
              // trailing: FloatingActionButton(
              //   elevation: 0,
              //   onPressed: () {
              //     // Add your onPressed code here!
              //   },
              //   child: const Icon(Icons.add),
              // ),
              // groupAlignment: 0,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.selected,
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: (context
                          .watch<AppDataNotifier>()
                          .appData
                          .serviceDueAlertStatus)
                      ? const Badge(child: Icon(Icons.bookmark_border))
                      : const Icon(Icons.bookmark_border),
                  selectedIcon: (context
                          .watch<AppDataNotifier>()
                          .appData
                          .serviceDueAlertStatus)
                      ? const Badge(child: Icon(Icons.book))
                      : const Icon(Icons.book),
                  label: const Text('Service'),
                ),
                const NavigationRailDestination(
                  icon: Badge(child: Icon(Icons.time_to_leave_outlined)),
                  selectedIcon: Badge(child: Icon(Icons.time_to_leave)),
                  label: Text('Vehicle'),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.quick_contacts_dialer_outlined),
                  selectedIcon: Icon(Icons.contact_phone),
                  label: Text('Contact'),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.history),
                  selectedIcon: Icon(Icons.manage_history),
                  label: Text('History'),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.help_outline),
                  selectedIcon: Icon(Icons.help),
                  label: Text('About'),
                ),
              ],
            ),
            // Main content
            // This part is always shown
            // You will see it on both small and wide screen
            Expanded(child: _mainContents[_selectedIndex]),
          ],
        ),
      ),
    );
  }
}
