import 'package:book_time/services/db_interactions.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  final String description;
  final String rating;
  final String year;
  final String pages;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.year,
    required this.pages,
  });

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
      'description': description,
      'rating': rating,
      'year': year,
      'pages': pages,
    };
  }
}

final bestSellerList = [
  Book(
      id: 'b345',
      title: 'The Last Thing He Told Me',
      author: 'Laura Dave',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1603034599l/54981009.jpg',
      description:
          "We all have stories we never tell. Before Owen Michaels disappears, he manages to smuggle a note to his beloved wife of one year: Protect her.",
      rating: '3.97',
      year: '2021',
      pages: '320'),
  Book(
      id: 'b378',
      title: 'The Four Winds',
      author: 'Kristin Hannah',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1594925043l/53138081.jpg',
      description:
          "Texas, 1934. Millions are out of work and a drought has broken the Great Plains. Farmers are fighting to keep their land and their livelihoods as the crops are failing, the water is drying up, and dust threatens to bury them all. One of the darkest periods of the Great Depression, the Dust Bowl era, has arrived with a vengeance.",
      rating: '4.33',
      year: '2021',
      pages: '464'),
  Book(
      id: 'b549',
      title: 'People We Meet on Vacation',
      author: 'Emily Henry',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618913179l/54985743.jpg',
      description:
          "Two best friends. Ten summer trips. One last chance to fall in love.",
      rating: '4.13',
      year: '2021',
      pages: '364'),
  Book(
      id: 'b342',
      title: 'American Marxism',
      author: 'Mark R. Levin',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1624319161l/57873303.jpg',
      description:
          "The six-time #1 New York Times bestselling author, Fox News star, and radio host Mark R. Levin explains how the dangers he warned against in the “timely yet timeless” (David Limbaugh, author of Jesus Is Risen) bestseller Liberty and Tyranny have come to pass.",
      rating: '4.36',
      year: '2021',
      pages: '317'),
  Book(
      id: 'b656',
      title: 'Malibu Rising',
      author: 'Taylor Jenkins Reid',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618293107l/55404546.jpg',
      description:
          "Four famous siblings throw an epic party to celebrate the end of the summer. But over the course of twenty-four hours, their lives will change forever.",
      rating: '4.13',
      year: '2021',
      pages: '369'),
];
final greatestBooksList = [
  Book(
      id: 'b721',
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1320399351l/1885.jpg',
      description:
          "Since its immediate success in 1813, Pride and Prejudice has remained one of the most popular novels in the English language.",
      rating: '4.27',
      year: '1813',
      pages: '279'),
  Book(
      id: 'b328',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1490528560l/4671._SY475_.jpg',
      description:
          "The Great Gatsby, F. Scott Fitzgerald's third book, stands as the supreme achievement of his career. This exemplary novel of the Jazz Age has been acclaimed by generations of readers.",
      rating: '3.93',
      year: '1925',
      pages: '200'),
  Book(
      id: 'b872',
      title: '1984',
      author: 'George Orwell',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1532714506l/40961427._SX318_.jpg',
      description:
          "Among the seminal texts of the 20th century, Nineteen Eighty-Four is a rare work that grows more haunting as its futuristic purgatory becomes more real.",
      rating: '4.19',
      year: '1949',
      pages: '298'),
  Book(
      id: 'b726',
      title: 'Crime and Punishment',
      author: 'Fyodor Dostoevsky',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1382846449l/7144.jpg',
      description:
          "Raskolnikov, a destitute and desperate former student, wanders through the slums of St Petersburg and commits a random murder without remorse or regret.",
      rating: '4.23',
      year: '1866',
      pages: '671'),
  Book(
      id: 'b251',
      title: 'Moby-Dick or, the Whale',
      author: 'Herman Melville',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1327940656l/153747.jpg',
      description:
          "Moby-Dick is the story of an eerily compelling madman pursuing an unholy war against a creature as vast and dangerous and unknowable as the sea itself.",
      rating: '3.52',
      year: '1851',
      pages: '654'),
];

var extended_list = bestSellerList + greatestBooksList;

// Admins function. To be used to update the database in the given format
void add_books_to_db() {
  // extending the lists here. ! Not checking for uniqueness.
  var extended_list = bestSellerList + greatestBooksList;
  extended_list.forEach((element) {
    addAllBooks(element);
  });
}
