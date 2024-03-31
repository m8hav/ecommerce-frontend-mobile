import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/models/order.dart';
import 'package:mobile/utils/auth_utils.dart';
import 'package:mobile/utils/constants.dart';

// CREATE order
Future<Order> createOrder(String address, String paymentMethod) async {
  final response = await http.post(
    Uri.parse('$backendBaseUrl/order'),
    body: jsonEncode({
      'address': address,
      'paymentMethod': paymentMethod,
    }),
    headers: await getRequestHeaders(),
  );

  if (response.statusCode == 200) {
    return Order.fromJson(jsonDecode(response.body));
  } else {
    print("Order not created with this response: $response");
    throw 'Failed to create order';
  }
}

// GET orders
Future<List<Order>> getOrders() async {
  final response = await http.get(
    Uri.parse('$backendBaseUrl/orders'),
    headers: await getRequestHeaders(),
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((json) => Order.fromJson(json))
        .toList();
  } else {
    throw 'Failed to get orders';
  }
}

// GET order
Future<Order> getOrder(int orderId) async {
  final response = await http.get(
    Uri.parse('$backendBaseUrl/order/$orderId'),
    headers: await getRequestHeaders(),
  );

  if (response.statusCode == 200) {
    return Order.fromJson(jsonDecode(response.body));
  } else {
    throw 'Failed to get order details';
  }
}
