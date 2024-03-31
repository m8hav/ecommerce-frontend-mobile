import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/utils/constants.dart';

// function to give flutter secure storage instance
FlutterSecureStorage getSecureStorage() {
  return const FlutterSecureStorage();
}

Future<void> saveUserDetails(String authToken, String userRole) async {
  final secureStorage = getSecureStorage();
  await secureStorage.write(key: authTokenKey, value: authToken);
  await secureStorage.write(key: userRoleKey, value: userRole);
}

Future<Map<String, String?>> getUserDetails() async {
  final secureStorage = getSecureStorage();
  String? token = await secureStorage.read(key: authTokenKey);
  String? role = await secureStorage.read(key: userRoleKey);
  return {authTokenKey: token, userRoleKey: role};
}

Future<String> getUserRole() async {
  final secureStorage = getSecureStorage();
  String? role = await secureStorage.read(key: userRoleKey);
  return role ?? '';
}

Future<void> deleteAll() async {
  final secureStorage = getSecureStorage();
  await secureStorage.deleteAll();
}

// function to give request headers
Future<Map<String, String>> getRequestHeaders() async {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'ngrok-skip-browser-warning': '69420',
  };
  // add Authorization header if token is available
  String? token = await getSecureStorage().read(key: authTokenKey);
  if (token != null) {
    requestHeaders['Authorization'] = 'Bearer $token';
  }
  return requestHeaders;
}