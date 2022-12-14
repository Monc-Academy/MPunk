import '/constants/firestore_constants.dart';
import '/models/listchat.dart';
import '/models/chat_message.dart';
import '/models/userChat.dart';
import '/providers/databaseProvider.dart';
import '/screens/listchat_screen.dart';
import '/screens/message_screen.dart';
import '/values/app_colors.dart';
import '/values/session_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListResult extends StatelessWidget {
  final QuerySnapshot SnapshotData;

  const ListResult({Key? key, required this.SnapshotData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 5),
        child: ListView.builder(
            itemCount: SnapshotData.docs.length,
            itemBuilder: ((context, index) {
              return rowUser(
                userchat: UserChat(
                  email: SnapshotData.docs[index]
                      .get(FirestoreContants.email_user),
                  id: SnapshotData.docs[index].get(FirestoreContants.id_user),
                  name:
                      SnapshotData.docs[index].get(FirestoreContants.name_user),
                  photo: SnapshotData.docs[index]
                      .get(FirestoreContants.photo_user),
                ),
              );
            })),
      ),
    );
  }
}

class rowUser extends StatelessWidget {
  final UserChat userchat;
  const rowUser({Key? key, required this.userchat}) : super(key: key);

  String getChatRoomID(
      String a, String b) // make a chat roomID with alphabetical order
  {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$a\_$b";
    } else {
      return "$b\_$a";
    }
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseProvider databaseProvider =
        Provider.of<DatabaseProvider>(context);
    return GestureDetector(
      onTap: () {
        // get curently users
        SessionManager prefs = SessionManager();
        prefs.getCurrUser().then((currUser) {
          if (currUser != null) {
            print("after get curently users: " + currUser.photo!);
            String roomID =
                getChatRoomID(currUser.id.toString(), userchat.id.toString());

            databaseProvider.getChatRoom(roomID).then((querySnapShot) {
              if (querySnapShot.docs.length == 0) {
                // if we didn't have this room before
                // create a room
                List<String> user = [
                  currUser.id.toString(),
                  userchat.id.toString()
                ];
                Map<String, dynamic> mapRoom = {
                  FirestoreContants.roomID_room: roomID,
                  FirestoreContants.UserID_room: user,
                };
                databaseProvider.createChatRoom(roomID, mapRoom);
              } else {
                // if we had this room before
                // do nothing
                print("we had this room before");
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Message(
                            currUser: currUser,
                            userChat: userchat,
                            roomID: roomID,
                          )));
            });
          } else {
            print("get curr user return null");
          }
        });
      },
      child: ListTile(
        leading: Stack(children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userchat.photo!),
            radius: 25,
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  color: AppColor.kPrimaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 2,
                      color: Theme.of(context).scaffoldBackgroundColor)),
            ),
          )
        ]),
        title: Text(userchat.name.toString()),
        subtitle: Text(
          "???? k???t n???i",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
