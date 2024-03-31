import 'package:flutter/material.dart';
import 'package:mobile/services/user_service.dart';

import '../../models/user.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const String title = 'Edit Profile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User? user;
  late TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    User currentUser = await getUser();
    nameController.text = currentUser.name!;
    setState(() {
      user = currentUser;
    });
  }

  void saveChanges() async {
    await updateUser(User(name: nameController.text));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(EditProfileScreen.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                )),
            const Divider(),
            ElevatedButton(
              onPressed: saveChanges,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
