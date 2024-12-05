import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:provider/provider.dart';

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
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final isActive = orderProvider.getStatusIndex(title) <=
        orderProvider.getStatusIndex(currentStatus);
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
