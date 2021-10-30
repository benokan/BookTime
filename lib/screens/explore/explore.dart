import 'package:book_time/models/book.dart';
import 'package:book_time/screens/widget/horizontal_list_item.dart';
import 'package:book_time/screens/widget/vertical_list_item.dart';
import 'package:book_time/services/auth_services.dart';
import 'package:books_finder/books_finder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  //to keep track of the previous state when changed from the bottom bar
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Explore');
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 144, 92, 76),
        title: customSearchBar,
        actions: [
          IconButton(
            icon: customIcon,
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
        /*title: Row(
          children: [
            Text('Explore'),
            Spacer(),
            IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),*/
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Best Sellers of 2021",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bestSellerList.length,
                itemBuilder: (cxt, i) => HorizontalListItem(i),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Greatest Books of All Time",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              height: 850,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: greatestBooksList.length,
                itemBuilder: (ctx, i) => VerticalListItem(i),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/*class ExplorePageScreen extends StatelessWidget {
  const ExplorePageScreen({
    Key? key,
    required this.userName,
  }) : super(key: key);

  final userName;
  
  @override
  Widget build(BuildContext context) {
    
  }
}*/


class DataSearch extends SearchDelegate<String> {
  final allBooks = [
    "The Da Vinci Code",
    "The Hobbit",
    "The Alchemist",
    "The Hunger Games",
    "The Godfather",
    "Dune",
    "The Exorcist"
  ];
  final recentBooks = ["The Da Vinci Code", "The Hobbit", "The Alchemist"];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: searchBook(query),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  "Here are the 3 most relevant results:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/specificbook', arguments: {
                      'id': snapshot.data[0].info.industryIdentifier.toString(),
                      'title': snapshot.data[0].info.title.toString(),
                      'author': snapshot.data[0].info.authors[0].toString(),
                      'imageUrl': snapshot.data[0].info.imageLinks["thumbnail"]
                          .toString(),
                      'description':
                          snapshot.data[0].info.description.toString(),
                      'rating': snapshot.data[0].info.averageRating.toString(),
                      'year': snapshot.data[0].info.publishedDate
                          .toString()
                          .substring(0, 4),
                      'pages': snapshot.data[0].info.pageCount.toString(),
                    });
                  },
                  child: Card(
                    elevation: 5,
                    child: Row(
                      children: <Widget>[
                        Hero(
                          tag: snapshot.data[0].info.industryIdentifier
                              .toString(),
                          child: Container(
                            height: 150,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(snapshot
                                      .data[0].info.imageLinks["thumbnail"]
                                      .toString()),
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
                                  snapshot.data[0].info.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 240,
                                  child: Text(
                                    snapshot.data[0].info.description
                                        .toString(),
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/specificbook', arguments: {
                      'id': snapshot.data[1].info.industryIdentifier.toString(),
                      'title': snapshot.data[1].info.title.toString(),
                      'author': snapshot.data[1].info.authors[0].toString(),
                      'imageUrl': snapshot.data[1].info.imageLinks["thumbnail"]
                          .toString(),
                      'description':
                          snapshot.data[1].info.description.toString(),
                      'rating': snapshot.data[1].info.averageRating.toString(),
                      'year': snapshot.data[1].info.publishedDate
                          .toString()
                          .substring(0, 4),
                      'pages': snapshot.data[1].info.pageCount.toString(),
                    });
                  },
                  child: Card(
                    elevation: 5,
                    child: Row(
                      children: <Widget>[
                        Hero(
                          tag: snapshot.data[1].info.industryIdentifier
                              .toString(),
                          child: Container(
                            height: 150,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(snapshot
                                      .data[1].info.imageLinks["thumbnail"]
                                      .toString()),
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
                                  snapshot.data[1].info.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 240,
                                  child: Text(
                                    snapshot.data[1].info.description
                                        .toString(),
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/specificbook', arguments: {
                      'id': snapshot.data[2].info.industryIdentifier.toString(),
                      'title': snapshot.data[2].info.title.toString(),
                      'author': snapshot.data[2].info.authors[0].toString(),
                      'imageUrl': snapshot.data[2].info.imageLinks["thumbnail"]
                          .toString(),
                      'description':
                          snapshot.data[2].info.description.toString(),
                      'rating': snapshot.data[2].info.averageRating.toString(),
                      'year': snapshot.data[2].info.publishedDate
                          .toString()
                          .substring(0, 4),
                      'pages': snapshot.data[2].info.pageCount.toString(),
                    });
                  },
                  child: Card(
                    elevation: 5,
                    child: Row(
                      children: <Widget>[
                        Hero(
                          tag: snapshot.data[2].info.industryIdentifier
                              .toString(),
                          child: Container(
                            height: 150,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(snapshot
                                      .data[2].info.imageLinks["thumbnail"]
                                      .toString()),
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
                                  snapshot.data[2].info.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 240,
                                  child: Text(
                                    snapshot.data[2].info.description
                                        .toString(),
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
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentBooks
        : allBooks
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.book),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.black38),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}

Future<List> searchBook(String query) async {
  final books = await queryBooks(
    query,
    maxResults: 3,
    printType: PrintType.books,
    orderBy: OrderBy.relevance,
    reschemeImageLinks: true,
  );
  books.forEach((book) {
    final info = book.info;
    print('$info\n');
  });
  return books;
}
