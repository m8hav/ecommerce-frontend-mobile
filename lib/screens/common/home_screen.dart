import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/product_card.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/screens/admin/add_product_screen.dart';
import 'package:mobile/services/product_service.dart';

import '../../utils/auth_utils.dart';

class HomeScreen extends StatefulWidget {
  static const String title = 'Home';

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Product>>? products;
  String? userRole;

  @override
  void initState() {
    super.initState();
    products = getProducts();
    initialize();
  }

  Future<void> initialize() async {
    String? role = await getUserRole();
    setState(() {
      userRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    final carouselImages = [
      'img1.png',
      'img2.png',
      'img3.jpg',
      'img4.jpg',
    ];

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const SizedBox(height: 10),
              if (userRole == 'USER')
                CarouselSlider(
                  options: CarouselOptions(height: 80.0),
                  items: carouselImages.map((img) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: const BoxDecoration(color: Colors.amber),
                          child: Image.asset('assets/carousel/$img',
                              fit: BoxFit.cover),
                        );
                      },
                    );
                  }).toList(),
                ),
              if (userRole == 'ADMIN')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddProductScreen())),
                    child: const Text("Add Product"),
                  ),
                ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    userRole == 'USER'
                        ? 'Popular Products'
                        : 'Available Products',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
        FutureBuilder<List<Product>>(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ProductCard(
                        index: index, snapshot: snapshot, userRole: userRole!);
                  },
                  childCount: snapshot.data!.length,
                ),
              );
            } else if (snapshot.hasError) {
              return SliverFillRemaining(
                child: Text("${snapshot.error}"),
              );
            }

            // By default, show a loading spinner.
            return const SliverFillRemaining(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}
