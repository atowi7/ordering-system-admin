import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';

class Heading extends StatelessWidget {
  final String title;
  const Heading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      child: Text(title,
          style:
             AppTheme.headText),
    );
  }
}
