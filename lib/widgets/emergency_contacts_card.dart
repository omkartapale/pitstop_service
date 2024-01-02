import 'package:flutter/material.dart';
import 'package:pitstop_service/helpers/contact_helper.dart';
import 'package:pitstop_service/model/emergency_contact.dart';
import 'package:pitstop_service/widgets/update_emergency_contact.dart';

/// Widget Class: Renders Emergency contacts card
class EmergencyContactsCard extends StatefulWidget {
  /// Emergency contacts details widget
  ///
  /// Renders Card UI to provides emergency contact details. Primary and
  /// Secondary Emergency contact persons details, NHAI Assistance Helpline
  /// contact are displayed on card.
  ///
  /// Long press on primary and secondary contact to edit.
  const EmergencyContactsCard({super.key});

  @override
  State<EmergencyContactsCard> createState() => _EmergencyContactsCardState();
}

class _EmergencyContactsCardState extends State<EmergencyContactsCard> {
  late EmergencyContact primary;
  late EmergencyContact secondary;

  @override
  void initState() {
    // Initialize primary and secondary contacts
    primary = const EmergencyContact(
        name: 'Person Name',
        relation: ContactRelation.relative,
        number: '9876543210');
    secondary = const EmergencyContact(
        name: 'Person Name',
        relation: ContactRelation.friend,
        number: '9876543211');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.shade100,
      shadowColor: Colors.transparent,
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
                    'Emergency contacts',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline_rounded),
            title: Text(primary.name),
            subtitle: Text('${primary.relation.value}\n'
                '+91 ${primary.number}'),
            trailing: IconButton.filled(
              onPressed: () => ContactHelper.makePhoneCall(primary.number),
              color: Colors.white,
              icon: const Icon(Icons.phone),
            ),
            onLongPress: () => _updateEmergencyContact(context, primary),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline_rounded),
            title: Text(secondary.name),
            subtitle: Text('${secondary.relation.value}\n'
                '+91 ${secondary.number}'),
            trailing: IconButton.filled(
              onPressed: () => ContactHelper.makePhoneCall(secondary.number),
              color: Colors.white,
              icon: const Icon(Icons.phone),
            ),
            onLongPress: () => _updateEmergencyContact(context, secondary),
          ),
          // ListTile(
          //   leading: const Icon(Icons.car_repair),
          //   title: const Text('Emergency Garage'),
          //   subtitle: const Text(
          //     'KD Car Care Service Helpline\n'
          //     '+91 855 485 1010',
          //   ),
          //   trailing: IconButton.filled(
          //     onPressed: () => ContactHelper.makePhoneCall('8554851010'),
          //     color: Colors.white,
          //     icon: const Icon(Icons.phone),
          //   ),
          // ),
          ListTile(
            leading: const Icon(Icons.assistant_direction_outlined),
            title: const Text('NHAI Toll Free Helpline 24x7'),
            subtitle: const Text(
              'Emergency / Non-emergency issues for across '
              'National Highways stretches\n'
              '1033',
            ),
            trailing: IconButton.filled(
              onPressed: () => ContactHelper.makePhoneCall('1033'),
              color: Colors.white,
              icon: const Icon(Icons.phone),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  /// Shows a dialog to update emergency.
  ///
  /// Loads [EmergencyContactForm] with details of supplied [contact] in form
  /// to update.
  Future<void> _updateEmergencyContact(
      BuildContext context, EmergencyContact contact) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.emergency_outlined),
        title: const Text("Update Emergency Contact"),
        content: EmergencyContactForm(
          contact: contact,
        ),
        scrollable: true,
      ),
    );
  }
}
