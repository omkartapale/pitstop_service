import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pitstop_service/super/super_app.dart';
import 'package:pitstop_service/widgets/webview.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  late PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    if (_counter >= 7) {
      _confirmSuper(context);
      setState(() {
        _counter = 0;
      });
    }
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 4.0, right: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Text(
              'About KD\'s software',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Expanded(
            child: Card(
              shadowColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: _incrementCounter,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Image.asset('assets/logo.png'),
                      ),
                      Text(
                        'Service Log Application',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        '\u00a9 2024 Tech4Geek Solutions',
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'v${_packageInfo.version} build ${_packageInfo.buildNumber}\n${_packageInfo.buildSignature}',
                        textAlign: TextAlign.center,
                      ),
                      // const Spacer(),
                      const SizedBox(height: 16.0),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              showWebViewPage(
                                context: context,
                                requestUriPath:
                                    'https://tech4geek.github.io/kds-pitstop-service/terms_of_use.htm',
                                title: 'Terms of Use',
                              );
                            },
                            icon: const Icon(Icons.handshake),
                            label: const Text('Terms of Use'),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              showWebViewPage(
                                context: context,
                                requestUriPath:
                                    'https://tech4geek.github.io/kds-pitstop-service/privacy_policy.htm',
                                title: 'Privacy Policy',
                              );
                            },
                            icon: const Icon(Icons.policy),
                            label: const Text('Privacy Policy'),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              showLicensePage(
                                context: context,
                                applicationName: 'KD\'s Pitstop Service Log',
                                applicationLegalese:
                                    '\u00a9 2024 Tech4Geek Solutions',
                              );
                            },
                            icon: const Icon(Icons.workspace_premium),
                            label: const Text('Third-party Licences'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
        ],
      ),
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
                Navigator.pop(ctx),
                if (value == '${now.hour}${now.minute}')
                  {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const SuperApp(),
                      ),
                      (Route<dynamic> route) => false,
                    ),
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
              },
            ),
          ],
        ),
      ),
    );
  }

  void showWebViewPage({
    required BuildContext context,
    required String requestUriPath,
    String? title,
    bool useRootNavigator = false,
  }) {
    Navigator.of(context, rootNavigator: useRootNavigator)
        .push(MaterialPageRoute<void>(
      builder: (BuildContext context) => WebViewPage(
        requestUriPath: requestUriPath,
        title: title,
      ),
    ));
  }
}
