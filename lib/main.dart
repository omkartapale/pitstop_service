import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitstop_service/app.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(const MainApp());
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
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      // darkTheme: ThemeData.dark().copyWith(
      //     textTheme: GoogleFonts.poppinsTextTheme(
      //         ThemeData(brightness: Brightness.dark).textTheme)),
      home: const ServiceApp(),
    );
  }
}
