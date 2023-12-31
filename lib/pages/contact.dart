import 'package:flutter/material.dart';
import 'package:pitstop_service/widgets/connect_with_us_card.dart';
import 'package:pitstop_service/widgets/emergency_contacts_card.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 4.0, right: 12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              child: Text(
                'Pitstop at your service',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            if (MediaQuery.of(context).size.width < 600)
              const Column(
                children: [
                  ConnectWithUsCard(),
                  SizedBox(height: 8.0),
                  EmergencyContactsCard(),
                ],
              )
            else
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: ConnectWithUsCard(),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    flex: 5,
                    child: EmergencyContactsCard(),
                  ),
                ],
              ),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}
