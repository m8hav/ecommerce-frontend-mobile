import 'package:flutter/material.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/services/cart_service.dart';

import '../screens/customer/product_landing_screen.dart';
import '../services/product_service.dart';

class ProductListItem extends StatefulWidget {
  final productInfo;

  final Function? refreshCart;

  const ProductListItem({
    super.key,
    required this.productInfo,
    this.refreshCart,
    this.updatable = true,
    this.linkable = true,
  });

  final bool updatable;
  final bool linkable;

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  Product? product;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    Product currentProduct = await getProductById(widget.productInfo.productId);
    setState(() {
      product = currentProduct;
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        child: ListTile(
          leading: Image.network(
            widget.productInfo.imageUrl,
            width: 50,
            height: 50,
          ),
          title: Text(
            widget.productInfo.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text('\$${widget.productInfo.price.toStringAsFixed(2)}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  const Text('Quantity'),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.updatable)
                          IconButton(
                            icon: const Icon(Icons.remove),
                            iconSize: 20,
                            onPressed: () async {
                              await updateProductQuantityInCart(
                                  widget.productInfo.productId,
                                  widget.productInfo.quantity - 1);
                              widget.refreshCart!();
                            },
                          ),
                        Text(
                          widget.productInfo.quantity.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                        if (widget.updatable)
                          Opacity(
                            opacity:
                                product!.stock == widget.productInfo.quantity
                                    ? 0.5
                                    : 1,
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              iconSize: 20,
                              onPressed:
                                  product!.stock == widget.productInfo.quantity
                                      ? null
                                      : () async {
                                          await updateProductQuantityInCart(
                                              widget.productInfo.productId,
                                              widget.productInfo.quantity + 1);
                                          widget.refreshCart!();
                                        },
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (widget.updatable)
                IconButton(
                  icon: const Icon(Icons.delete),
                  iconSize: 20,
                  onPressed: () async {
                    await removeProductFromCart(widget.productInfo.productId);
                    widget.refreshCart!();
                  },
                ),
            ],
          ),
          onTap: () {
            if (widget.linkable) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductLandingScreen(
                    productId: widget.productInfo.productId,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
