import 'package:flutter/material.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:provider/provider.dart';

class Manager {
  late List<OrderModel> orders;
  late OrderProvider _orderProvider;

  // Manager(BuildContext context) {
  // }
  Future<void> loadOrders(BuildContext context) async {
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orders = await _orderProvider.getOrders();
  }

  void showBottomSheetForSort(BuildContext context) {
    _orderProvider.showBottomSheetForSort(context);
  }

  void showBottomSheetForFilter(BuildContext context) {
    _orderProvider.showBottomSheetForFilter(context);
  }
}
