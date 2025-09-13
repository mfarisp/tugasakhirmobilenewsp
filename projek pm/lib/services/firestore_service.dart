import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final _productRef = FirebaseFirestore.instance.collection('products');

  static Future<void> addProduct(String name, String price, String imageUrl) async {
    await _productRef.add({
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    });
  }
}
