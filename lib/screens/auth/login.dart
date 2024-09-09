import 'package:Textly/screens/home.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _opacity = 0.0;
  @override
  void initState() {
    super.initState();
    // Trigger the fade-in effect after the widget builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //AppBar
        appBar: AppBar(
          title: Center(
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Color(0xff5cf9b0),
                  Color(0xff5ff2ed),
                ],
                tileMode: TileMode
                    .mirror, // Gradient behavior when extending beyond the bounds
              ).createShader(bounds),
              child: const Text(
                'Textly',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height *
                  .15, // sets the top dist 15% of te screen size
              width: MediaQuery.of(context).size.width * .5,
              left: MediaQuery.of(context).size.width * .25,
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 2),
                child: Image.asset('assets/imgs/icon.png'),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width * .75,
              left: MediaQuery.of(context).size.width * .125,
              height: MediaQuery.of(context).size.height * .06,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shadowColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              const HomeScreen())); // We are using push replacement cuz we dont want the user to come back to the login screen ever again.
                },
                icon: Image.asset(
                  'assets/imgs/google.png',
                  height: MediaQuery.of(context).size.height * .04,
                ),
                label: RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 19),
                      children: [
                        TextSpan(
                          text: 'Log in with ',
                        ),
                        TextSpan(
                          text: 'Google',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
