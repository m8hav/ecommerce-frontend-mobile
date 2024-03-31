import 'package:flutter/material.dart';
import 'package:mobile/utils/auth_utils.dart';

import './common/home_screen.dart';
import './common/profile_screen.dart';
import './customer/cart_screen.dart';

class MainNavigationHub extends StatefulWidget {
  const MainNavigationHub({super.key, this.page = 0});

  final String title = HomeScreen.title;
  final int page;

  @override
  State<MainNavigationHub> createState() => _MainNavigationHubState();
}

class _MainNavigationHubState extends State<MainNavigationHub> {
  int selectedPageIndex = 0;

  List<Widget> pages = <Widget>[
    const HomeScreen(),
    const ProfileScreen(),
  ];

  List<NavigationDestination> destinations = <NavigationDestination>[
    const NavigationDestination(
      icon: Icon(Icons.home),
      label: HomeScreen.title,
    ),
    const NavigationDestination(
      icon: Icon(Icons.person),
      label: ProfileScreen.title,
    ),
  ];

  @override
  void initState() {
    super.initState();
    initialize();
    setState(() {
      selectedPageIndex = widget.page;
    });
  }

  Future<void> initialize() async {
    String? userRole = await getUserRole();
    if (userRole == 'USER') {
      setState(() {
        destinations.insert(
          1,
          const NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: CartScreen.title,
          ),
        );
        pages.insert(1, const CartScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset('assets/logos/maf_carrefour_logo_small.png'),
        ),
        title: Text(destinations[selectedPageIndex].label),
        centerTitle: true,
      ),
      body: pages[selectedPageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedPageIndex,
        destinations: destinations,
        onDestinationSelected: (int index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
      ),
    );
  }
}
