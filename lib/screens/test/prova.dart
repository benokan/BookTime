//  Copyright 2020 Bruno D'Luka

import 'package:books_finder/books_finder.dart';

void main(List<String> args) async {
  final books = await queryBooks(
    'horror',
    maxResults: 4,
    printType: PrintType.books,
    orderBy: OrderBy.relevance,
    reschemeImageLinks: true,
  );
  books.forEach((book) {
    final info = book.info;
    print('$info\n');
  });
}
