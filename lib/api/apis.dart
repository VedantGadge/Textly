import 'dart:math';
import 'dart:developer' as dev;
import 'package:Textly/models/chat_user.dart';
import 'package:Textly/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!; //getter fn to get the curretn user

  static late ChatUser me; //saves info of the current logged in user

  //for checking if user exists or not
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  //for getting current user info
  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        dev.log('My Data: ${user.data()}');
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  //for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatuser = ChatUser(
        image: user.photoURL.toString(),
        name: user.displayName.toString(),
        about: "Hey, I'm using Textly!",
        createdAt: time,
        isOnline: false,
        id: user.uid,
        lastActive: time,
        pushToken: '',
        email: user.email.toString());
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatuser.toJson());
  }

  //for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id',
            isNotEqualTo: user
                .uid) //shows all the users except the current user who has logged in
        .snapshots();
  }

  //for updating user info
  static Future<void> updateUserInfo() async {
    return firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  // static Future<void> updateUserProfileImg() async {
  //   final url = Uri.parse('https://api.cloudinary.com/v1_1/dtza4akuc/upload');

  //   final request = http.MultipartRequest('POST', url)
  //     ..fields['upload_preset'] = 'imgggg'
  //     ..files.add(await http.MultipartFile.fromPath('file',_imageFile!.path));
  // }

  ///********************** Chat Screen Related APIs **********************///

  //useful for getting convo id
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  //for getting all messages from a specific chat from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMsgs(ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages')
        .snapshots();
  }

  //for sending messages
  static Future<void> sendMessage(ChatUser chatuser, String msg) async {
    //message sending time, which we are using it as id
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final message = Message(
      toId: chatuser.id,
      msg: msg,
      read: '',
      type: Type.text,
      sent: time,
      fromId: user.uid,
    );

    final ref = firestore
        .collection('chats/${getConversationID(chatuser.id)}/messages');
    await ref.doc(time).set(message.toJson());
  }

  //chats (collection) --> conversation_id (doc) --> message (colection) --> message (doc)

  //update read status
  static Future<void> updateMsgReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //get only the last message of a specifi chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMsg(ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }
}
