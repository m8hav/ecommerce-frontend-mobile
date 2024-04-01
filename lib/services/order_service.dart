import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/services/token_interceptor.dart';
import 'package:mobile/utils/constants.dart';

final client = HttpClientWithInterceptor.build(interceptors: [TokenInterceptor()]);

// CREATE order
Future<Order> createOrder(String address, String paymentMethod) async {
  final response = await client.post(
    Uri.parse('$backendBaseUrl/order'),
    body: jsonEncode({
      'address': address,
      'paymentMethod': paymentMethod,
    }),
  );

  if (response.statusCode == 200) {
    return Order.fromJson(jsonDecode(response.body));
  } else {
    throw 'Failed to create order';
  }
}

// GET orders
Future<List<Order>> getOrders() async {
  final response = await client.get(
    Uri.parse('$backendBaseUrl/orders'),
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
  final response = await client.get(
    Uri.parse('$backendBaseUrl/order/$orderId'),
  );

  if (response.statusCode == 200) {
    return Order.fromJson(jsonDecode(response.body));
  } else {
    throw 'Failed to get order details';
  }
}
