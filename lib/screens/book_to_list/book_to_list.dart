import 'package:book_time/models/book.dart';
import 'package:book_time/screens/mybooks/mybooks_widgets/book_inventory.dart';
import 'package:book_time/services/auth_services.dart';
import 'package:book_time/services/books_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookToList extends StatefulWidget {
  const BookToList({required this.book});

  final Book book;

  @override
  State<BookToList> createState() => _BookToListState();
}

class _BookToListState extends State<BookToList> {
  final listNameController = TextEditingController();
  final _authService = AuthService();
  final _booksService = BooksService();
  final _tecBookListName = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tecBookListName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 144, 92, 76),
        title: Text('Book List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createBookList(),
        child: const Icon(Icons.add_outlined),
        backgroundColor: Color.fromARGB(255, 144, 92, 76),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("books_list")
            .doc(_authService.getUidofCurrentUser())
            .collection("books_list")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null) {
              return Center(
                  child: Text("Books list is empty.",
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookInventory(
                                  name: ds.id,
                                ),
                              ),
                            );
                          },
                          child: Card(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Text(ds.id,
                                        style: TextStyle(fontSize: 16))),
                                Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () async {
                                      _addBookToInventory(widget.book, ds.id);
                                    },
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 144, 92, 76),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ))),
                    );
                  },
                );
              } else {
                return Center(
                    child: Text(
                  "Books list is empty.",
                  style: TextStyle(fontSize: 16),
                ));
              }
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _addBookToInventory(Book book, String bookList) async {
    await _booksService.addBookToInventory(
      userId: _authService.getUidofCurrentUser(),
      bookList: bookList,
      context: context,
      hasShow: true,
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
  }

  Future<void> _createBookList() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create book list'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _tecBookListName,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Create'),
              onPressed: () async {
                BooksService bookService = BooksService();
                AuthService authService = AuthService();
                await bookService.addBookList(
                    userId: authService.getUidofCurrentUser(),
                    context: context,
                    tecBookListName: _tecBookListName);
              },
            ),
          ],
        );
      },
    );
  }
}
