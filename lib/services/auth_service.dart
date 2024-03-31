import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/models/user.dart';
import 'package:mobile/utils/auth_utils.dart';
import 'package:mobile/utils/constants.dart';

// SignUp
Future<User> signUp(String name, String email, String password) async {
  final response = await http.post(
    Uri.parse('$backendBaseUrl/auth/signup'),
    body: jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    }),
    headers: await getRequestHeaders(),
  );

  if (response.statusCode == 200) {
    login(
      email,
      password,
    ); // Login after sign up

    return User.fromJson(jsonDecode(response.body));
  } else {
    throw 'Failed to sign up';
  }
}

// Login
Future login(String email, String password) async {
  final response = await http.post(
    Uri.parse('$backendBaseUrl/auth/login'),
    body: jsonEncode({
      'email': email,
      'password': password,
    }),
    headers: await getRequestHeaders(),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    saveUserDetails(
      data['token'],
      data['role'],
    );
  } else {
    throw 'Failed to login';
  }
}
