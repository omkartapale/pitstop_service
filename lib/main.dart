import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitstop_service/app.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      // darkTheme: ThemeData.dark().copyWith(
      //     textTheme: GoogleFonts.poppinsTextTheme(
      //         ThemeData(brightness: Brightness.dark).textTheme)),
      home: const ServiceApp(),
    );
  }
}
