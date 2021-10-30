import 'package:book_time/common/global_snackbar.dart';
import 'package:book_time/models/book.dart';
import 'package:book_time/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BooksService {
  CollectionReference _booksListReference =
      FirebaseFirestore.instance.collection('books_list');
  final _authService = AuthService();

  Future<void> addBookList(
      {required userId,
      required TextEditingController tecBookListName,
      required context}) async {
    await _booksListReference
        .doc(userId)
        .collection('books_list')
        .doc(tecBookListName.text)
        .set({}).then((value) {
      tecBookListName.text = '';
      Navigator.pop(context);
    }).catchError((onError) {
      print(onError);
      GlobalSnackbar.showMessageUsingSnackBar(Colors.red, onError, context);
    });
  }

  Future<void> addBookToInventory({
    required userId,
    required bookList,
    required Book book,
    context,
    bool hasShow = false,
  }) async {
    await _booksListReference
        .doc(userId)
        .collection('books_list')
        .doc(bookList)
        .collection('data')
        .doc(book.title)
        .set(book.toJson())
        .then((value) {
      if (hasShow) {
        GlobalSnackbar.showMessageUsingSnackBar(
            Colors.blue, 'Success: ${book.title} added to the list.', context);
      }
    }).catchError((onError) {
      if (hasShow) {
        GlobalSnackbar.showMessageUsingSnackBar(Colors.blue,
            'Failure: Unable to add ${book.title}. Because $onError', context);
      }
    });
  }

  Future<void> deleteWholeBookList({
    required bookList,
    required context,
  }) async {
    await _booksListReference
        .doc(_authService.getUidofCurrentUser())
        .collection('books_list')
        .doc(bookList)
        .delete()
        .then((value) {
      print('deleted');
    }).catchError((onError) {
      print(onError);
      GlobalSnackbar.showMessageUsingSnackBar(Colors.red, onError, context);
    });
  }

  Future<void> deleteBookFromInventory({
    required bookName,
    required bookList,
    required context,
  }) async {
    await _booksListReference
        .doc(_authService.getUidofCurrentUser())
        .collection('books_list')
        .doc(bookList)
        .collection('data')
        .doc(bookName)
        .delete()
        .then((value) {
      print('deleted');
    }).catchError((onError) {
      print(onError);
      GlobalSnackbar.showMessageUsingSnackBar(Colors.red, onError, context);
    });
  }
}
