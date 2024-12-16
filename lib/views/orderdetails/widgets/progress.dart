import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/views/orderdetails/manager/manager.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/customseparator.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/customstatus.dart';

class CustomProgress extends StatelessWidget {
  final OrderModel order;
  final List<Map<String, dynamic>> orderStatusList;
  const CustomProgress(
      {super.key, required this.order, required this.orderStatusList});

  @override
  Widget build(BuildContext context) {
    OrderDetailsManager manager = OrderDetailsManager(context: context);
    // print('Progress $orderStatusList == ${order.status}');
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.translate(
            offset: const Offset(-18, 0),
            child: const Text('order status',
                style: AppTheme.orderStatusProgressHead),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomStatus(
                  context: context,
                  title: orderStatusList[0]['name'],
                  currentStatus: order.status!,
                  isActive:
                      manager.getStatusIndex(orderStatusList[0]['name']) <=
                          manager.getStatusIndex(order.status!)),
              const CustomSeparator(),
              CustomStatus(
                  context: context,
                  title: orderStatusList[1]['name'],
                  currentStatus: order.status!,
                  isActive:
                      manager.getStatusIndex(orderStatusList[1]['name']) <=
                          manager.getStatusIndex(order.status!)),
              const CustomSeparator(),
              CustomStatus(
                  context: context,
                  title: orderStatusList[2]['name'],
                  currentStatus: order.status!,
                  isActive:
                      manager.getStatusIndex(orderStatusList[2]['name']) <=
                          manager.getStatusIndex(order.status!)),
              const CustomSeparator(),
              CustomStatus(
                  context: context,
                  title: orderStatusList[3]['name'],
                  currentStatus: order.status!,
                  isActive:
                      manager.getStatusIndex(orderStatusList[3]['name']) <=
                          manager.getStatusIndex(order.status!)),
              const CustomSeparator(),
              CustomStatus(
                  context: context,
                  title: orderStatusList[4]['name'],
                  currentStatus: order.status!,
                  isActive:
                      manager.getStatusIndex(orderStatusList[4]['name']) <=
                          manager.getStatusIndex(order.status!)),
              const CustomSeparator(),
              CustomStatus(
                  context: context,
                  title: orderStatusList[5]['name'],
                  currentStatus: order.status!,
                  isActive:
                      manager.getStatusIndex(orderStatusList[5]['name']) <=
                          manager.getStatusIndex(order.status!)),
            ],
          ),
        ],
      ),
    );
  }
}
