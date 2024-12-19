import 'package:flutter/material.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:provider/provider.dart';

class HomeManager {
  final BuildContext context;
  late final OrderProvider _orderProvider;
  // late List<OrderModel>? orders;
  // List<OrderModel>? sortedOrders;
  late List<Map<String, dynamic>>? orderStatusList = [];
  bool isRefresh = true;

  HomeManager({required this.context}) {
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);
  }

  Future<void> loadData() async {
    await _loadOrders();
    await _loadOrderStatuses();
    isRefresh = false;
  }

  Future<void> _loadOrders() async {
    await _orderProvider.getOrders();
    // orders = _orderProvider.orders;
  }

  Future<void> _loadOrderStatuses() async {
    await _orderProvider.getOrderStatuses();
    orderStatusList = _orderProvider.orderStatusList;
    print('_loadOrderStatuses() $orderStatusList');
  }

  Future<void> onRefresh() async {
    isRefresh = true;
    _orderProvider.onRefresh();
  }

  void sortOrders(String? selectedSort) {
    isRefresh = false;
    _orderProvider.sortOrders(context, selectedSort);
  }

  void filterOrders(
      String? selectedFilterStatus, String? selectedFilterPayment) {
    isRefresh = false;
    _orderProvider.filterOrders(
        context, selectedFilterStatus, selectedFilterPayment);
  }

  void resetSort() {
    isRefresh = true;
    _orderProvider.resetSort();
  }

  void resetFilter() {
    isRefresh = true;
    _orderProvider.resetFilter();
  }

  void showChangeOrderStatusDialog(
      int orderId, List<Map<String, dynamic>> orderStatusList) {
    _orderProvider.showChangeOrderStatusDialog(
        context, orderId, orderStatusList);
  }

  Future<void> changeOrderStatus(int orderId, String? newStatus) async {
    _orderProvider.changeOrderStatus(context, orderId, newStatus);
  }

  void showBottomSheetForSort() {
    _orderProvider.showBottomSheetForSort(context);
  }

  void showBottomSheetForFilter() {
    _orderProvider.showBottomSheetForFilter(context);
  }
}


// void updateSelectedStatus(String? newSelected) {
  //   _orderProvider.updateSelectedStatus(newSelected);
  // }

  // void updateSelectedFilterStatus(String? newSelected) {
  //   _orderProvider.updateSelectedFilterStatus(newSelected);
  // }

  // void updateSelectedFilterPayment(String? newSelected) {
  //   _orderProvider.updateSelectedFilterPayment(newSelected);
  // }

  // void updateSelectedSort(String? newSort) {
  //   _orderProvider.updateSelectedSort(newSort);
  // }
