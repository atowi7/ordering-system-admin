import 'dart:convert';

import 'package:ordering_system_admin/design_system/app_links.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:ordering_system_admin/services/auth_services.dart';

class OrderService {
  Future<List<OrderModel>?>? getOrders() async {
    final token = await AuthServices.getToken();
    if (token == null) {
      return null;
    }

    final response = await http.get(
      Uri.parse(AppLinks.orders),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (jsonData['success']) {
        List<dynamic> ordersData = jsonData['data']['orders'];
        final List<OrderModel> orders = ordersData.map((order) {
          // print('orderData$order');

          return OrderModel.fromJson(order);
        }).toList();

        return orders;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<OrderModel?>? getOrderDetails(int orderId) async {
    final token = await AuthServices.getToken();
    if (token == null) {
      return null;
    }

    final response = await http.get(
      Uri.parse('${AppLinks.orders}/$orderId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
         Map<String, dynamic> jsonData = jsonDecode(response.body);
     
      if (jsonData['success']) {
        final orderData = jsonData['data'];
        print('orderDetails $orderData');
        final order = OrderModel.fromJson(orderData);

        return order;
      }
      } catch (e) {
        print(e);
      }
     
      return null;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getOrderStatuses() async {
    final response = await http.get(
      Uri.parse(AppLinks.orderStatuses),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];

      final List<Map<String, dynamic>> statuses =
          data.whereType<Map<String, dynamic>>().map((item) {
        return item.map((key, value) => MapEntry(key, value));
      }).toList();

      print(statuses);

      return statuses;
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
    final token = await AuthServices.getToken();
    if (token == null) {
      return false;
    }

    final response =
        await http.post(Uri.parse(AppLinks.orderStatusUpdate), headers: {
      'Authorization': 'Bearer $token',
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
