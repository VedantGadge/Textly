import 'dart:developer';

import 'package:Textly/api/apis.dart';
import 'package:Textly/helper/dialogs.dart';
import 'package:Textly/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//login screen - for implementing the sign in or sign up feature of the app
class _LoginScreenState extends State<LoginScreen> {
  double _scale = 0.0;

  @override
  void initState() {
    super.initState();
    // Trigger the zoom-in effect after the widget builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _scale = 1.0;
      });
    });
  }

  _handleGoogleSignInButton() {
    Dialogs.showProgressBar(context);
    signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user != null) {

        if(await APIs.userExists()){
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        // We are using push replacement because we don't want the user to come back to the login screen ever again.
        }
        else{
          await 
        }
        
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showCustomSnackbar(
          context, "Something went wrong (Check Internet)");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // AppBar
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
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Textly',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height *
                  .15, // sets the top distance to 15% of the screen size
              width: MediaQuery.of(context).size.width * .5,
              left: MediaQuery.of(context).size.width * .25,
              child: AnimatedScale(
                scale: _scale,
                duration: const Duration(seconds: 1),
                curve: Curves.fastEaseInToSlowEaseOut,
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
                  _handleGoogleSignInButton();
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
