import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';

class CustomNotificationCard extends StatelessWidget {
  final String title;
  final String text;
  final String createdAt;
  final VoidCallback onDelete;
  const CustomNotificationCard(
      {super.key,
      required this.title,
      required this.text,
      required this.createdAt,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      // width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTheme.cardItem),
          Text(text, style: AppTheme.cardItem),
          Text(createdAt, style: AppTheme.cardItem),
          IconButton(
            icon: const Icon(Icons.delete_forever_rounded, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
