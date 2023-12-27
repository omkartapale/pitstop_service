import 'package:flutter/material.dart';

class LastService extends StatelessWidget {
  const LastService({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Service dashboard',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            height: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Volkswagen'.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall),
                Text('Ameo', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16.0),
                Chip(
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.all(0.0),
                  side: const BorderSide(width: 2.0),
                  labelStyle: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                  labelPadding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 6.0),
                  label: const Text('MH11 BV 8183'),
                  avatar: Image.asset(
                    'assets/number_plate_ind_logo.webp',
                    // fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Card(
                  color: Colors.red.shade100,
                  shadowColor: Colors.transparent,
                  margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Due Service',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(width: 8.0),
                            const Icon(
                              Icons.error_outline_rounded,
                              color: Colors.deepOrange,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Service Date'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Text(
                                    '12 Nov \'23',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Odometer Reading'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Text(
                                    '1600 kms',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Suggestions'.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: [
                            Chip(
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.all(0.0),
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                              label: const Text('Gear Oil'),
                            ),
                            Chip(
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.all(0.0),
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                              label: const Text('Throttle Cleanup'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  color: Colors.yellow.shade100,
                  shadowColor: Colors.transparent,
                  margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Service',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Service Date'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Text(
                                    '12 Jan \'23',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Odometer Reading'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Text(
                                    '600 kms',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Worknotes'.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: [
                            Chip(
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.all(0.0),
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                              label: const Text('Brake Oil'),
                            ),
                            Chip(
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.all(0.0),
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                              label: const Text('Calliper Pin'),
                            ),
                          ],
                        )
                      ],
                    ),
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
}
