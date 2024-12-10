import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderDetailsManager {
  final BuildContext context;
  late OrderModel? order;
  OrderProvider get _orderProvider =>
      Provider.of<OrderProvider>(context, listen: false);

  OrderDetailsManager({required this.context});

  Future<void> getOrderDetails(int orderId) async {
    await _orderProvider.getOrderDetails(orderId);
    order = _orderProvider.order;
  }

  int getStatusIndex(String status) {
    return _orderProvider.getStatusIndex(status);
  }

  Future<void> changeOrderStatus(int orderId) async {
    String currentStatus = order!.status!;

    String? nextStatus;
    switch (currentStatus) {
      case 'Pending':
        nextStatus = 'Preparing';
        break;
      case 'Preparing':
        nextStatus = order!.serviceType == 'Delivery'
            ? 'Out for Delivery'
            : 'Ready for Pickup';
        break;
      case 'Ready for Pickup':
      case 'Out for Delivery':
        nextStatus = 'Completed';
        break;
      default:
        print('Unexpected status: $currentStatus');
        break;
    }

    if (nextStatus != null) {
      String response =
          await _orderProvider.changeOrderStatus(orderId, nextStatus);
      if (response == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                'Status changed to $nextStatus',
                style: AppTheme.successText,
              ),
              backgroundColor: AppColors.primaryColor),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                'Failed to change status',
                style: AppTheme.errorText,
              ),
              backgroundColor: AppColors.primaryColor),
        );
      }
    }

    Navigator.pop(context);
  }
}
