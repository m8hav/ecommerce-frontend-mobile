import 'package:flutter/material.dart';
import 'package:mobile/components/product_list_item.dart';
import 'package:mobile/models/cart.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/screens/customer/order_screen.dart';
import 'package:mobile/screens/main_navigation_hub.dart';
import 'package:mobile/services/cart_service.dart';
import 'package:mobile/services/order_service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static const String title = 'Checkout';

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Future<Cart> cart;
  TextEditingController addressController = TextEditingController();
  String paymentMethod = 'COD';

  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  void fetchCart() {
    setState(() {
      cart = getCart();
    });
  }

  void placeOrder() async {
    if (addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your address'),
        ),
      );
      return;
    }
    Order? order;
    try {
      order = await createOrder(
        addressController.text,
        paymentMethod,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to place order'),
        ),
      );
      print(e);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order placed successfully'),
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainNavigationHub(),
      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderScreen(
          orderId: order!.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(CheckoutScreen.title),
        ),
        body: FutureBuilder<Cart>(
          future: cart,
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
                children: [
                  const SizedBox(height: 10),
                  Column(
                    children: snapshot.data!.cartProducts.map((product) {
                      return ProductListItem(
                        productInfo: product,
                        updatable: false,
                        linkable: false,
                      );
                    }).toList(),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Cart Summary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: snapshot.data!.cartProducts.map((product) {
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
                      '\$${snapshot.data!.total.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Payment Method'),
                        DropdownButton<String>(
                          value: paymentMethod,
                          items: const <DropdownMenuItem<String>>[
                            DropdownMenuItem(
                              value: 'Card',
                              enabled: false,
                              child: Text('Credit/Debit Card (Coming soon)'),
                            ),
                            DropdownMenuItem(
                              value: 'COD',
                              child: Text('COD (Cash on Delivery)'),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              paymentMethod = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                    child: ElevatedButton(
                      onPressed: placeOrder,
                      child: const Text('Place Order'),
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}
