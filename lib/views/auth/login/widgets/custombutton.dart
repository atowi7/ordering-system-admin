import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_routes.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final  VoidCallback login;
  const CustomButton({super.key, required this.text, required this.login});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: login,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
        child: Text(
          text,
          style: AppTheme.loginBtn,
        ),
      ),
    );
  }
}
