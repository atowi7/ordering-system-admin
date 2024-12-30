import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? onLogout;
  const ProfileAppBar({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: onLogout,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
