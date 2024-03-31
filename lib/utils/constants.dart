import 'dart:io' show Platform;

String getBackendBaseUrl() {
  if (Platform.isAndroid) {
    return 'http://10.0.2.2:8080/v1';
  } else if (Platform.isIOS) {
    return 'http://localhost:8080/v1';
  } else {
    throw Exception('Unsupported platform');
  }
}

String backendBaseUrl = getBackendBaseUrl();

const authTokenKey = 'auth_token';
const userRoleKey = 'user_role';
