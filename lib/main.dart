import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_routes.dart';
import 'package:ordering_system_admin/design_system/app_text.dart';
import 'package:ordering_system_admin/enhancedmaterialapp.dart';
import 'package:ordering_system_admin/views/auth/login/screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ordering_system_admin/views/home/screen.dart';
import 'firebase_options.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EnhancedMaterialApp(
      child: MaterialApp(
        title: AppText.appName,
        // theme: AppTheme.theme,
        home: const HomeScreen(),
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
