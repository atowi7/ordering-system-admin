import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_routes.dart';
import 'package:ordering_system_admin/design_system/app_text.dart';
import 'package:ordering_system_admin/enhancedmaterialapp.dart';
import 'package:ordering_system_admin/services/sharedpreference_service.dart';
import 'package:ordering_system_admin/views/auth/login/screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ordering_system_admin/views/home/screen.dart';
import 'firebase_options.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// SystemChrome.setE([]);


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();
      final token = await _sharedPreferenceService.getData('bearerToken');
      print('token $token');
  bool isLoggedIn =
      await _sharedPreferenceService.getData('bearerToken') != null
          ? true
          : false;
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return EnhancedMaterialApp(
      child: MaterialApp(
        title: AppText.appName,
        // theme: AppTheme.theme,
        home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
        routes: AppRoutes.routes,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
