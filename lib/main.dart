import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Textly/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: GoogleFonts.pacifico(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 27),
            backgroundColor: const Color(0xff5ff2ed),
            elevation: 5,
            shadowColor: Colors.black,
          )),
      home: const Home(),
    );
  }
}
