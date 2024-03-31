import 'package:mobile/models/order_product.dart';

class Order {
  int id;
  int userId;
  double total;
  String address;
  String paymentMethod;
  DateTime date;
  List<OrderProduct> orderProducts;

  Order({
    required this.id,
    required this.userId,
    required this.total,
    required this.address,
    required this.paymentMethod,
    required this.date,
    required this.orderProducts,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      total: json['total'],
      address: json['address'],
      paymentMethod: json['paymentMethod'],
      date: DateTime.parse(json['date']),
      orderProducts: (json['orderProducts'] as List)
          .map((json) => OrderProduct.fromJson(json))
          .toList(),
    );
  }
}
