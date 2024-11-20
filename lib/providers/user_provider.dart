import 'package:flutter/material.dart';
import 'package:ordering_system_admin/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final _loginFormKey = GlobalKey<FormState>();
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

  Future<void> login()async{
    if(_loginFormKey.currentState!.validate()){
      _isLoading =true;
      notifyListeners();
    }
  }
}
