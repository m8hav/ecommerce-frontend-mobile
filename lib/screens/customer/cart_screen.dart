import 'package:flutter/material.dart';
import 'package:mobile/components/product_list_item.dart';
import 'package:mobile/models/cart.dart';
import 'package:mobile/screens/customer/checkout_screen.dart';
import 'package:mobile/services/cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String title = 'Cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<Cart> cart;

  @override
  void initState() {
    super.initState();
    refreshCart();
  }

  void refreshCart() {
    setState(() {
      cart = getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Cart>(
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
                    refreshCart: refreshCart,
                    updatable: true,
                    linkable: true,
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckoutScreen(),
                      ),
                    );
                  },
                  child: const Text('Checkout'),
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        }
      },
    );
  }
}
