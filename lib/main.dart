import '/providers/authProvider.dart';
import '/providers/chatProvider.dart';
import '/providers/databaseProvider.dart';
import '/providers/profileProvider.dart';
import '/providers/verifyProvider.dart';
import '/screens/welcome_screen.dart';
import '/themedata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// MPunk Pedia -> The ultimate place to free your mind!

void main() async {
  // Ensuring all the widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    prefs: prefs,
  ));
}
// Main Screen
class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  // Firebase variables
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Providers
    return MultiProvider(
        providers: [
          // ChangeNotifierProvider(
          //     create: ((context) => AuthProvider(
          //         prefs: prefs,
          //         firebaseAuth: firebaseAuth,
          //         firestore: firebaseFirestore))),
          // ChangeNotifierProvider(
          //     create: (context) =>
          //         DatabaseProvider(firestore: firebaseFirestore)),

          // // See this 
          // ChangeNotifierProvider(
          //     create: (context) => VerifyProvider(
          //           firebaseAuth: firebaseAuth,
          //         )),
          // ChangeNotifierProvider(
          //     create: (context) => ChatProvider(
          //           firestore: firebaseFirestore,
          //         )),
          // ChangeNotifierProvider(
          //     create: (context) => ProfileProvider(
          //         firebaseStorage: firebaseStorage,
          //         firestore: firebaseFirestore)),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Messengang Chat Application',
          theme: lightThemeData(context),
          darkTheme: darkThemeData(context),
          home: WelcomeScreen(),
        ));
  }
}
