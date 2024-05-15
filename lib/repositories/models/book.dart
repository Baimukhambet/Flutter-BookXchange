class Book {
  final String name;
  // final Category category;
  final String imageUrl;
  // final String author;

  Book({
    required this.name,
    required this.imageUrl,
    // required this.author,
  });

  @override
  String toString() {
    // TODO: implement toString
    return 'Book: $name';
  }
}

enum Category {
  all,
  science,
  fiction,
  nonfiction;
}
