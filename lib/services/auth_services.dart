import 'dart:convert';
import 'dart:io';

import 'package:ordering_system_admin/design_system/app_links.dart';
import 'package:ordering_system_admin/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:ordering_system_admin/services/notification_services.dart';
import 'package:ordering_system_admin/services/sharedpreference_service.dart';

class AuthServices {
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();
  final NotificationServices _notificationServices = NotificationServices();

  Future<UserModel?> login(String email, String password) async {
    final String? token = await _notificationServices.getDeviceToken();

    final response = await http.post(Uri.parse(AppLinks.login),
        // headers: {
        //   'Authorization': AppLinks.token,
        // },
        body: {
          'email': email,
          'password': password,
          'token': token ?? 'null',
          'device': Platform.isAndroid ? '1' : '2'
        });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // final String username = data['data']['admin']['name'];
      // final String email = data['data']['admin']['email'];
      // final String createdAt = data['data']['admin']['created_at'];
      final  user = data['data']['admin'];
      final String token = data['data']['authorization']['token'];

      // print('auth $username');
      // print('auth $email');
      // print('auth $createdAt');
      print('auth $token');

      await _sharedPreferenceService.storeData(
          'user', jsonEncode(user));
      await _sharedPreferenceService.storeData(
          'bearerToken', jsonEncode(token));

      return UserModel.fromJson(user);
    } else {
      // print('failed');
      return null;
    }
  }

  Future<bool> logout() async {
    final token = await _sharedPreferenceService.getData('bearerToken');
    final response = await http.post(
      Uri.parse(AppLinks.logout),
      headers: {
        'Authorization': 'Bearer ${token.replaceAll('"', '')}',        },
    );

    if (response.statusCode == 200) {
     bool isCleared = await _sharedPreferenceService.clearAll();
     print( 'isCleared $isCleared');
      return true;
    } else {
      return false;
    }
  }
}
