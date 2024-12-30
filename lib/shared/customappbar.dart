import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Icon icon;
  final VoidCallback onPressed;
  const CustomAppBar({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[300],
      actions: [
        IconButton(
            onPressed:onPressed,
            icon: icon),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
