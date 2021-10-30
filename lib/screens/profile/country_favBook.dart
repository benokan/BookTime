import 'package:book_time/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CountryFavBook extends StatefulWidget {
  @override
  _CountryFavBookState createState() => _CountryFavBookState();
}

class _CountryFavBookState extends State<CountryFavBook> {
  String? userId = AuthService().getUidofCurrentUser();
  TextEditingController countryController = TextEditingController();
  TextEditingController FavouriteBookController = TextEditingController();

  Future<void> dialog_books() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            TextButton(
              child: Text("Submit"),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .update({'favBook': FavouriteBookController.text}).then(
                        (value) => setState(() {}));

                Navigator.of(context).pop();
              },
            ),
          ],
          title: Text('Favourite Book'),
          content: SingleChildScrollView(
            child: TextField(
              controller: FavouriteBookController,
            ),
          ),
        );
      },
    );
  }

  Future<void> dialog_country() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            TextButton(
              child: Text("Submit"),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .update({'country': countryController.text}).then(
                        (value) => setState(() {}));

                Navigator.of(context).pop();
              },
            ),
          ],
          title: Text('Country'),
          content: SingleChildScrollView(
            child: TextField(
              controller: countryController,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> userStream =
        FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    return StreamBuilder(
        stream: userStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null) {
              return Text("snapshot.data is null");
            } else {
              return Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      dialog_country();
                    },
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 30, maxHeight: 30),
                      child: Image.asset("assets/location.png"),
                    ),
                    title: Text(
                      "Country: " + snapshot.data.get('country'),
                    ),
                    subtitle: Text("Tap to modify it..."),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      dialog_books();
                    },
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 30, maxHeight: 30),
                      child: Image.asset("assets/book.png"),
                    ),
                    title: Text(
                      "Favourite Book: " + snapshot.data.get('favBook'),
                    ),
                    subtitle: Text("Tap to update it..."),
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
