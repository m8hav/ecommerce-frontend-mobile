import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/services/token_interceptor.dart';

final client = HttpClientWithInterceptor.build(interceptors: [TokenInterceptor()]);

// GET products
Future<List<Product>> getProducts() async {
  final response = await client.get(
    Uri.parse('$backendBaseUrl/products'),
  );

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<Product> products = Product.fromJsonList(body);
    return products;
  } else {
    throw 'Failed to load products';
  }
}

// GET product by ID
Future<Product> getProductById(int id) async {
  final response = await client.get(
    Uri.parse('$backendBaseUrl/product/$id'),
  );

  if (response.statusCode == 200) {
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw 'Failed to load product';
  }
}

// POST product
Future<Product> createProduct(Product product) async {
  final response = await client.post(
    Uri.parse('$backendBaseUrl/products'),
    body: jsonEncode(product.toJson()),
  );

  if (response.statusCode == 201) {
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw 'Failed to create product';
  }
}

// PUT product
Future<Product> updateProduct(Product product) async {
  final response = await client.put(
    Uri.parse('$backendBaseUrl/products/${product.id}'),
    body: jsonEncode(product.toJson()),
  );

  if (response.statusCode == 200) {
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw 'Failed to update product';
  }
}

// DELETE product
Future<void> deleteProduct(int id) async {
  final response = await client.delete(
    Uri.parse('$backendBaseUrl/products/$id'),
  );

  if (response.statusCode != 204) {
    throw 'Failed to delete product';
  }
}
