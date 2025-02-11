import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:ordering_system_admin/design_system/app_links.dart';
import 'package:ordering_system_admin/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:ordering_system_admin/services/notification_services.dart';
import 'package:ordering_system_admin/services/sharedpreference_service.dart';

class AuthServices {
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();

  // Updated threshold: 30 days in milliseconds.
  static const int tokenRefreshInterval = 30 * 24 * 60 * 60 * 1000;

  String getDeviceLanguage() {
    final locale = ui.window.locale;
    return locale.languageCode;
  }

  Future<UserModel?> login(String email, String password) async {
    final String? fcmToken =
        await NotificationServices.instance.getDeviceToken();
    final String deviceLanguage = getDeviceLanguage();

    final response = await http.post(Uri.parse(AppLinks.login), headers: {
      'Accept': 'application/json',
      'Accept-Language': deviceLanguage,
    }, body: {
      'email': email,
      'password': password,
      'token': fcmToken ?? 'null',
      'device': Platform.isIOS ? '1' : '2'
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // final String username = data['data']['admin']['name'];
      // final String email = data['data']['admin']['email'];
      // final String createdAt = data['data']['admin']['created_at'];
      final user = data['data']['admin'];
      final String bearerToken = data['data']['authorization']['token'];

      // print('auth $username');
      // print('auth $email');
      // print('auth $createdAt');
      print('auth bearerToken $bearerToken');

      await _sharedPreferenceService.storeData('user', jsonEncode(user));
      await _sharedPreferenceService.storeData(
          'bearerToken', jsonEncode(bearerToken));

      if (fcmToken != null) {
        await _sharedPreferenceService.storeData('fcmToken', fcmToken);
        await _sharedPreferenceService.storeData(
            'lastTokenUpdate', DateTime.now().millisecondsSinceEpoch);
      }

      await NotificationServices.instance.initialize();
      // await _sharedPreferenceService.storeData('fcmToken', fcmToken ?? 'null');
      // await NotificationServices.instance.checkTokenFreshness();

      return UserModel.fromJson(user);
    } else {
      // print('failed');
      return null;
    }
  }

  // Check if the token's last update is stale (older than 30 days)
  bool _isTokenStale() {
    final lastUpdated =
        _sharedPreferenceService.getData('lastTokenUpdate') as int?;
    if (lastUpdated == null) return true;
    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        tokenRefreshInterval;
  }

  Future<bool> updateDeviceToken(String newToken) async {
    final String? bearerToken =
        await _sharedPreferenceService.getData('bearerToken');
    final String? storedToken =
        await _sharedPreferenceService.getData('fcmToken');

    if (bearerToken == null) return false;

    // Even if the token hasn't changed, update if it's stale.
    if (newToken == storedToken && !_isTokenStale()) return true;

    try {
      final String deviceLanguage = getDeviceLanguage();
      final response = await http.post(
        Uri.parse(AppLinks.updateToken),
        headers: {
          'Authorization': 'Bearer ${bearerToken.replaceAll('"', '')}',
          'Accept': 'application/json',
          'Accept-Language': deviceLanguage,
        },
        body: {
          'token': newToken,
          'device': Platform.isIOS ? '1' : '2',
        },
      );

      if (response.statusCode == 200) {
        await _sharedPreferenceService.storeData('fcmToken', newToken);
        await _sharedPreferenceService.storeData(
            'lastTokenUpdate', DateTime.now().millisecondsSinceEpoch);
        print(
            'Token updated on server. lastTokenUpdate: ${DateTime.now().millisecondsSinceEpoch}');
        return true;
      } else if (response.statusCode == 401 ||
          response.statusCode == 404 ||
          response.statusCode == 400) {
        await _handleInvalidToken();
        return false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // bool _isTokenExpired() {
  //   final lastUpdated =
  //       _sharedPreferenceService.getData('lastTokenUpdate') as int?;
  //   if (lastUpdated == null) return true;

  //   // 270 days in milliseconds
  //   const daysInMillis = 270 * 24 * 60 * 60 * 1000;
  //   return DateTime.now().millisecondsSinceEpoch - lastUpdated > daysInMillis;
  // }

  Future<void> _handleInvalidToken() async {
    await _sharedPreferenceService.clearData('fcmToken');
    // await _sharedPreferenceService.clearData('bearerToken');
    print('_handleInvalidToken');
  }

  Future<bool> logout() async {
    final token = await _sharedPreferenceService.getData('bearerToken');
    final String deviceLanguage = getDeviceLanguage();
    final response = await http.post(
      Uri.parse(AppLinks.logout),
      headers: {
        'Authorization': 'Bearer ${token.replaceAll('"', '')}',
        'Accept': 'application/json',
        'Accept-Language': deviceLanguage,
      },
    );

    if (response.statusCode == 200) {
      // Delete the FCM token
      await NotificationServices.instance.deleteDeviceToken();

      // Clear user data from shared preferences
      bool isCleared = await _sharedPreferenceService.clearAll();
      print('isCleared $isCleared');
      return true;
    } else {
      return false;
    }
  }
}
