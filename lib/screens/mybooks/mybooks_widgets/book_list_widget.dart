import 'package:book_time/screens/mybooks/mybooks_widgets/book_inventory.dart';
import 'package:book_time/services/auth_services.dart';
import 'package:book_time/services/books_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookView extends StatefulWidget {
  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  final listNameController = TextEditingController();
  final _authService = AuthService();
  final _booksService = BooksService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
                                    await _booksService.deleteWholeBookList(
                                      bookList: ds.id,
                                      context: context,
                                    );
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
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
    );
  }
}
