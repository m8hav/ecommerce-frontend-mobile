import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:mobile/models/user.dart';
import 'package:mobile/utils/auth_utils.dart';
import 'package:mobile/utils/constants.dart';

// GET User
Future<User> getUser() async {
  final response = await http.get(
    Uri.parse('$backendBaseUrl/user'),
    headers: await getRequestHeaders(),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw 'Failed to get user details';
  }
}

// Update User
Future<User> updateUser(User user) async {
  final response = await http.put(
    Uri.parse('$backendBaseUrl/user'),
    body: jsonEncode(user),
    headers: await getRequestHeaders(),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw 'Failed to update user details';
  }
}

// Delete User
Future deleteUser() async {
  final response = await http.delete(
    Uri.parse('$backendBaseUrl/user'),
    headers: await getRequestHeaders(),
  );

  if (response.statusCode == 200) {
    return;
  } else {
    throw 'Failed to delete user';
  }
}