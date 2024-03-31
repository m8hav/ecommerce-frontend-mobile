class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as double,
      imageUrl: json['imageUrl'] as String,
      stock: json['stock'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'stock': stock,
      };

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    int? stock,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      stock: stock ?? this.stock,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, stock: $stock}';
  }

  static List<Product> fromJsonList(List<dynamic> jsonList) {
    List<Product> products = [];
    for (var json in jsonList) {
      products.add(Product.fromJson(json));
    }
    return products;
  }

  static List<Map<String, dynamic>> toJsonList(List<Product> products) {
    List<Map<String, dynamic>> jsonList = [];
    for (var product in products) {
      jsonList.add(product.toJson());
    }
    return jsonList;
  }

  static List<Product> mockProducts = [
    Product(
      id: 1,
      name: 'Product 1',
      description: 'Description 1',
      price: 100.0,
      imageUrl: 'https://picsum.photos/250?image=9',
      stock: 10,
    ),
    Product(
      id: 2,
      name: 'Product 2',
      description: 'Description 2',
      price: 200.0,
      imageUrl: 'https://picsum.photos/250?image=9',
      stock: 20,
    ),
    Product(
      id: 3,
      name: 'Product 3',
      description: 'Description 3',
      price: 300.0,
      imageUrl: 'https://picsum.photos/250?image=9',
      stock: 30,
    ),
    Product(
      id: 4,
      name: 'Product 4',
      description: 'Description 4',
      price: 400.0,
      imageUrl: 'https://picsum.photos/250?image=9',
      stock: 40,
    ),
    Product(
      id: 5,
      name: 'Product 5',
      description: 'Description 5',
      price: 500.0,
      imageUrl: 'https://picsum.photos/250?image=9',
      stock: 50,
    ),
    Product(
      id: 6,
      name: 'Product 6',
      description: 'Description 6',
      price: 600.0,
      imageUrl: 'https://picsum.photos/250?image=9',
      stock: 60,
    ),
    Product(
      id: 7,
      name: 'Product 7',
      description: 'Description 7',
      price: 700.0,
      imageUrl: 'https://picsum.photos/250?image=9',
      stock: 70,
    ),
    Product(
      id: 8,
      name: 'Product 8',
      description: 'Description 8',
      price: 800.0,
      imageUrl: 'https://picsum.photos/250?image=9',
      stock: 80,
    ),
    Product(
      id: 9,
      name: 'Product 9',
      description: 'Description 9',
      price: 900.0,
      imageUrl: 'https://picsum.photos/250?image=9',
      stock: 90,
    ),
    Product(
      id: 10,
      name: 'Product 10',
      description: 'Description 10',
      price: 1000.0,
      imageUrl: 'https://picsum.photos/250?image=9',
      stock: 100,
    ),
    Product(
      id: 11,
      name: 'Product 11',
      description: 'Description 11',
      price: 1100.0,
      imageUrl: 'https://picsum.photos/250?image=9',
      stock: 110,
    ),
    Product(
      id: 12,
      name: 'Product 12',
      description: 'Description 12',
      price: 1200.0,
      imageUrl: 'https://picsum.photos/250?image=9',
      stock: 120,
    ),
  ];
}
