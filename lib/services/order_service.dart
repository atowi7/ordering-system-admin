import 'dart:convert';

import 'package:ordering_system_admin/design_system/app_links.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future<List<OrderModel>?> getOrders() async {
    final response = await http.get(Uri.parse(AppLinks.orderList));

    if (response.statusCode == 200) {
      List<dynamic> date = jsonDecode(response.body);
      return date.map((order) => OrderModel.fromJson(order)).toList();
    } else {
      return null;
    }
  }

  Future<List<OrderModel>?> getOrderDetials() async {
    final response = await http.get(
      Uri.parse(AppLinks.orderDetails),
    );

    if (response.statusCode == 200) {
      List<dynamic> date = jsonDecode(response.body);
      return date.map((order) => OrderModel.fromJson(order)).toList();
    } else {
      return null;
    }
  }

  Future<void> upadateOrderStatus(String orderId) async {
    final response = await http.post(Uri.parse(AppLinks.orderStatusUpdate),
        body: {'orderid': orderId});

    if (response.statusCode == 200) {
      final date = jsonDecode(response.body);
    } else {}
  }

  Future<List<String>?> getOrderStatuses() async {
    final response = await http.get(
      Uri.parse(AppLinks.orderDetails),
    );
    if (response.statusCode == 200) {
      List<String> date = jsonDecode(response.body);
      return date;
    } else {
      return null;
    }
  }
}
