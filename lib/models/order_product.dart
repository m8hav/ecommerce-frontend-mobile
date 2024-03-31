class OrderProduct {
  int? id;
  int productId;
  String name;
  String imageUrl;
  double price;
  int quantity;

  OrderProduct({
    this.id,
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'],
      productId: json['productId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }

}