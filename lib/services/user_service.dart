import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';

import 'package:mobile/models/user.dart';
import 'package:mobile/services/token_interceptor.dart';
import 'package:mobile/utils/constants.dart';

final client = HttpClientWithInterceptor.build(interceptors: [TokenInterceptor()]);

// GET User
Future<User> getUser() async {
  final response = await client.get(
    Uri.parse('$backendBaseUrl/user'),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw 'Failed to get user details';
  }
}

// Update User
Future<User> updateUser(User user) async {
  final response = await client.put(
    Uri.parse('$backendBaseUrl/user'),
    body: jsonEncode(user),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw 'Failed to update user details';
  }
}

// Delete User
Future deleteUser() async {
  final response = await client.delete(
    Uri.parse('$backendBaseUrl/user'),
  );

  if (response.statusCode == 200) {
    return;
  } else {
    throw 'Failed to delete user';
  }
}