import '/models/listchat.dart';
import '/models/userChat.dart';
import '/providers/authProvider.dart';
import '/providers/databaseProvider.dart';
import '/screens/call_screen.dart';
import '/screens/listchat_screen.dart';
import '/values/app_colors.dart';
import '/screens/message_screen.dart';
import '/screens/people_screen.dart';
import '/screens/profile_screen.dart';
import '/values/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainsScreen extends StatefulWidget {
  final UserChat currUser;
  const MainsScreen({Key? key, required this.currUser}) : super(key: key);

  @override
  State<MainsScreen> createState() => _MainsScreenState();
}

class _MainsScreenState extends State<MainsScreen> {
  int _selectedIndex = 0;
  final List<Widget> screen = [
    ListChat(data: chatsData),
    PeopleScreen(),
    CallScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: screen[_selectedIndex],
      bottomNavigationBar: buildBottomNavigatorBar(),
    );
  }

  BottomNavigationBar buildBottomNavigatorBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: ((value) {
          setState(() {
            _selectedIndex = value;
          });
        }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
          BottomNavigationBarItem(
              icon: widget.currUser.photo != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(widget.currUser.photo!),
                      radius: 15,
                    )
                  : CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/mpunk-blackbg.png"),
                      radius: 15,
                      backgroundColor: Colors.transparent,
                    ),
              label: "Profile"),
        ]);
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text('Messengang Chats'),
      automaticallyImplyLeading: false,
    );
  }
}
