import 'package:flutter/material.dart';
import 'package:ordering_system_admin/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileManager {
  final BuildContext context;
  late final AuthProvider _authProvider;
  String username = 'Unknown';
  String email = 'Unknown';
  String createdAt = 'Unknown';
  bool isRefresh = true;

  ProfileManager({required this.context}) {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  Future<void> loadUserData() async {
    final user = await _authProvider.getUser();
    if (user != null) {
      username = user.name;
      email = user.email;
      createdAt = user.createdAt.toIso8601String().substring(0, 10);
    }
  }

  Future<void> logout() async {
    await _authProvider.logout(context);
  }
}
