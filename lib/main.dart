import 'package:mpunk/widget/loadingWidget.dart';

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

import 'firebase_options.dart';
// MPunk Pedia -> The ultimate place to free your mind!

void main() {
  runApp(MyApp());
}

// Main Screen
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences prefs;
  // Firebase variables
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firebaseFirestore;
  late FirebaseStorage firebaseStorage;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeVars();
  }

  initializeVars() async {
    // Ensuring all the widgets are initialized
    WidgetsFlutterBinding.ensureInitialized();

    setState(() {
      _isLoading = true;
    });
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    prefs = await SharedPreferences.getInstance();
    firebaseAuth = FirebaseAuth.instance;
    firebaseFirestore = FirebaseFirestore.instance;
    firebaseStorage = FirebaseStorage.instance;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Providers
    return !_isLoading
        ? MultiProvider(
            providers: [
                ChangeNotifierProvider(
                    create: ((context) => AuthProvider(
                        prefs: prefs,
                        firebaseAuth: firebaseAuth,
                        firestore: firebaseFirestore))),
                ChangeNotifierProvider(
                    create: (context) =>
                        DatabaseProvider(firestore: firebaseFirestore)),
                // See this
                ChangeNotifierProvider(
                    create: (context) => VerifyProvider(
                          firebaseAuth: firebaseAuth,
                        )),
                ChangeNotifierProvider(
                    create: (context) => ChatProvider(
                          firestore: firebaseFirestore,
                        )),
                ChangeNotifierProvider(
                    create: (context) => ProfileProvider(
                        firebaseStorage: firebaseStorage,
                        firestore: firebaseFirestore)),
              ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Messengang Chat Application',
              theme: lightThemeData(context),
              darkTheme: darkThemeData(context),
              home: WelcomeScreen(),
            ))
        : const LoadingWidget();
  }
}
