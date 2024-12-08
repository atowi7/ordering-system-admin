import 'package:flutter/material.dart';
import 'package:ordering_system_admin/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthManager {
  final BuildContext context;

  AuthManager(this.context);

  AuthProvider get authProvider =>
      Provider.of<AuthProvider>(context, listen: false);

     
    
  Future<void> login() async {
    
    await authProvider.login(context);
  }

  Future<void> logout() async {
    await authProvider.logout(context);
  }
}
