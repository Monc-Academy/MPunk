import '/constants/firestore_constants.dart';
import '/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final FirebaseFirestore firestore;

  ChatProvider({required this.firestore});

  Stream<QuerySnapshot> getMessageWithChatroomID(String roomID) {
    return FirebaseFirestore.instance
        .collection(FirestoreContants.messageCollection)
        .where(FirestoreContants.roomID_message, isEqualTo: roomID)
        .snapshots();
  }

  Future<void> sendChatMessage(ChatMessage chatMessage, String roomID) async {
    await firestore
        .collection(FirestoreContants.messageCollection)
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      FirestoreContants.roomID_message: chatMessage.roomID,
      FirestoreContants.FromUser_message: chatMessage.FromUser,
      FirestoreContants.text_message: chatMessage.text,
      FirestoreContants.type_message: chatMessage.type,
      FirestoreContants.time_message: chatMessage.time,
    });
  }
}
