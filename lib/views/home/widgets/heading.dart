import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';

class Heading extends StatelessWidget {
  final String title;
  const Heading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(title,
          style:
             AppTheme.homeHead),
    );
  }
}
