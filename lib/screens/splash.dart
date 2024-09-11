import 'package:Textly/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

//login screen - for implementing the sign in or sign up feature of the app
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      //exit full screen mode
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

      //navigate to home screen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * .55,
              width: MediaQuery.of(context).size.width * .5,
              left: MediaQuery.of(context).size.width * .25,
              child: Center(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xff5cf9b0),
                      Color(0xff5ff2ed),
                    ],
                    tileMode: TileMode
                        .mirror, // Gradient behavior when extending beyond the bounds
                  ).createShader(bounds),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      'Textly',
                      style: GoogleFonts.pacifico(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height *
                  .25, // sets the top distance to 15% of the screen size
              width: MediaQuery.of(context).size.width * .5,
              left: MediaQuery.of(context).size.width * .25,

              child: Image.asset('assets/imgs/icon.png'),
            ),
          ],
        ),
      ),
    );
  }
}
