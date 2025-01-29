
import 'package:Textly/helper/my_time.dart';
import 'package:Textly/models/chat_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//view profile screen of another user thru chat screen
class viewProfileScreen extends StatefulWidget {
  final ChatUser user;
  const viewProfileScreen({super.key, required this.user});

  @override
  State<viewProfileScreen> createState() => _viewProfileScreenState();
}

class _viewProfileScreenState extends State<viewProfileScreen> {
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
              title: Text(
                widget.user.name,
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
            floatingActionButton: //user about
                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Joined on ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  MyTime.getLastMessageTime(
                      context: context,
                      time: widget.user.createdAt,
                      showYear: true),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
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

                    //user profile pic
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * 0.1),
                      child: CachedNetworkImage(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.cover,
                        imageUrl: widget.user.image,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Icon(CupertinoIcons.person_alt_circle),
                      ),
                    ),
                  ),

                  //for adding space
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  //user email id
                  Text(
                    widget.user.email,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  //for adding space
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  //user about
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'About: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                      Text(
                        widget.user.about,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  //for adding space
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                ],
              ),
            ),
            backgroundColor:
                isDarkMode ? Colors.white : const Color(0xff121212)),
      ),
    );
  }
}
