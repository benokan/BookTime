import 'package:book_time/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Will put email and also the username here...

class UserEmailandUserName extends StatefulWidget {
  @override
  _UserEmailandUserNameState createState() => _UserEmailandUserNameState();
}

class _UserEmailandUserNameState extends State<UserEmailandUserName> {
  @override
  Widget build(BuildContext context) {
    String? userId = AuthService().getUidofCurrentUser();

    Stream<DocumentSnapshot> userStream =
        FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    return StreamBuilder(
        stream: userStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final userEmail = snapshot.data?.get('email');
          final userName = snapshot.data?.get('name');
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null) {
              return Text("snapshot.data is null");
            } else {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        userName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.5),
                      ),
                    ],
                  ),
                ],
              );
            }
          } else {
            // May be useful for internet connection issues...
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
