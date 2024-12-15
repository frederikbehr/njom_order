class Item {
  final String id;
  final String title;
  final String description;
  final double price;
  final String? imageURL;
  final String category;

  const Item({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageURL,
    required this.category,
  });

  @override
  String toString() => "$id::$title::$description::$price::$imageURL::$category";
}