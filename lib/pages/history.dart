import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>[
      '20-12-2023',
      '20-01-2023',
      '20-12-2022'
    ];
    final List<int> colorCodes = <int>[600, 500, 100];

    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 4.0, right: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Text(
              'Vehicle service log',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Expanded(
            child: Card(
              color: Colors.amber[50],
              shadowColor: Colors.transparent,
              clipBehavior: Clip.hardEdge,
              child: Container(
                padding: const EdgeInsets.only(top: 4.0),
                alignment: Alignment.center,
                // Show list of service history records
                child: ListView.separated(
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      splashColor: Colors.amber[colorCodes[index]],
                      isThreeLine: true,
                      title: Row(
                        children: [
                          const Icon(Icons.insert_invitation_rounded),
                          const SizedBox(width: 8.0),
                          Text(entries[index]),
                          const SizedBox(width: 24.0),
                          const Icon(Icons.speed_outlined),
                          const SizedBox(width: 8.0),
                          Text('${colorCodes[index]}'),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4.0),
                          Text(
                              'Next service suggested on ${entries[index]} or ${colorCodes[index]}KMs'),
                        ],
                      ),
                      onTap: () {},
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(thickness: 1, height: 1),
                ),

                // Show no service history records screen
                // child: const Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   // crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Icon(
                //       Icons.error_outline,
                //       size: 48,
                //     ),
                //     SizedBox(height: 8.0),
                //     Text(
                //       'No previous service history!',
                //     ),
                //   ],
                // ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
        ],
      ),
    );
  }
}
