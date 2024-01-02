import 'package:flutter/material.dart';
import 'package:pitstop_service/widgets/due_service_card.dart';
import 'package:pitstop_service/widgets/last_service_card.dart';
import 'package:pitstop_service/widgets/vehicle_registration_info.dart';

class LastService extends StatelessWidget {
  const LastService({super.key});

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
                'Service dashboard',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            const SizedBox(height: 16.0),
            const VehicleRegistrationInfoBox(
              manufacturer: 'Volkswagen',
              model: 'Ameo',
              registrationNumber: 'MH11 BV 8183',
            ),
            if (MediaQuery.of(context).size.width < 600)
              const Column(
                children: [
                  DueServiceCard(),
                  SizedBox(height: 8.0),
                  LastServiceCard(),
                ],
              )
            else
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: DueServiceCard()),
                  SizedBox(width: 8.0),
                  Expanded(child: LastServiceCard()),
                ],
              ),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}
