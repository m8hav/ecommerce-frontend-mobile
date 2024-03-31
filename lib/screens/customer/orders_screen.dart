import 'package:flutter/material.dart';

import '../../models/order.dart';
import '../../services/order_service.dart';
import 'order_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  static const String title = 'Orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future<List<Order>>? orders = getOrders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(OrdersScreen.title),
      ),
      body: FutureBuilder<List<Order>>(
        future: orders,
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
            return ListView(
              children: snapshot.data!.map((order) {
                return Card(
                  child: ListTile(
                    title: Text('Order #${order.id} - ${order.date.toLocal()}'),
                    subtitle: Text('\$${order.total.toStringAsFixed(2)}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderScreen(
                            orderId: order.id,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
