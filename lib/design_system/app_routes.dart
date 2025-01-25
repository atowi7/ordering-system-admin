import 'package:flutter/material.dart';
import 'package:ordering_system_admin/views/home/screen.dart';
import 'package:ordering_system_admin/views/auth/login/screen.dart';
import 'package:ordering_system_admin/views/notification/screen.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const notification = '/notification';
  // static const orderDetails = '/orderDetails';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    notification: (context) => const NotificationScreen(),
    // orderDetails: (context) => const OrderDetailScreen(),
  };
}
