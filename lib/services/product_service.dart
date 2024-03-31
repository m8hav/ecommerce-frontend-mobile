import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/models/product.dart';
import 'package:mobile/utils/auth_utils.dart';
import 'package:mobile/utils/constants.dart';

// GET products
Future<List<Product>> getProducts() async {
  final response = await http.get(
    Uri.parse('$backendBaseUrl/products'),
    headers: await getRequestHeaders(),
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
  final response = await http.get(
    Uri.parse('$backendBaseUrl/product/$id'),
    headers: await getRequestHeaders(),
  );

  if (response.statusCode == 200) {
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw 'Failed to load product';
  }
}

// POST product
Future<Product> postProduct(Product product) async {
  final response = await http.post(
    Uri.parse('$backendBaseUrl/products'),
    headers: await getRequestHeaders(),
    body: jsonEncode(product.toJson()),
  );

  if (response.statusCode == 201) {
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw 'Failed to create product';
  }
}

// PUT product
Future<Product> putProduct(Product product) async {
  final response = await http.put(
    Uri.parse('$backendBaseUrl/products/${product.id}'),
    headers: await getRequestHeaders(),
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
  final response = await http.delete(
    Uri.parse('$backendBaseUrl/products/$id'),
    headers: await getRequestHeaders(),
  );

  if (response.statusCode != 204) {
    throw 'Failed to delete product';
  }
}
