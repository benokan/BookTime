import 'package:book_time/screens/specificbook/specificbook.dart';
import 'package:flutter/material.dart';

// This gotta be done with ListView.builder
class BookRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(width: 5),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SpecificBookPage()),
              );
            }, // handle your image tap here
            child: Image.asset(
              'assets/1984.png',
              alignment: Alignment.center,
            ),
          ),
          SizedBox(width: 5),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SpecificBookPage()),
              );
            },
            child: Image.asset(
              'assets/martian.png',
              alignment: Alignment.center,
            ),
          ),
          SizedBox(width: 5),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SpecificBookPage()),
              );
            }, // handle your image tap here
            child: Image.asset(
              'assets/MurderOfRoger.png',
              alignment: Alignment.center,
            ),
          ),
          SizedBox(width: 5),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SpecificBookPage()),
              );
            }, // handle your image tap here
            child: Image.asset(
              'assets/MurderOfRoger.png',
              alignment: Alignment.center,
            ),
          ),
          SizedBox(width: 5),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SpecificBookPage()),
              );
            }, // handle your image tap here
            child: Image.asset(
              'assets/MurderOfRoger.png',
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
