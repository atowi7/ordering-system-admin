import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ordering_system_admin/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      final prefs = await SharedPreferences.getInstance();
      final lastUpdated = prefs.getInt('lastTokenUpdate') ?? 0;

      const refreshThreshold = 30 * 24 * 60 * 60 * 1000;

      if (DateTime.now().millisecondsSinceEpoch - lastUpdated >
          refreshThreshold) {
        final authService = AuthServices();
        final newToken = await FirebaseMessaging.instance.getToken();
        if (newToken != null) {
          await authService.updateDeviceToken(newToken);
        }
      }

      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
        print('Token refreshed: $newToken');
        final authService = AuthServices();
        await authService.updateDeviceToken(newToken);
      });

      return Future.value(true);
    });
  }

  static Future<void> _scheduleAndroidRefresh() async {
    await Workmanager().registerPeriodicTask(
      "tokenRefreshTask",
      "tokenRefreshTask",
      frequency: Duration(hours: 24),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  static Future<void> _scheduleIOSRefresh() async {
    await Workmanager().registerOneOffTask(
      "tokenRefreshTask",
      "tokenRefreshTask",
      initialDelay: Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      existingWorkPolicy: ExistingWorkPolicy.keep,
      backoffPolicy: BackoffPolicy.exponential,
      backoffPolicyDelay: Duration(minutes: 5),
    );
  }

  static Future<void> initialize() async {
    try {
      // Clear existing tasks first
      // await Workmanager().cancelByTag("tokenRefreshTask");
      // await Workmanager().cancelAll();

      await Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: true,
      );

      if (Platform.isAndroid) {
        await _scheduleAndroidRefresh();
      } else {
        await _scheduleIOSRefresh();
      }
    } catch (e) {
      print("Workmanager Error: ${e.toString()}");
    }
  }
}
