class Book {
  final String name;
  final Category category;
  final String imageUrl;

  Book({required this.name, required this.category, required this.imageUrl});
}

enum Category {
  all,
  science,
  fiction,
  nonfiction;
}
