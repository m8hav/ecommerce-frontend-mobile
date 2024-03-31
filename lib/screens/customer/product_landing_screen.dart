import 'package:flutter/material.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/screens/main_navigation_hub.dart';
import 'package:mobile/services/cart_service.dart';
import 'package:mobile/services/product_service.dart';

import '../../models/cart.dart';

class ProductLandingScreen extends StatefulWidget {
  final int productId;

  const ProductLandingScreen({super.key, required this.productId});

  @override
  State<ProductLandingScreen> createState() => _ProductLandingScreenState();
}

class _ProductLandingScreenState extends State<ProductLandingScreen> {
  late bool isAlreadyInCart = false;
  Product? product;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    Product currentProduct = await getProductById(widget.productId);
    final Cart cart = await getCart();
    setState(() {
      product = currentProduct;
      isAlreadyInCart = cart.cartProducts
          .any((element) => element.productId == widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(product!.name),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Image.network(product!.imageUrl), // Display product image
                const SizedBox(height: 16.0),
                Text(
                  product!.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ), // Display product name
                const SizedBox(height: 16.0),
                Text(
                  product!.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ), // Display product description
                const SizedBox(height: 16.0),
                Text(
                  '\$${product!.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16.0),
                product!.stock > 0
                    ? ElevatedButton(
                        onPressed: () async {
                          if (!isAlreadyInCart) {
                            await addProductToCart(product!.id);
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MainNavigationHub(page: 1),
                            ),
                          );
                        },
                        child: Text(
                            isAlreadyInCart ? 'Go to Cart' : 'Add to Cart'),
                      )
                    : ElevatedButton(
                        onPressed: () {}, child: const Text('Out of Stock')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
