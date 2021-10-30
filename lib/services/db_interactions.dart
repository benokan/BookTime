import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void parseBooks(bookInstance) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user!.uid;

  FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .collection("list3")
      .add({
    'title': bookInstance.title,
    'author': bookInstance.author,
    'imageUrl': bookInstance.imageUrl,
    'description': bookInstance.description,
    'rating': bookInstance.rating,
    'year': bookInstance.year,
    'pages': bookInstance.pages,
  });
}

// Clear books collection from firebase before using.
void addAllBooks(bookInstance) {
  FirebaseFirestore.instance.collection("books").add({
    'title': bookInstance.title,
    'author': bookInstance.author,
    'imageUrl': bookInstance.imageUrl,
    'description': bookInstance.description,
    'rating': bookInstance.rating,
    'year': bookInstance.year,
    'pages': bookInstance.pages,
  });
}

void add_book(book_name, list_name) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user!.uid;

  FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .collection(list_name)
      .doc(book_name)
      .set({'book_name': book_name});

}
