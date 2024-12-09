import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/views/orderdetails/manager/manager.dart';

class CustomStatus extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String currentStatus;
  const CustomStatus(
      {super.key,
      required this.context,
      required this.title,
      required this.currentStatus});

  @override
  Widget build(BuildContext context) {
    OrderDetailsManager manager = OrderDetailsManager(context: context);
    final isActive =
        manager.getStatusIndex(title) <= manager.getStatusIndex(currentStatus);
    return Column(
      children: [
        Container(
          width: 25,
          height: 25,
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
