import 'package:flutter/material.dart';
import 'package:ordering_system_admin/views/home/screen.dart';
import 'package:ordering_system_admin/views/auth/login/screen.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const orderDetails = '/orderDetails';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    // orderDetails: (context) => const OrderDetailScreen(),
  };
}
