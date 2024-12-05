import 'dart:convert';

import 'package:ordering_system_admin/design_system/app_links.dart';
import 'package:ordering_system_admin/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserServices {
  Future<UserModel?> login(String email, String password) async {
    final response = await http.post(Uri.parse(AppLinks.login),body: {
      'email' :email,
      'passowrd':password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      return null;
    }
  }
  Future<void> logout() async {
    final response = await http.post(Uri.parse(AppLinks.logout));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
    }else{
      
    }
  }
}
