import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  int _selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    var array = [
      "info@booktime.com",
      "Book Time App",
      "book.time",
      "www.booktime.com"
    ];
    var icon = [
      "assets/email.png",
      "assets/facebook.png",
      "assets/instagram.png",
      "assets/internet.png"
    ];
    var info = []; //TO FILL WITH USER INFO
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 144, 92, 76),
        title: Text('Contact Us'),
        leading: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
          ),
          child: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
              border: Border.all(color: Colors.black26),
            ),
            child: ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 30, maxHeight: 30),
                child: Image.asset(icon[index - 1]),
              ),
              title: Text(
                array[index - 1],
                style: TextStyle(
                    /* color: _selectedOption == index - 1
                      ? Colors.black
                      : Colors.grey[600],*/
                    ),
              ),
              //selected: _selectedOption == index - 1,
              onTap: () => print(array[index - 1]),
            ),
          );
        },
      ),
    );
  }
}
