import 'package:book_time/screens/mybooks/mybooks_widgets/book_list_widget.dart';
import 'package:book_time/services/auth_services.dart';
import 'package:book_time/services/books_service.dart';
import 'package:flutter/material.dart';

class MyBooksPage extends StatefulWidget {
  const MyBooksPage({Key? key}) : super(key: key);

  @override
  _MyBooksPageState createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage>
    with AutomaticKeepAliveClientMixin {
  final _tecBookListName = TextEditingController();

  @override
  void dispose() {
    _tecBookListName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 144, 92, 76),
        title: Text('My Books'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createBookList(),
        child: const Icon(Icons.add_outlined),
        backgroundColor: Color.fromARGB(255, 144, 92, 76),
      ),
      body: Center(
        child: BookView(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

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
