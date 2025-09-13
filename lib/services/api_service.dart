// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/product_model.dart';

// class ApiService {
//   static Future<List<Product>> fetchProductsFromApi() async {
//     final response = await http.get(Uri.parse('https://api.example.com/products')); // Ganti dengan API asli

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       return data.map((json) => Product.fromJson(json)).toList();
//     } else {
//       throw Exception('Gagal memuat produk dari API');
//     }
//   }
// }
