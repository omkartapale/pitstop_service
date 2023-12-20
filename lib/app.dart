import 'package:flutter/material.dart';
import 'package:pitstop_service/pages/about.dart';

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
    Card(
      color: Colors.yellow.shade100,
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.only(left: 8.0, right: 16.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const SizedBox.expand(
          child: Text(
            'Last Service Log',
            style: TextStyle(fontSize: 34),
          ),
        ),
      ),
    ),

    // Content for Vehicle Information tab
    Card(
      color: Colors.purple.shade100,
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.only(left: 8.0, right: 16.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const SizedBox.expand(
          child: Text(
            'Vehicle Information',
            style: TextStyle(fontSize: 34),
          ),
        ),
      ),
    ),

    // Content for Contact tab
    Card(
      color: Colors.red.shade100,
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.only(left: 8.0, right: 16.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.topLeft,
        child: const Text(
          'Contact KD\'s Pitstop',
          style: TextStyle(fontSize: 34),
        ),
      ),
    ),

    // Content for History tab
    Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.only(left: 8.0, right: 16.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.topLeft,
        child: const Text(
          'History',
          style: TextStyle(fontSize: 34),
        ),
      ),
    ),

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
        leading: const Icon(Icons.published_with_changes, size: 24),
        leadingWidth: 80,
        title: const Text('KD\'s Pitstop Service'),
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            NavigationRail(
              leading: Column(
                children: [
                  IconButton(
                      icon: const Icon(Icons.published_with_changes),
                      onPressed: () {}),
                  const SizedBox(height: 8.0),
                ],
              ),
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
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Badge(child: Icon(Icons.bookmark_border)),
                  selectedIcon: Badge(child: Icon(Icons.book)),
                  label: Text('Service'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.time_to_leave_outlined),
                  selectedIcon: Icon(Icons.time_to_leave),
                  label: Text('Vehicle'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.quick_contacts_dialer_outlined),
                  selectedIcon: Icon(Icons.contact_phone),
                  label: Text('Contact'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.history),
                  selectedIcon: Icon(Icons.manage_history),
                  label: Text('History'),
                ),
                NavigationRailDestination(
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
