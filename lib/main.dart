import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitstop_service/app.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:pitstop_service/services/app_data_service.dart';
import 'package:provider/provider.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // To retrive app data from file storage into memory for app and further
  // usage, we need to execute load() method of the change notifier instance
  // first before passing it to App through ChangeNotifierProvider.
  //
  // We can do this 2 ways.
  // We have tried both ways here and both are working fine.
  // But for proper functioning of app, we have commented out Option 2.
  //
  // ====================
  // Option: 1
  // ---------
  // Create an AppDataNotifier instance in main() itself and initialize it with
  // AppDataService instance. Call the load() method on that instance and pass
  // it to MainApp through runApp().
  //
  // Need to define AppDataNotifier object in MainApp, accept intialized
  // instance through MainApp constructor and pass it to ChangeNotifierProvider.
  //
  // Option: 2
  // ---------
  // Create an AppDataNotifier instance in MainApp locally and initialize it
  // with AppDataService instance. In the MainApp constructor call the load()
  // method on that local AppDataNotifier instance and pass instance to
  // ChangeNotifierProvider.

  // Option: 1
  // Create appDataNotifier instance with AppDataService constructor instance.
  final AppDataNotifier appDataNotifier = AppDataNotifier(AppDataService());

  // Option: 1
  // Execute load method on appDataNotifier.
  appDataNotifier.load();

  runApp(
    // Option: 1
    // Pass appDataNotifier instace as param to MainApp.
    MainApp(appDataNotifier: appDataNotifier),

    // Option: 2
    // Run MainApp as app.s
    // MainApp(),
  );
}

class MainApp extends StatelessWidget {
  // Option: 1
  // Define AppDataNotifier object.
  final AppDataNotifier appDataNotifier;

  // Option 2:
  // Define and initialize AppDataNotifier locally with AppDataService.
  // final AppDataNotifier _appDataNotifier = AppDataNotifier(AppDataService());

  // Option: 1
  // Create constructor that accepts appDataNotifier from runApp to pass
  // further to ChangeNotifierProvider.
  const MainApp({super.key, required this.appDataNotifier});

  // Option: 2
  // Create a constructor that calls load() method on initialized
  // AppDataNotifier object.
  // MainApp({super.key}) {
  //   _appDataNotifier.load();
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppDataNotifier>(
      // Option: 1
      // Pass AppDataNotifier instance to ChangeNotifierProvider
      create: (_) => appDataNotifier,

      // Option: 2
      // Pass AppDataNotifier instance to ChangeNotifierProvider
      // create: (_) => _appDataNotifier,

      child: MaterialApp(
        locale: const Locale('en', 'IN'),
        localizationsDelegates: const <LocalizationsDelegate<Object>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale('en', 'US'), // English US
          Locale('en', 'IN'), // English India
        ],
        theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
        // darkTheme: ThemeData.dark().copyWith(
        //     textTheme: GoogleFonts.poppinsTextTheme(
        //         ThemeData(brightness: Brightness.dark).textTheme)),
        home: const ServiceApp(),
      ),
    );
  }
}
