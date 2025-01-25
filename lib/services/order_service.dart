import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_links.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:ordering_system_admin/services/sharedpreference_service.dart';

class OrderService {
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();

  // Stream<List<OrderModel>> getOrders(
  //     BuildContext context, int status, String? payment) async* {
  //   final String token = await _sharedPreferenceService.getData('bearerToken');
  //   while (true) {
  //     try {
  //       final response = await http.get(
  //         Uri.parse("${AppLinks.orders}?status=$status&page=1"),
  //         headers: {
  //           'Authorization': 'Bearer ${token.replaceAll('"', '')}',
  //         },
  //       );

  //       if (response.statusCode == 200) {
  //         Map<String, dynamic> jsonData = jsonDecode(response.body);

  //         if (jsonData['success']) {
  //           List<dynamic> ordersData = jsonData['data']['orders'];
  //           final List<OrderModel> orders = ordersData.map((order) {
  //             return OrderModel.fromJson(order);
  //           }).toList();

  //           yield orders; // Emit the updated list of orders
  //         } else {
  //           final errorMessage = jsonData['message'] ?? 'Unknown error';
  //           print('Error: $errorMessage (Status Code: ${response.statusCode})');
  //           if (context.mounted) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(
  //                 content: Text(
  //                   errorMessage,
  //                   style: AppTheme.errorText,
  //                 ),
  //               ),
  //             );
  //           }
  //         }
  //       } else {
  //         if (context.mounted) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text(
  //                 'An error occurred. Please try again later.',
  //                 style: AppTheme.errorText,
  //               ),
  //             ),
  //           );
  //         }
  //       }
  //       await Future.delayed(Duration(seconds: 5)); // Adjust polling interval
  //     } catch (e) {
  //       if (context.mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               e.toString(),
  //               style: AppTheme.errorText,
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   }
  // }

  Future<List<OrderModel>?>? getOrders(BuildContext context, int status, String? payment) async {
    final String token = await _sharedPreferenceService.getData('bearerToken');
    final response = await http.get(
      Uri.parse("${AppLinks.orders}?status=$status&page=1"),
      headers: {
        'Authorization': 'Bearer ${token.replaceAll('"', '')}',
      },
    );
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

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
        final errorMessage = jsonData['message'] ?? 'Unknown error';
        // print('Error: $errorMessage (Status Code: ${response.statusCode})');
        if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                     errorMessage,
                      style: AppTheme.errorText,
                    ),
                    backgroundColor: AppColors.primaryColor),
              );

            }
        return null;
      }
    } else {
      if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                      'An error occurred. Please try again later.',
                      style: AppTheme.errorText,
                    ),
                    backgroundColor: AppColors.primaryColor),
              );

            }
      }
      return null;
    }

  Future<OrderModel?>? getOrderDetails(int orderId) async {
    final token = await _sharedPreferenceService.getData('bearerToken');
    if (token == null) {
      return null;
    }

    final response = await http.get(
      Uri.parse('${AppLinks.orders}/$orderId'),
      headers: {
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${token.replaceAll('"', '')}',
      },
    );

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData['success']) {
          final orderData = jsonData['data'];
          // print('orderDetails $orderData');
          final order = OrderModel.fromJson(orderData);

          return order;
        } else {
          // final errorMessage = jsonData['message'] ?? 'Unknown error';
          // print('Error: $errorMessage (Status Code: ${response.statusCode})');
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
      try {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['success']) {
          List<dynamic> statusData = jsonData['data'];

          final List<Map<String, dynamic>> statuses =
              statusData.whereType<Map<String, dynamic>>().map((item) {
            return item.map((key, value) => MapEntry(key, value));
          }).toList();

          // print('statuses $statuses');

          return statuses;
        } else {
          // final errorMessage = jsonData['message'] ?? 'Unknown error';
          // print('Error: $errorMessage (Status Code: ${response.statusCode})');
          return null;
        }
      } catch (e) {
        // print(e);
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> changeOrderStatus(int orderId, int newStatus) async {
    final token = await _sharedPreferenceService.getData('bearerToken');
    if (token == null) {
      return false;
    }

    final response =
        await http.post(Uri.parse(AppLinks.orderStatusUpdate), headers: {
      'Authorization': 'Bearer ${token.replaceAll('"', '')}',
    }, body: {
      "order_id": '$orderId',
      "new_status": '$newStatus'
    });

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData['success']) {
          // print('change order status respons : ${jsonData['data']}');
          return true;
        } else {
          // final errorMessage = jsonData['message'] ?? 'Unknown error';
          // print('Error: $errorMessage (Status Code: ${response.statusCode})');
          return false;
        }
      } catch (e) {
        // print(e);
        return false;
      }
    } else {
      // print('Status Code: ${response.body}');
      return false;
    }
  }
}
