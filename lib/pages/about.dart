import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  int _counter = 0;

  void _incrementCounter() {
    if (_counter >= 1) {
      _confirmSuper(context);
      setState(() {
        _counter = 0;
      });
    } else {
      setState(() {
        _counter++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            'About',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        Expanded(
          child: Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.only(left: 8.0, right: 16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: _incrementCounter,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const FlutterLogo(size: 80),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'KD\'s Pitstop',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    'Service Log Application',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    '\u00a9 2023 Tech4Geek Solutions',
                    // style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const Text(
                    'Version: 2023.12.13',
                    // style: Theme.of(context).textTheme.displaySmall,
                  ),
                  // const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      showLicensePage(
                        context: context,
                        applicationName: 'KD\'s Pitstop Service Log',
                        // applicationVersion: 'Dec 2023',
                        applicationLegalese: '\u00a9 2023 Tech4Geek Solutions',
                      );
                    },
                    icon: const Icon(Icons.workspace_premium),
                    label: const Text('Open-Source licenses'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _confirmSuper(BuildContext context) {
    DateTime now;
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Are you sure?"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                  label: Text('Enter PIN'), isDense: true, filled: true),
              onSubmitted: (value) => {
                now = DateTime.now(),
                if (value == '${now.hour}${now.minute}')
                  {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Reset all',
                        textAlign: TextAlign.center,
                      ),
                    )),
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Wrong pin',
                        textAlign: TextAlign.center,
                      ),
                    )),
                  },
                Navigator.pop(ctx),
              },
            ),
          ],
        ),
      ),
    );
  }
}
