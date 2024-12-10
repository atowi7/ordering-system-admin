import 'package:flutter/material.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:provider/provider.dart';

class HomeManager {
  final BuildContext context;
  late List<OrderModel>? orders;
  late List<Map<String, dynamic>>? orderStatusList =[];
  OrderProvider get _orderProvider =>
      Provider.of<OrderProvider>(context, listen: false);

  HomeManager({required this.context});

  Future<void> getOrders() async {
    await _orderProvider.getOrders();
    orders = _orderProvider.orders;
  }

  Future<void> getOrderStatuses() async {
    await _orderProvider.getOrderStatuses();
    orderStatusList = _orderProvider.orderStatusList;
    print('orderStatusList $orderStatusList');
  }

  void sortOrders() {
    _orderProvider.sortOrders();
  }

  void filterOrders() {
    _orderProvider.filterOrders();
  }

  void resetSort() {
    _orderProvider.resetSort();
  }

  void resetFilter() {
    _orderProvider.resetFilter();
  }

  void showChangeOrderStatusDialog(int orderId) {
    _orderProvider.showChangeOrderStatusDialog(context, orderId);
  }

  void updateSelectedStatus(String? newSelected) {
    _orderProvider.updateSelectedStatus(newSelected);
  }

  void updateSelectedFilterStatus(String? newSelected) {
    _orderProvider.updateSelectedFilterStatus(newSelected);
  }

  void updateSelectedFilterPayment(String? newSelected) {
    _orderProvider.updateSelectedFilterPayment(newSelected);
  }

  void updateSelectedSort(String? newSort) {
    _orderProvider.updateSelectedSort(newSort);
  }

  Future<void> changeOrderStatus(int orderId, String? newStatus) async {
    _orderProvider.changeOrderStatus(orderId, newStatus);
  }

  void showBottomSheetForSort() {
    _orderProvider.showBottomSheetForSort(context);
  }

  void showBottomSheetForFilter() {
    _orderProvider.showBottomSheetForFilter(context);
  }
}
