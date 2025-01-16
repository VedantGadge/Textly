import 'dart:developer';
import 'dart:io';

import 'package:Textly/api/apis.dart';
import 'package:Textly/helper/dialogs.dart';
import 'package:Textly/models/chat_user.dart';
import 'package:Textly/screens/auth/login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formkey = GlobalKey<FormState>();
  String? _image;
  late bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    // Determine if the device is in dark mode
    isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      //hides the keyboar upon tapping on the screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset:
                true, //prevents the floating action button from moving up with the keyboard when the keyboard is opened.
            //AppBar
            appBar: AppBar(
              backgroundColor: const Color(0xff121212),
              title: const Text(
                "Profile Screen",
              ),
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Divider(
                    color: Colors.white60, // Border color
                    thickness: 0.4, // Border thickness
                    height: 0.4 // Ensures the height matches the thickness
                    ),
              ),
            ),

            //flolating action button to add new chat
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: FloatingActionButton.extended(
                onPressed: () async {
                  //showing cirular progress bar
                  Dialogs.showProgressBar(context);
                  await APIs.auth.signOut().then((value) async {
                    await GoogleSignIn().signOut().then((value) async {
                      //Removing profile screen , returning to home screen
                      Navigator.pop(context);

                      //Removing home screen
                      Navigator.pop(context);

                      //Returning to login screen
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                    });
                  });
                },
                backgroundColor: Colors.redAccent,
                icon: const Icon(Icons.logout_outlined, color: Colors.white),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      40), // Adjust this value for pill shape
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .05),
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.03,
                        ), //Used to set the axis of column to centre so that the image would be at centre horizontally and then add vertical height to the sized box to make it move down the screen.
                        Container(
                          decoration: BoxDecoration(
                            color: Colors
                                .transparent, // Background color if needed
                            shape: BoxShape
                                .circle, // Ensures the border is circular
                            border: Border.all(
                              color: Colors.white70, // Border color
                              width: 2.0, // Border width
                            ),
                          ),

                          //user profile pic
                          child: Stack(
                            children: [
                              _image != null
                                  ?

                                  //Image from local
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.1),
                                      child: Image.file(
                                        File(_image!),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  :

                                  //Image from server
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.1),
                                      child: CachedNetworkImage(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        fit: BoxFit.cover,
                                        imageUrl: widget.user.image,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(CupertinoIcons
                                                .person_alt_circle),
                                      ),
                                    ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: MaterialButton(
                                  elevation: 1,
                                  onPressed: () {
                                    _showBottomSheet();
                                  },
                                  color: Colors.white,
                                  shape: CircleBorder(),
                                  child: Icon(
                                    Icons.edit,
                                    color: const Color(0xff4DD0E1),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        //for adding space
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),

                        //user email id
                        Text(
                          widget.user.email,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),

                        //for adding space
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),

                        //Name section
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            initialValue: widget.user.name,
                            onSaved: (value) => APIs.me.name = value ?? '',
                            validator: (value) =>
                                value != null && value.isNotEmpty
                                    ? null
                                    : 'Required Field',
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: const Color(0xff4DD0E1),
                              ),
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                  color: Colors.white70), // Label color
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: const Color(
                                      0xff4DD0E1), // Border color when not focused
                                ),
                                borderRadius:
                                    BorderRadius.circular(5), // Border radius
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: const Color(
                                      0xff4DD0E1), // Border color when focused
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: const Color(
                                      0xff4DD0E1), // Border color when enabled but not focused
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),

                        //for adding space
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),

                        //About section
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            initialValue: widget.user.about,
                            onSaved: (value) => APIs.me.about = value ?? '',
                            validator: (value) =>
                                value != null && value.isNotEmpty
                                    ? null
                                    : 'Required Field',
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.info_outline,
                                color: const Color(0xff4DD0E1),
                              ),
                              labelText: 'About',
                              labelStyle: TextStyle(
                                  color: Colors.white70), // Label color
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: const Color(
                                      0xff4DD0E1), // Border color when not focused
                                ),
                                borderRadius:
                                    BorderRadius.circular(5), // Border radius
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: const Color(
                                      0xff4DD0E1), // Border color when focused
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: const Color(
                                      0xff4DD0E1), // Border color when enabled but not focused
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),

                        //for adding space
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),

                        //Update button
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: const Color(0xff4DD0E1),
                            minimumSize: Size(
                              MediaQuery.of(context).size.width * .4,
                              MediaQuery.of(context).size.height * .05,
                            ), // Set background color to blue
                          ),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              log('inside validator');
                              _formkey.currentState!.save();
                              APIs.updateUserInfo().then((value) {
                                Dialogs.showCustomSnackbar(
                                    context, 'Profile Updates Succesfully!');
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 25,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Update',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor:
                isDarkMode ? Colors.white : const Color(0xff121212)),
      ),
    );
  }

  //bottom sheet for picking a profile pic for user
  void _showBottomSheet() {
    showModalBottomSheet(
        backgroundColor: const Color(0xff4DD0E1),
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap:
                true, // this makes the listview to the size of its content
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .025,
              bottom: MediaQuery.of(context).size.height * .03,
            ),
            children: [
              Text(
                'Pick Profile Picture',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontSize: 22.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Picture form the gallery
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.28,
                              MediaQuery.of(context).size.height * 0.13)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image.
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setState(() {
                            _image = image.path;
                          });
                        }
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/imgs/add_image.png')),

                  //Take picture from the camera
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.28,
                              MediaQuery.of(context).size.height * 0.13)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image.
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          setState(() {
                            _image = image.path;
                          });
                        }
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/imgs/camera.png',
                        scale: 7,
                      ))
                ],
              )
            ],
          );
        });
  }
}
