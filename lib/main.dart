import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitstop_service/app.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Ensure WidgetsFlutterBinding is initialized.
  //
  // The "instance" getter on the ServicesBinding binding mixin is only
  // available once that binding has been initialized.
  //
  // Typically, this is done by calling "WidgetsFlutterBinding.ensureInitialized()"
  // or "runApp()" (the latter calls the former). Typically this call is done
  // in the "void main()" method. The "ensureInitialized" method is idempotent;
  // calling it multiple times is not harmful. After calling that method, the
  // "instance" getter will return the binding.
  //
  // In a test, one can call "TestWidgetsFlutterBinding.ensureInitialized()" as
  // the first line in the test's "main()" method to initialize the binding.
  //
  // If ServicesBinding is a custom binding mixin, there must also be a custom
  // binding class, like WidgetsFlutterBinding, but that mixes in the selected
  // binding, and that is the class that must be constructed before using the
  // "instance" getter.
  WidgetsFlutterBinding.ensureInitialized();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    final sketchfab =
        await rootBundle.loadString('assets/sketchfab_attribution.txt');
    yield LicenseEntryWithLineBreaks(['sketchfab'], sketchfab);
  });

  runApp(ChangeNotifierProvider<AppDataNotifier>(
    // Pass AppDataNotifier instance to ChangeNotifierProvider
    create: (context) => AppDataNotifier(),
    builder: (context, child) => const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en', 'IN'),
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en', 'US'), // English US
        Locale('en', 'IN'), // English India
      ],
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorSchemeSeed: Colors.amber,
      ),
      // darkTheme: ThemeData.dark().copyWith(
      //     textTheme: GoogleFonts.poppinsTextTheme(
      //         ThemeData(brightness: Brightness.dark).textTheme)),
      home: const ServiceApp(),
    );
  }
}
