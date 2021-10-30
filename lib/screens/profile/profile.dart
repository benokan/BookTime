import 'package:book_time/screens/contact_us/contacts.dart';
import 'package:book_time/screens/faq/faq.dart';
import 'package:book_time/screens/login/login.dart';
import 'package:book_time/screens/profile/country_favBook.dart';
import 'package:book_time/screens/profile/profile_picture_view.dart';
import 'package:book_time/screens/profile/user_email.dart';
import 'package:book_time/screens/settings/settings.dart';
import 'package:book_time/screens/tesseract/tesseract_widget.dart';
import 'package:book_time/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_time/screens/maps/maps.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  //to keep track of the previous state when changed from the bottom bar
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final authService = Provider.of<AuthService>(context);

    return new Scaffold(
      //backgroundColor: Color(0xFFFAFAFA),
      endDrawer: new Drawer(
        child: Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              new ListTile(
                title: new Text("Settings"),
                trailing: new Icon(Icons.settings),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage())),
              ),
              new ListTile(
                title: new Text("Help"),
                trailing: new Icon(Icons.help),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FaqPage())),
              ),
              new ListTile(
                title: new Text("Contact Us"),
                trailing: new Icon(Icons.contact_support_outlined),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactsPage())),
              ),
              new Divider(),
              new ListTile(
                title: new Text("Log Out"),
                trailing: new Icon(Icons.logout),
                onTap: () {
                  print("Logging Out");
                  authService.signOut().then((value) {
                    return Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  });
                  ;
                },
              ),
              new Divider(),
              new ListTile(
                title: new Text("Tesseract"),
                trailing: new Icon(Icons.camera),
                onTap: () {
                  print("Moving on to tesseract screen...");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TesseractScreen()));
                  ;
                },
              ),
              new Divider(),
              new ListTile(
                title: new Text("Maps"),
                trailing: new Icon(Icons.map_outlined),
                onTap: () {
                  print("Moving on to Maps screen...");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapScreen()));
                  ;
                },
              ),
              new Divider(),
              new ListTile(
                title: new Text("Close"),
                trailing: new Icon(Icons.close),
                onTap: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 144, 92, 76),
        title: Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          Center(
            child: ProfilePictureView(),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: UserEmailandUserName(),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black26),
            ),
            child: CountryFavBook(),
          ),
        ],
      ),

      /*child: Column(
          children: [
            ProfilePictureView(),
            SizedBox(height: 10),
            SizedBox(height: 70, child: UserEmailandUserName()),
            SizedBox(height: 70, child: CountryFavBook()),
          ],
        ),
      ),*/
    );
  }

  @override
  bool get wantKeepAlive => true;
}
