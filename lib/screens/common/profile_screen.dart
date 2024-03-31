import 'package:flutter/material.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/screens/common/change_password_screen.dart';
import 'package:mobile/screens/common/edit_profile_screen.dart';
import 'package:mobile/screens/common/login_screen.dart';
import 'package:mobile/screens/customer/orders_screen.dart';
import 'package:mobile/services/user_service.dart';
import 'package:mobile/utils/auth_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String title = 'Profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<User>? user;

  @override
  void initState() {
    super.initState();
    user = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null) {
          return const Text('No data');
        } else {
          User user = snapshot.data!;
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Name: ${user.name}'),
              ),
              ListTile(
                title: Text('Email: ${user.email}'),
              ),
              const Divider(),
              if (user.role == 'USER')
                ListTile(
                  title: const Text('View Orders'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrdersScreen()),
                    );
                  },
                ),
              ListTile(
                title: const Text('Edit Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Change Password'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen()),
                  );
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () async {
                  await deleteAll();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Delete Account'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
