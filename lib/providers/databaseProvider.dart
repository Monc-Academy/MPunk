import '/constants/firestore_constants.dart';
import '/models/chat_message.dart';
import '/models/userChat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class DatabaseProvider extends ChangeNotifier {
  final FirebaseFirestore firestore;

  DatabaseProvider({required this.firestore});

  UserChat? _userFromFirebase(User? user) {
    return user != null ? UserChat(id: user.uid, email: user.email) : null;
  }

  Future<QuerySnapshot> getUserByName(String name) async {
    return await firestore
        .collection(FirestoreContants.userCollection)
        .where(FirestoreContants.name_user, isGreaterThanOrEqualTo: name)
        .get();
  }

  // up load user with a custom documentID
  Future<void> UploadUser(userMap, String documentID) async {
    await firestore
        .collection(FirestoreContants.userCollection)
        .doc(documentID)
        .set(userMap);
  }

  Future<void> createChatRoom(String chatRoomID, chatRoomMap) async {
    await firestore
        .collection(FirestoreContants.roomCollection)
        .add(chatRoomMap);
  }

  Future<QuerySnapshot> getChatRoom(String chatRoomID) async {
    return await firestore
        .collection(FirestoreContants.roomCollection)
        .where(FirestoreContants.roomID_room, isEqualTo: chatRoomID)
        .get();
  }
}
