import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageService {
  static Future<String> uploadImage(File file) async {
    final ref = FirebaseStorage.instance.ref().child('product_images/${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
