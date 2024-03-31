import 'package:mobile/models/cart_product.dart';

class Cart {
  final int id;
  final int userId;
  final double total;
  final List<CartProduct> cartProducts;

  Cart({
    required this.id,
    required this.userId,
    required this.total,
    required this.cartProducts,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final cartProducts = <CartProduct>[];
    if (json['cartProducts'] != null) {
      json['cartProducts'].forEach((v) {
        cartProducts.add(CartProduct.fromJson(v));
      });
    }

    return Cart(
      id: json['id'],
      userId: json['userId'],
      total: json['total'],
      cartProducts: cartProducts,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['total'] = total;
    data['cartProducts'] = cartProducts.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return 'Cart{id: $id, userId: $userId, total: $total, cartProducts: $cartProducts}';
  }

  static Cart mockCart = Cart(
    id: 1,
    userId: 1,
    total: 100.0,
    cartProducts: CartProduct.mockCartProducts,
  );

}