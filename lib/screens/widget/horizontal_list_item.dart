import 'package:book_time/models/book.dart';
import 'package:flutter/material.dart';

class HorizontalListItem extends StatelessWidget {
  final int index;
  HorizontalListItem(this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/specificbook', arguments: {
            'id': bestSellerList[index].id,
            'title': bestSellerList[index].title,
            'author': bestSellerList[index].author,
            'imageUrl': bestSellerList[index].imageUrl,
            'description': bestSellerList[index].description,
            'rating': bestSellerList[index].rating,
            'year': bestSellerList[index].year,
            'pages': bestSellerList[index].pages,
          });
        },
        child: Column(
          children: <Widget>[
            Card(
              elevation: 10,
              child: Hero(
                tag: bestSellerList[index].id,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(bestSellerList[index].imageUrl),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              bestSellerList[index].title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
