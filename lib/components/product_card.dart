import 'package:flutter/material.dart';
import 'package:mobile/screens/customer/product_landing_screen.dart';

import '../screens/admin/edit_product_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.index,
    required this.snapshot,
    required this.userRole,
  });

  final int index;
  final snapshot;
  final String userRole;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 160,
            child: Image.network(snapshot.data![index].imageUrl,
                fit: BoxFit.contain),
          ),
          const SizedBox(height: 10),
          Text(
            snapshot.data![index].name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text('\$${snapshot.data![index].price.toStringAsFixed(2)}'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                  userRole == 'USER' ?
                      ProductLandingScreen(
                    productId: snapshot.data![index].id,
                  ) : EditProductScreen(productId: snapshot.data![index].id),
                ),
              );
            },
            child: Text(userRole == 'USER' ? 'View' : 'Edit'),
          ),
        ],
      ),
    );
  }
}
