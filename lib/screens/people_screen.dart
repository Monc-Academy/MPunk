import 'package:flutter/material.dart';
import 'package:mpunk/providers/authProvider.dart';
import 'package:provider/provider.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {

  @override
  Widget build(BuildContext context) {
    return  Consumer<AuthProvider>(builder: (context, data, child) {
      return Column(
        children: [
          Text(data.firebaseAuth.currentUser!.email ?? "user email"),
          SizedBox(height: 30,),
          Text(data.firebaseAuth.currentUser!.uid ?? "user uid"),
        ],
      );
    });
  }
}
