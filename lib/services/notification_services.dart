import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ordering_system_admin/design_system/app_routes.dart';
import 'package:ordering_system_admin/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationServices.instance._setupFlutterNotifications();
  await NotificationServices.instance._showNotification(message);
  await NotificationServices.instance._saveNotification(message);
}

class NotificationServices {
  NotificationServices._();
  static final NotificationServices instance = NotificationServices._();
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  late AndroidNotificationChannel channel;
  bool isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission
    await _requestPermission();

    // Setup message handlers
    await _setupMessageHandlers();

    // Get FCM token
    await getDeviceToken();
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  Future<String?> getDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('Device token: $token');
    return token;
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    print('Subscribed to topic: $topic');
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    print('Unsubscribed from topic: $topic');
  }

  void _handleMessage(RemoteMessage message) {
    print('Handling a message: ${message.messageId}');
    navigatorKey.currentState?.pushNamed(AppRoutes.home);
  }

  // static Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   print("Handling a background message: ${message.messageId}");
  // }

  Future<void> _setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios setup
    final initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification: (id, title, body, payload) async {
      //   print('Received local notification while app is in foreground!');
      // },
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // flutter notification setup
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );

    isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> _showNotification(RemoteMessage message) async {
        await _setupFlutterNotifications(); 
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  Future<void> _setupMessageHandlers() async {
    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Received a message while in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        await _showNotification(message);
        _saveNotification(message);
      }
    });

    // Handle notifications when the app is opened from a terminated state
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Handle notifications when the app is opened from the background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  Future<void> _saveNotification(RemoteMessage message) async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = prefs.getStringList('notifications') ?? [];
    final notificationData = {
      'title': message.notification?.title,
      'body': message.notification?.body,
    };
    notifications.add(jsonEncode(notificationData));
    await prefs.setStringList('notifications', notifications);
  }

  Future<List<Map<String, String>>> getSavedNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = prefs.getStringList('notifications') ?? [];
    return notifications
        .map((e) => Map<String, String>.from(jsonDecode(e)))
        .toList();
  }

  Future<void> deleteNotification(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = prefs.getStringList('notifications') ?? [];
    if (index >= 0 && index < notifications.length) {
      notifications.removeAt(index);
      await prefs.setStringList('notifications', notifications);
    }
  }
}
