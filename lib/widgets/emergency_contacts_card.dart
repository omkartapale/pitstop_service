import 'package:flutter/material.dart';
import 'package:pitstop_service/helpers/contact_helper.dart';
import 'package:pitstop_service/model/emergency_contact.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:pitstop_service/widgets/update_emergency_contact.dart';
import 'package:provider/provider.dart';

/// Widget Class: Renders Emergency contacts card
class EmergencyContactsCard extends StatelessWidget {
  /// Emergency contacts details widget
  ///
  /// Renders Card UI to provides emergency contact details. Primary and
  /// Secondary Emergency contact persons details, NHAI Assistance Helpline
  /// contact are displayed on card.
  ///
  /// Long press on primary and secondary contact to edit.
  const EmergencyContactsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.shade100,
      shadowColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      child: Column(
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
          Consumer<AppDataNotifier>(
            builder: (context, dataStore, child) => ListTile(
              leading: const Icon(Icons.person_outline_rounded),
              title: Text(dataStore.appData.primaryContact.name),
              subtitle:
                  Text('${dataStore.appData.primaryContact.relation.value}\n'
                      '+91 ${dataStore.appData.primaryContact.number}'),
              trailing: IconButton.filled(
                onPressed: () => ContactHelper.makePhoneCall(
                    dataStore.appData.primaryContact.number),
                color: Colors.white,
                icon: const Icon(Icons.phone),
              ),
              onLongPress: () => _updateEmergencyContact(
                  context, dataStore.appData.primaryContact, true),
            ),
          ),
          Consumer<AppDataNotifier>(
            builder: (context, dataStore, child) => ListTile(
              leading: const Icon(Icons.person_outline_rounded),
              title: Text(dataStore.appData.secondaryContact.name),
              subtitle:
                  Text('${dataStore.appData.secondaryContact.relation.value}\n'
                      '+91 ${dataStore.appData.secondaryContact.number}'),
              trailing: IconButton.filled(
                onPressed: () => ContactHelper.makePhoneCall(
                    dataStore.appData.secondaryContact.number),
                color: Colors.white,
                icon: const Icon(Icons.phone),
              ),
              onLongPress: () => _updateEmergencyContact(
                  context, dataStore.appData.secondaryContact, false),
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
      BuildContext context, EmergencyContact contact, bool isPrimaryContact) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.emergency_outlined),
        title: const Text("Update Emergency Contact"),
        content: EmergencyContactForm(
          contact: contact,
          isPrimaryContact: isPrimaryContact,
        ),
        scrollable: true,
      ),
    );
  }
}
