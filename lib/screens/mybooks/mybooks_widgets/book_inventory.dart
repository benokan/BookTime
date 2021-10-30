import 'package:book_time/models/book.dart';
import 'package:book_time/services/auth_services.dart';
import 'package:book_time/services/books_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookInventory extends StatefulWidget {
  BookInventory({required this.name});

  final String name;

  @override
  State<BookInventory> createState() => _BookInventoryState();
}

class _BookInventoryState extends State<BookInventory> {
  final listNameController = TextEditingController();
  final _authService = AuthService();
  final _booksService = BooksService();
  List<Book> bookList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await FirebaseFirestore.instance.collection('books').get().then((value) {
      value.docs.forEach((element) {
        bookList.add(Book(
          id: 'id',
          title: element['title'],
          author: element['author'],
          imageUrl: element['imageUrl'],
          description: element['description'],
          rating: element['rating'],
          year: element['year'],
          pages: element['pages'],
        ));
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Color.fromARGB(255, 144, 92, 76),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayBookList(),
        child: const Icon(Icons.add_outlined),
        backgroundColor: Color.fromARGB(255, 144, 92, 76),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("books_list")
            .doc(_authService.getUidofCurrentUser())
            .collection("books_list")
            .doc(widget.name)
            .collection('data')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null) {
              return Center(
                  child: Text("${widget.name} is empty.",
                      style: TextStyle(fontSize: 16)));
            } else {
              if (snapshot.data.docs.length > 0) {
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('/specificbook', arguments: {
                            'id': 'b345',
                            'title': ds['title'].toString(),
                            'author': ds['author'].toString(),
                            'imageUrl': ds['imageUrl'].toString(),
                            'description': ds['description'].toString(),
                            'rating': ds['rating'].toString(),
                            'year': ds['year'].toString(),
                            'pages': ds['pages'].toString(),
                          });
                        },
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 150,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    topLeft: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          ds["imageUrl"].toString()),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        ds["title"].toString(),
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
                                          ds['description'].toString(),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                               Expanded(
                                flex: 0,
                                child: Column(
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        await _booksService
                                            .deleteBookFromInventory(
                                                bookName:
                                                    ds['title'].toString(),
                                                bookList: widget.name,
                                                context: context);
                                      },
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                    child: Text(
                  "${widget.name} is empty.",
                  style: TextStyle(fontSize: 16),
                ));
              }
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> _displayBookList() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Books'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [...?bookListWidget()],
            ),
          ),
        );
      },
    );
  }

  Future<void> _addBookToInventory(Book book) async {
    await _booksService.addBookToInventory(
      userId: _authService.getUidofCurrentUser(),
      bookList: widget.name,
      book: Book(
        id: book.id,
        title: book.title,
        author: book.author,
        imageUrl: book.imageUrl,
        description: book.description,
        rating: book.rating,
        year: book.year,
        pages: book.pages,
      ),
    );
    Navigator.pop(context);
  }

  List<Widget>? bookListWidget() {
    List<Widget> widgetList = [];
    for (Book book in bookList) {
      widgetList.add(Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          book.title,
                          style: TextStyle(fontSize: 16),
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _addBookToInventory(book),
                          child: Text('Add'),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.white60,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            primary: Color.fromARGB(255, 144, 92, 76),
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ));
    }
    return widgetList;
  }
}
