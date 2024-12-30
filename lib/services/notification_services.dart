import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:ordering_system_admin/design_system/app_links.dart';
import 'package:ordering_system_admin/models/notification_model.dart';
import 'package:http/http.dart' as http;
import 'package:ordering_system_admin/services/sharedpreference_service.dart';

class NotificationServices {
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
  }

  Future<String?> getDeviceToken() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    return token;
  }

  Future<List<NotificationModel>?>? getNotifiations() async {
    final token = await _sharedPreferenceService.getData('bearerToken');
    if (token == null) {
      return null;
    }

    final statuses = [1, 2, 3, 4, 5, 6];
    final List<NotificationModel> allOrders = [];

    for (final status in statuses) {
      final response = await http.get(
        Uri.parse('${AppLinks.orders}?status=$status'),
        headers: {
'Authorization': 'Bearer ${token.replaceAll('"', '')}',        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData['success']) {
          List<dynamic> ordersData = jsonData['data']['orders'];
          final List<NotificationModel> orders = ordersData.map((order) {
            // print('orderData$order');

            return NotificationModel.fromJson(order);
          }).toList();

          allOrders.addAll(orders);
        } else {
          // final errorMessage = jsonData['message'] ?? 'Unknown error';
          // print('Error: $errorMessage (Status Code: ${response.statusCode})');
          return null;
        }
      } else {
        return null;
      }
    }
    return allOrders;
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    FlutterRingtonePlayer().play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: true,
      volume: 0.1,
      asAlarm: false,
    );
  }

  Future handleBackgroundNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    // FirebaseMessaging.onBackgroundMessage(handleMessage);
  }
}
