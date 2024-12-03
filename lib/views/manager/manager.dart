import 'package:flutter/material.dart';
import 'package:ordering_system_admin/main.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:provider/provider.dart';

class Manager {
 
  late List<OrderModel> orders;
  final orderProvider =
      Provider.of<OrderProvider>(navigatorKey.currentContext!, listen: false);
  
   
  Manager._loadOrders() {
    orders = orderProvider.getorders();
  }

  factory Manager() {
    return Manager._loadOrders();
  }

  void showBottomSheetForSort() {
    orderProvider.showBottomSheetForSort(navigatorKey.currentContext!);
  }

  void showBottomSheetForFilter() {
    orderProvider.showBottomSheetForFilter(navigatorKey.currentContext!);
  }
}
