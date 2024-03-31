import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/models/cart.dart';
import 'package:mobile/utils/auth_utils.dart';
import 'package:mobile/utils/constants.dart';

// Get cart
Future<Cart> getCart() async {
  final response = await http.get(
    Uri.parse('$backendBaseUrl/cart'),
    headers: await getRequestHeaders(),
  );
  if (response.statusCode == 200) {
    return Cart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load cart');
  }
}

// Add product to cart
Future<Cart> addProductToCart(int productId) async {
  final response = await http.post(
    Uri.parse('$backendBaseUrl/cart/$productId'),
    headers: await getRequestHeaders(),
  );
  if (response.statusCode == 200) {
    return Cart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to add product to cart');
  }
}

// Update product quantity in cart
Future<Cart> updateProductQuantityInCart(int productId, int quantity) async {
  final response = await http.put(
    Uri.parse('$backendBaseUrl/cart'),
    body: jsonEncode({
      'productId': productId,
      'quantity': quantity,
    }),
    headers: await getRequestHeaders(),
  );
  if (response.statusCode == 200) {
    return Cart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update product quantity in cart');
  }
}

// Remove product from cart
Future<Cart> removeProductFromCart(int productId) async {
  final response = await http.delete(
    Uri.parse('$backendBaseUrl/cart/$productId'),
    headers: await getRequestHeaders(),
  );
  if (response.statusCode == 200) {
    return Cart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to remove product from cart');
  }
}

// Clear cart
Future<Cart> clearCart() async {
  final response = await http.delete(
    Uri.parse('$backendBaseUrl/cart'),
    headers: await getRequestHeaders(),
  );
  if (response.statusCode == 200) {
    return Cart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to clear cart');
  }
}
