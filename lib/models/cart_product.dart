class CartProduct {
final int id;
  final int productId;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;

  CartProduct({
    required this.id,
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      productId: json['productId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  CartProduct copyWith({
    int? id,
    int? productId,
    String? name,
    String? imageUrl,
    double? price,
    int? quantity,
  }) {
    return CartProduct(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  String toString() {
    return 'CartProduct{id: $id, productId: $productId, name: $name, imageUrl: $imageUrl, price: $price, quantity: $quantity}';
  }

  static List<CartProduct> fromJsonList(List<dynamic> jsonList) {
    List<CartProduct> cartProducts = [];
    for (var json in jsonList) {
      cartProducts.add(CartProduct.fromJson(json));
    }
    return cartProducts;
  }

  static List<Map<String, dynamic>> toJsonList(List<CartProduct> cartProducts) {
    List<Map<String, dynamic>> cartProductsJson = [];
    for (var cartProduct in cartProducts) {
      cartProductsJson.add(cartProduct.toJson());
    }
    return cartProductsJson;
  }

  static List<CartProduct> mockCartProducts = [
    CartProduct(
      id: 1,
      productId: 1,
      name: 'Product 1',
      imageUrl: 'img1.png',
      price: 10.0,
      quantity: 1,
    ),
    CartProduct(
      id: 2,
      productId: 2,
      name: 'Product 2',
      imageUrl: 'img2.png',
      price: 20.0,
      quantity: 2,
    ),
    CartProduct(
      id: 3,
      productId: 3,
      name: 'Product 3',
      imageUrl: 'img3.jpg',
      price: 30.0,
      quantity: 3,
    ),
    CartProduct(
      id: 4,
      productId: 4,
      name: 'Product 4',
      imageUrl: 'img4.jpg',
      price: 40.0,
      quantity: 4,
    ),
  ];
}