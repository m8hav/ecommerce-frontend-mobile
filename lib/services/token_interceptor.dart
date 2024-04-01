import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mobile/main.dart';
import 'package:mobile/utils/auth_utils.dart';
import 'package:mobile/utils/constants.dart';

import '../screens/common/login_screen.dart';

class TokenInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    String? token = (await getUserDetails())[authTokenKey];
    if (token != null) {
      data.headers['Authorization'] = 'Bearer $token';
      data.headers['Content-Type'] = 'application/json';
      data.headers['ngrok-skip-browser-warning'] = '69420';
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 401) {
      await deleteAll();
      // move to login screen
      navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
    return data;
  }
}
