import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 144, 92, 76),
        title: Text('Faq'),
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
      body: Column(
        children: <Widget>[
          const ExpansionTile(
            title: Text('How can I add a book?'),
            children: <Widget>[
              ListTile(
                  title: Text(
                      'To add a new book on the section "My Books" you only have to search for the desired book and click on the button')),
            ],
          ),
          new Divider(),
          const ExpansionTile(
            title: Text('How can I search a book?'),
            children: <Widget>[
              ListTile(
                  title: Text(
                      'To search a book you have to go on the explore section and write the title inside the seach bar')),
            ],
          ),
          new Divider(),
          const ExpansionTile(
            title: Text('Is there a way to contact you?'),
            children: <Widget>[
              ListTile(
                  title: Text(
                      'You can always write to us just going on the "Contact Us" section in you profile')),
            ],
          ),
          new Divider(),
          const ExpansionTile(
            title: Text('Are my information secure?'),
            children: <Widget>[
              ListTile(
                  title: Text(
                      'We will not spread your information with other people without your consensus, we respct the GDPR policies')),
            ],
          ),
          new Divider(),
        ],
      ),
    );
  }
}
