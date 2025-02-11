import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_routes.dart';
import 'package:ordering_system_admin/models/user_model.dart';
import 'package:ordering_system_admin/services/auth_services.dart';
import 'package:ordering_system_admin/services/notification_services.dart';
import 'package:ordering_system_admin/services/sharedpreference_service.dart';

class AuthProvider extends ChangeNotifier {
  final _loginFormKey = GlobalKey<FormState>();
  final AuthServices _authServices = AuthServices();
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  UserModel? _user;
  bool _isLoading = false;

  GlobalKey<FormState> get loginFormKey => _loginFormKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This Filed should not be empty';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'This Filed should not be empty';
    }
    return null;
  }

  Future<void> login(BuildContext context) async {
    if (_loginFormKey.currentState!.validate()) {
      _isLoading = true;

      final UserModel? userModel = await _authServices.login(
          _emailController.text, _passwordController.text);
      if (userModel != null) {
        // await NotificationServices.instance.subscribeToTopic('authenticated');
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login failed. Please try again.'),
            ),
          );
        }
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  void onRefresh() {
    notifyListeners();
  }

  Future<UserModel?> getUser() async {
    final userJson = await _sharedPreferenceService.getData('user');
    if (userJson != null) {
      _user = UserModel.fromJson(jsonDecode(userJson));
    }
    return _user;
  }

  Future<void> logout(BuildContext context) async {
    final success = await _authServices.logout();
    if (success) {
      _user = null;
      Navigator.pushNamedAndRemoveUntil(
          // ignore: use_build_context_synchronously
          context,
          AppRoutes.login,
          (route) => false);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logout failed. Please try again.'),
          ),
        );
      }
    }
  }

  Future<void> clearAll() async {
    await _sharedPreferenceService.clearAll();
    _user = null;
    notifyListeners();
  }
}
