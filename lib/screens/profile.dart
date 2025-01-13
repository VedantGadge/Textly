import 'package:Textly/api/apis.dart';
import 'package:Textly/models/chat_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              await APIs.auth.signOut();
              await GoogleSignIn().signOut();
            },
            backgroundColor: Colors.redAccent,
            icon: const Icon(Icons.logout_outlined, color: Colors.white),
            label: Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(40), // Adjust this value for pill shape
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.03,
            ), //Used to set the axis of column to centre so that the image would be at centre horizontally and then add vertical height to the sized box to make it move down the screen.
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent, // Background color if needed
                shape: BoxShape.circle, // Ensures the border is circular
                border: Border.all(
                  color: Colors.white70, // Border color
                  width: 2.0, // Border width
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * 0.1),
                child: CachedNetworkImage(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.fill,
                  imageUrl: widget.user.image,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Icon(CupertinoIcons.person_alt_circle),
                ),
              ),
            ),

            //for adding space
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            Text(
              widget.user.email,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),

            //for adding space
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            //Name section
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                initialValue: widget.user.name,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: const Color(0xff4DD0E1),
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white), // Label color
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: const Color(
                          0xff4DD0E1), // Border color when not focused
                    ),
                    borderRadius: BorderRadius.circular(5), // Border radius
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color:
                          const Color(0xff4DD0E1), // Border color when focused
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            //About section
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                initialValue: widget.user.about,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.info_outline,
                    color: const Color(0xff4DD0E1),
                  ),
                  labelText: 'About',
                  labelStyle: TextStyle(color: Colors.white), // Label color
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: const Color(
                          0xff4DD0E1), // Border color when not focused
                    ),
                    borderRadius: BorderRadius.circular(5), // Border radius
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color:
                          const Color(0xff4DD0E1), // Border color when focused
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: const Color(0xff4DD0E1),
                minimumSize: Size(
                  MediaQuery.of(context).size.width * .4,
                  MediaQuery.of(context).size.height * .05,
                ), // Set background color to blue
              ),
              onPressed: () {},
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
        backgroundColor: const Color(0xff121212),
      ),
    );
  }
}
