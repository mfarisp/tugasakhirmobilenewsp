class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;

  var category;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price, required String category,
  });

  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    return Product(
      id: documentId,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0).toDouble(), category: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
    };
  }
}
