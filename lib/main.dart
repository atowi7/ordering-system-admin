import 'package:flutter/material.dart';
import 'package:ordering_system_admin/constant/app_routes.dart';
import 'package:ordering_system_admin/enhanced_material_app.dart';
import 'package:ordering_system_admin/views/auth/login/screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EnhancedMaterialApp(
      child: MaterialApp(
        title: 'Ordering System Admin',
        theme: ThemeData(
          primaryColor: const Color(0xFF8a3ab9),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.w900),
            displayMedium: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
            displaySmall: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w200),
          ),
        ),
        home: const LoginScreen(),
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
