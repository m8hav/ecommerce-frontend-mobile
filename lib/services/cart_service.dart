import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:mobile/models/cart.dart';
import 'package:mobile/services/token_interceptor.dart';
import 'package:mobile/utils/constants.dart';

final client = HttpClientWithInterceptor.build(interceptors: [TokenInterceptor()]);

// Get cart
Future<Cart> getCart() async {
  final response = await client.get(
    Uri.parse('$backendBaseUrl/cart'),
  );
  if (response.statusCode == 200) {
    return Cart.fromJson(jsonDecode(response.body));
  } else {
    return Cart(id: -1, userId: -1, total: 0, cartProducts: []);
    // throw Exception('Failed to load cart');
  }
}

// Add product to cart
Future<Cart> addProductToCart(int productId) async {
  final response = await client.post(
    Uri.parse('$backendBaseUrl/cart/$productId'),
  );
  if (response.statusCode == 200) {
    return Cart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to add product to cart');
  }
}

// Update product quantity in cart
Future<Cart> updateProductQuantityInCart(int productId, int quantity) async {
  final response = await client.put(
    Uri.parse('$backendBaseUrl/cart'),
    body: jsonEncode({
      'productId': productId,
      'quantity': quantity,
    }),
  );
  if (response.statusCode == 200) {
    return Cart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update product quantity in cart');
  }
}

// Remove product from cart
Future<Cart> removeProductFromCart(int productId) async {
  final response = await client.delete(
    Uri.parse('$backendBaseUrl/cart/$productId'),
  );
  if (response.statusCode == 200) {
    return Cart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to remove product from cart');
  }
}

// Clear cart
Future<Cart> clearCart() async {
  final response = await client.delete(
    Uri.parse('$backendBaseUrl/cart'),
  );
  if (response.statusCode == 200) {
    return Cart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to clear cart');
  }
}
