import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ordering_system_admin/design_system/app_links.dart';
import 'package:ordering_system_admin/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getDeviceToken() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    print(token);
    return token;
  }

  Future<UserModel?> login(String email, String password) async {
    final String? token = await getDeviceToken();

    final response = await http.post(Uri.parse(AppLinks.login), headers: {
      'Authorization': AppLinks.token,
    }, body: {
      'email': email,
      'password': password,
      'token': token ?? 'null',
      'device': Platform.isAndroid ? '1' : '2'
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data['data']['admin']);
    } else {
      print('failed');
      return null;
    }
  }

  Future<bool> logout() async {
    final response = await http.post(
      Uri.parse(AppLinks.logout),
      headers: {
        'Authorization': AppLinks.token,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}