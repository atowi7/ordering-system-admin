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
  
    final response = await http.post(Uri.parse(AppLinks.login), body: {
      'email': email,
      'password': password,
      // 'token': token ?? 'null',
      'token':
          "dcaiAuPrfEaYphVdJ_q-H8:APA91bFC-BE8WrG9Ty9lbpF7Qs1aRE-zsdIkvYjABvcXZQTziduGeS-QAwaD9C5WgIYe8S5Q1JKjM_YheNod6_CjPOkf7SXF2x-1T7KMppGgTJS0hnO5djI9Zj39ZaOO5s3YGmwd4lhw1",
      'device': '1'
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
    final response = await http.post(Uri.parse(AppLinks.logout));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
