import 'package:book_time/models/book.dart';
import 'package:flutter/material.dart';

class VerticalListItem extends StatelessWidget {
  final int index;
  VerticalListItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/specificbook', arguments: {
              'id': greatestBooksList[index].id,
              'title': greatestBooksList[index].title,
              'author': greatestBooksList[index].author,
              'imageUrl': greatestBooksList[index].imageUrl,
              'description': greatestBooksList[index].description,
              'rating': greatestBooksList[index].rating,
              'year': greatestBooksList[index].year,
              'pages': greatestBooksList[index].pages,
            });
          },
          child: Card(
            elevation: 5,
            child: Row(
              children: <Widget>[
                Hero(
                  tag: greatestBooksList[index].id,
                  child: Container(
                    height: 150,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5),
                      ),
                      image: DecorationImage(
                          image:
                              NetworkImage(greatestBooksList[index].imageUrl),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          greatestBooksList[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 240,
                          child: Text(
                            greatestBooksList[index].description,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
