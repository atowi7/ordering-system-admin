import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';

class CustomStatus extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String currentStatus;
  final bool isActive;
  const CustomStatus(
      {super.key,
      required this.context,
      required this.title,
      required this.currentStatus,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    // print('isActive $title $isActive');
   
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Colors.green : Colors.grey),
          child: const Icon(Icons.check, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 5),
        Text(
         title,
          style: isActive
              ? AppTheme.orderDetailsOrderStatusTitleopt1
              : AppTheme.orderDetailsOrderStatusTitleopt2,
        ),
      ],
    );
  }
}
