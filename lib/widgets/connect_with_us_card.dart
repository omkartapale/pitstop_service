import 'package:flutter/material.dart';
import 'package:pitstop_service/helpers/contact_helper.dart';

/// Widget Class: Renders Connect with us card
class ConnectWithUsCard extends StatelessWidget {
  /// Connect with us widget
  ///
  /// Renders Card UI to provides garage address, contact person details.
  /// Additional buttons to Call to the garage and get location directions
  /// on map to the garage.
  const ConnectWithUsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.topLeft,
        child: Column(
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
            Wrap(
              children: [
                TextButton.icon(
                  onPressed: () => ContactHelper.makePhoneCall('8554851010'),
                  icon: const Icon(Icons.phone),
                  label: const Text('Call'),
                ),
                TextButton.icon(
                  onPressed: ContactHelper.launchMap,
                  icon: const Icon(Icons.directions),
                  label: const Text('Directions'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
