import 'package:Textly/firebase_options.dart';
import 'package:Textly/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ////enter full screen mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  //Set device orientation
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFirebase();
    runApp(const MyApp());
  });
  //used .then() because setPreferredOrientations returns future , so that we can use .then() on it ,
  //n initialize the app only after the orientation has been setup, to avoid any wierd glitches
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                color: const Color(0xff5ff2ed),
                fontWeight: FontWeight.w400,
                fontSize: 27),
            backgroundColor: Colors.white,
            elevation: 3,
            shadowColor: Colors.black,
          )),
      home: const SplashScreen(),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

//async return Future object
//async* returns Stream object
