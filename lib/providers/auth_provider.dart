import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_routes.dart';
import 'package:ordering_system_admin/models/user_model.dart';
import 'package:ordering_system_admin/services/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  final _loginFormKey = GlobalKey<FormState>();
  final AuthServices _authServices = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  UserModel? _userModel;
  bool _isLoading = false;

  GlobalKey<FormState> get loginFormKey => _loginFormKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  UserModel? get userModel => _userModel;
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

  Future<void> login(
      BuildContext context) async {
    if (_loginFormKey.currentState!.validate()) {
      _isLoading = true;

      final UserModel? userModel =
          await _authServices.login(_emailController.text, _passwordController.text);
      if (userModel != null) {
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        }

      }
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    bool isLogout = await _authServices.logout();
    if (isLogout) {
      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.login, (Route<dynamic> route) => false);
      }
    }
  }
}
