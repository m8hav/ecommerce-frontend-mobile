import 'package:flutter/material.dart';
import 'package:mobile/components/product_list_item.dart';
import 'package:mobile/screens/customer/product_landing_screen.dart';

import '../../models/order.dart';
import '../../services/order_service.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, required this.orderId});

  static const String title = 'Order #';
  final int orderId;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future<Order>? order;

  @override
  void initState() {
    super.initState();
    order = getOrder(widget.orderId);
  }

  void moveToProductLandingScreen(int productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductLandingScreen(
          productId: productId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Order>(
      future: order,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Order order = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Column(
                children: [
                  Text('${OrderScreen.title}${order.id}'),
                  Text(
                    '${order.date.toLocal()}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            body: ListView(
              children: [
                const SizedBox(height: 10),
                Column(
                  children: order.orderProducts.map((product) {
                    return ProductListItem(
                      productInfo: product,
                      updatable: false,
                      linkable: true,
                    );
                  }).toList(),
                ),
                const Divider(),
                const SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: order.orderProducts.map((product) {
                    return ListTile(
                      title: Text(
                        product.name,
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: Text(
                        '\$${(product.price * product.quantity).toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                ),
                ListTile(
                  title: const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    '\$${order.total.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Address',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(order.address),
                ),
                ListTile(
                  title: const Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(order.paymentMethod),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        }
      },
    );
  }
}
