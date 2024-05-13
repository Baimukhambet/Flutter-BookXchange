class Book {
  final String name;
  // final Category category;
  final String imageUrl;

  Book({required this.name, required this.imageUrl});

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
