import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    var array = [
      "Profile photo",
      "Profile Name",
      "Year of birth",
      "Sex",
      "Country",
      "Notifications",
      "Email"
    ];
    var icon = [
      "assets/photo-camera.png",
      "assets/id-card.png",
      "assets/birthday-cake.png",
      "assets/gender.png",
      "assets/location.png",
      "assets/notification.png",
      "assets/email.png"
    ];
    var info = []; //TO FILL WITH USER INFO
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 144, 92, 76),
        title: Text('Settings'),
        leading: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
          ),
          child: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            child: Text(
              'SAVE',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => print('SAVE'), //TODO
          )
        ],
      ),
      body: ListView.builder(
        itemCount: array.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return SizedBox(height: 15.0);
          } else if (index == array.length + 1) {
            return SizedBox(height: 100.0);
          }
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: _selectedOption == index - 1
                  ? Border.all(color: Colors.black26)
                  : null,
            ),
            child: ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 30, maxHeight: 30),
                child: Image.asset(icon[index - 1]),
              ),
              title: Text(
                array[index - 1],
                style: TextStyle(
                  color: _selectedOption == index - 1
                      ? Colors.black
                      : Colors.grey[600],
                ),
              ),
              selected: _selectedOption == index - 1,
              onTap: () {
                setState(() {
                  _selectedOption = index - 1;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
