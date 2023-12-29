import 'package:flutter/material.dart';
import 'package:pitstop_service/model/emergency_contact.dart';
import 'package:pitstop_service/widgets/update_emergency_contact.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Pitstop at your service',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  // color: Colors.red.shade100,
                  shadowColor: Colors.transparent,
                  margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    // alignment: Alignment.topLeft,

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
                        Wrap(
                          children: [
                            TextButton.icon(
                              onPressed: () => _makePhoneCall('8554851010'),
                              icon: const Icon(Icons.phone),
                              label: const Text('Call'),
                            ),
                            TextButton.icon(
                              onPressed: _launchMap,
                              icon: const Icon(Icons.directions),
                              label: const Text('Directions'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Card(
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
                        title: Text(primary.name),
                        subtitle: Text('${primary.relation.value}\n'
                            '+91 ${primary.number}'),
                        trailing: IconButton.filled(
                          onPressed: () => _makePhoneCall(primary.number),
                          color: Colors.white,
                          icon: const Icon(Icons.phone),
                        ),
                        onLongPress: () =>
                            _updateEmergencyContact(context, primary),
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_outline_rounded),
                        title: Text(secondary.name),
                        subtitle: Text('${secondary.relation.value}\n'
                            '+91 ${secondary.number}'),
                        trailing: IconButton.filled(
                          onPressed: () => _makePhoneCall(secondary.number),
                          color: Colors.white,
                          icon: const Icon(Icons.phone),
                        ),
                        onLongPress: () =>
                            _updateEmergencyContact(context, secondary),
                      ),
                      // ListTile(
                      //   leading: const Icon(Icons.car_repair),
                      //   title: const Text('Emergency Garage'),
                      //   subtitle: const Text(
                      //     'KD Car Care Service Helpline\n'
                      //     '+91 855 485 1010',
                      //   ),
                      //   trailing: IconButton.filled(
                      //     onPressed: () => _makePhoneCall('8554851010'),
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
                          onPressed: () => _makePhoneCall('1033'),
                          color: Colors.white,
                          icon: const Icon(Icons.phone),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(launchUri)) {
      launchUrl(launchUri);
    } else {
      throw 'Calling not supported on this device\nCould not launch $launchUri';
    }
  }

  Future<void> _launchMap() async {
    final map = Uri.parse('https://maps.app.goo.gl/476usahhoGYFtZ32A');

    if (await canLaunchUrl(map)) {
      launchUrl(map);
    } else {
      throw 'Could not launch $map';
    }
  }

  Future<void> _updateEmergencyContact(
      BuildContext context, EmergencyContact contact) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.emergency_outlined),
        title: const Text("Update Emergency Contact"),
        content: EmergencyContactForm(contact: contact),
        scrollable: true,
      ),
    );
  }
}
