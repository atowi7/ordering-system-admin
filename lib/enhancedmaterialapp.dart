import 'package:flutter/material.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:ordering_system_admin/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EnhancedMaterialApp extends StatelessWidget {
  final Widget child;
  const EnhancedMaterialApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => OrderProvider()),
    ], child: child);
  }
}
