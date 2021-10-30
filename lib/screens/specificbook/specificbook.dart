import 'package:book_time/models/book.dart';
import 'package:book_time/screens/book_to_list/book_to_list.dart';
import 'package:book_time/screens/maps/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SpecificBookPage extends StatelessWidget {
  const SpecificBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments
        as Map<String, String>; // ! added for checking null values
    final id = routeArgs['id'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 144, 92, 76),
        title: Text('Book Details'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          children: <Widget>[
            Center(
              child: Card(
                elevation: 5,
                child: Hero(
                  tag: id!,
                  child: Container(
                    height: 250,
                    width: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(routeArgs['imageUrl']!),
                        )),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              routeArgs['title']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "By: " + routeArgs['author']!,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.menu_book,
                          size: 45,
                          color: Colors.brown,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          routeArgs['pages']!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          size: 45,
                          color: Colors.brown,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          routeArgs['year']!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.star_border,
                          size: 45,
                          color: Colors.brown,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          routeArgs['rating']! + " / 5",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              routeArgs['description']!,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text('Add to MyBooks'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookToList(
                        book: Book(
                          author: routeArgs['author']!,
                          title: routeArgs['title']!,
                          description: routeArgs['description']!,
                          id: '',
                          imageUrl: routeArgs['imageUrl']!,
                          pages: routeArgs['pages']!,
                          rating: routeArgs['rating']!,
                          year: routeArgs['year']!,
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[800],
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                label: Text('Buy Now'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
