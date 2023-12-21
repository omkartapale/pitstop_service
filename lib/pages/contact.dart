import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              'KD\'s Pitstop at your service',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Card(
            // color: Colors.red.shade100,
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.only(left: 8.0, right: 16.0),
            clipBehavior: Clip.hardEdge,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.topLeft,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.garage_outlined),
                      const SizedBox(width: 8.0),
                      Flexible(
                        child: Text(
                          'Connect with us',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'KD Car Care Services',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Sali Ali, Behind DCC Bank,'
                    '\nOff. Shivkrupa General Stores,'
                    '\nOzarde, Tal: Wai, Dist: Satara,'
                    '\nMaharashtra - 412803',
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Person Connect:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Text(
                    'Mr. Dhiraj Kharat\n'
                    '+91 855 485 1010',
                  ),
                  const SizedBox(height: 16.0),
                  OverflowBar(
                    // alignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.phone),
                        label: const Text('Call'),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.directions),
                        label: const Text('Directions'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Card(
            color: Colors.red.shade100,
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.only(left: 8.0, right: 16.0),
            clipBehavior: Clip.hardEdge,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      const Icon(Icons.emergency_outlined),
                      const SizedBox(width: 8.0),
                      Flexible(
                        child: Text(
                          'Emergency Contacts',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person_outline_rounded),
                  title: const Text('Person Name'),
                  subtitle: const Text('Relative\n'
                      '+91 987 654 3210'),
                  trailing: IconButton.filled(
                    onPressed: () {},
                    color: Colors.white,
                    icon: const Icon(Icons.phone),
                  ),
                  onLongPress: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Edit emergency contact',
                        textAlign: TextAlign.center,
                      ),
                    ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_outline_rounded),
                  title: const Text('Person Name'),
                  subtitle: const Text('Friend\n'
                      '+91 987 654 3210'),
                  trailing: IconButton.filled(
                    onPressed: () {},
                    color: Colors.white,
                    icon: const Icon(Icons.phone),
                  ),
                  onLongPress: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Edit emergency contact',
                        textAlign: TextAlign.center,
                      ),
                    ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.car_repair),
                  title: const Text('Emergency Garage'),
                  subtitle: const Text(
                    'KD Car Care Service Helpline\n'
                    '+91 855 485 1010',
                  ),
                  trailing: IconButton.filled(
                    onPressed: () {},
                    color: Colors.white,
                    icon: const Icon(Icons.phone),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.assistant_direction_outlined),
                  title: const Text('NHAI Toll Free Helpline 24x7'),
                  subtitle: const Text(
                    'Emergency / Non-emergency issues for across '
                    'National Highways stretches\n'
                    '1033',
                  ),
                  trailing: IconButton.filled(
                    onPressed: () {},
                    color: Colors.white,
                    icon: const Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
