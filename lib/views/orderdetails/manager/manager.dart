import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderDetailsManager {
  final BuildContext context;
  final int? orderId;
  late final OrderProvider _orderProvider;
  late OrderModel? order;
  late List<Map<String, dynamic>>? orderStatusList = [];

  OrderDetailsManager({required this.context, this.orderId})
      : _orderProvider = Provider.of<OrderProvider>(context, listen: false);

  Future<void> loadData() async {
    await _loadOrderDetails(orderId!);
    await _loadOrderStatuses();
  }

  Future<void> _loadOrderDetails(int orderId) async {
    await _orderProvider.getOrderDetails(orderId);
    order = _orderProvider.order;
  }

  Future<void> _loadOrderStatuses() async {
    await _orderProvider.getOrderStatuses();
    orderStatusList = _orderProvider.orderStatusList;
    // print('orderStatusList $orderStatusList');
  }

  int getStatusIndex(String status) {
    return _orderProvider.getStatusIndex(status);
  }

  Future<void> changeOrderStatus(int orderId) async {
    String currentStatus = order!.status!;
    // print('currentStatus $currentStatus');

    String? nextStatus;
    switch (currentStatus) {
      case 'PENDING':
        nextStatus = 'PREPARING';
        break;
      case 'PREPARING':
        nextStatus =
            order!.serviceType == 'Delivery' ? 'OUT_FOR_DELIVERY' : 'READY';
        break;
      case 'READY':
      case 'OUT_FOR_DELIVERY':
        nextStatus = 'COMPLETED';
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                'No other status to change to.',
                style: AppTheme.successText,
              ),
              backgroundColor: AppColors.primaryColor),
        );
        break;
    }

    if (nextStatus != null) {
      await _orderProvider.changeOrderStatus(context, orderId, nextStatus);
    }
  }
}
