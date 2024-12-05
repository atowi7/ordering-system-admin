import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_images.dart';


class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
     AppImages.logo,
      width: 120,
      height: 120,
      fit: BoxFit.cover,
    );
  }
}
