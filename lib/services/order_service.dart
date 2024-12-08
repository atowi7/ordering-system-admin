import 'dart:convert';

import 'package:ordering_system_admin/design_system/app_links.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future<List<OrderModel>?> getOrders() async {
    final response = await http.get(
      Uri.parse(AppLinks.orders),
      headers: {
        'Authorization': AppLinks.token,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> ordersData = jsonData['data']['orders'];
      return ordersData
          .map((orderJson) => OrderModel.fromJson(orderJson))
          .toList();
    } else {
      return null;
    }
  }

  Future<List<Map<String, int>>?> getOrderStatuses() async {
    final response = await http.get(
      Uri.parse(AppLinks.orderStatuses),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> date = jsonDecode(response.body);
      final List<Map<String, int>> statues = date['data'];
      return statues;
    } else {
      return null;
    }
  }

  // Future<OrderModel?> getOrderDetials(int orderId) async {
  //   final response = await http.get(
  //     Uri.parse('${AppLinks.orders}?$orderId'),
  //   );

  //   if (response.statusCode == 200) {
  //     final date = jsonDecode(response.body);
  //     return OrderModel.fromJson(date);
  //   } else {
  //     return null;
  //   }
  // }

  Future<bool> upadateOrderStatus(int orderId, String newStatus) async {
    final response =
        await http.post(Uri.parse(AppLinks.orderStatusUpdate), headers: {
      'Authorization': AppLinks.token,
    }, body: {
      "order_id": orderId,
      "new_status": newStatus
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
