import 'package:Textly/api/apis.dart';
import 'package:Textly/custom_widgets/chat_user_card.dart';
import 'package:Textly/models/chat_user.dart';
import 'package:Textly/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> _userList = [];

  // for storing searched items
  final List<ChatUser> _searchList = [];

  // for storing search status
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  late bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    // Determine if the device is in dark mode
    isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(

          //AppBar
          appBar: AppBar(
            backgroundColor: const Color(0xff121212),
            title: _isSearching
                ? TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Name, Email, ..."),
                    autofocus: true,
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, letterSpacing: 0.5),

                    //when the search text changes
                    onChanged: (value) {
                      //search logic
                      _searchList.clear();

                      for (var i in _userList) {
                        if (i.name
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            i.email
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                          _searchList.add(i);
                          setState(() {
                            _searchList;
                          });
                        }
                      }
                    })
                : const Text(
                    "Textly",
                  ),
            leading: const Icon(
              CupertinoIcons.home,
              color: Colors.white,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                },
                icon: _isSearching
                    ? Icon(
                        CupertinoIcons.clear,
                        color: Colors.white,
                      )
                    : const Icon(Icons.search, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProfileScreen(
                                user: APIs.me,
                              )));
                },
                icon: const Icon(Icons.more_vert, color: Colors.white),
              )
            ],
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
            child: FloatingActionButton(
              onPressed: () async {
                await APIs.auth.signOut();
                await GoogleSignIn().signOut();
              },
              backgroundColor: const Color(0xff4DD0E1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    40), // Adjust this value for pill shape
              ),
              child: const Icon(Icons.add_comment_rounded, color: Colors.white),
            ),
          ),

          //body
          body: StreamBuilder(
              stream: APIs.getAllUsers(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  //if data is loading (waiting or none)
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());

                  //if data is done loading(even partly)
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    _userList = data
                            ?.map((e) => ChatUser.fromJson(e
                                .data())) //smilar to for() maps each data to each list element
                            .toList() ??
                        [];
                    if (_userList.isNotEmpty) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * .015),
                        itemBuilder: (context, index) {
                          return ChatUserCard(
                            user: _isSearching
                                ? _searchList[index]
                                : _userList[index],
                          );
                        },
                        itemCount: _isSearching
                            ? _searchList.length
                            : _userList.length,
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'No Connections Found !',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      );
                    }
                }
              }),
          backgroundColor: isDarkMode ? Colors.white : const Color(0xff121212)),
    );
  }
}
