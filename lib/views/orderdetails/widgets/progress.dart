import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/views/home/manager/manager.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/customseparator.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/customstatus.dart';

class CustomProgress extends StatelessWidget {
  final OrderModel order;
  const CustomProgress({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    HomeManager manager = HomeManager(context: context);
    return FutureBuilder(
        future: manager.getOrderStatuses(),
        builder: (context, snapsot) {
          return Container(
            margin: const EdgeInsets.only(bottom: 5),
            // height: MediaQuery.of(context).size.height * .13,
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
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomStatus(
                        context: context,
                        title: manager.orderStatusList?.isNotEmpty ?? false
                            ? manager.orderStatusList![0]['name']
                            : 'Pending',
                        currentStatus: order.status!),
                    const CustomSeparator(),
                    // const CustomSeparator(),
                    // const CustomSeparator(),
                    CustomStatus(
                        context: context,
                        title: manager.orderStatusList?.isNotEmpty ?? false
                            ? manager.orderStatusList![1]['name']
                            : 'Preparing',
                        currentStatus: order.status!),
                    const CustomSeparator(),
                    // const CustomSeparator(),
                    // const CustomSeparator(),
                    CustomStatus(
                        context: context,
                        title: manager.orderStatusList?.isNotEmpty ?? false
                            ? manager.orderStatusList![2]['name']
                            : 'Ready For Pickup',
                        currentStatus: order.status!),
                    const CustomSeparator(),
                    // const CustomSeparator(),
                    // const CustomSeparator(),
                    CustomStatus(
                        context: context,
                        title: manager.orderStatusList?.isNotEmpty ?? false
                            ? manager.orderStatusList![3]['name']
                            : 'Out for Delivery',
                        currentStatus: order.status!),
                    const CustomSeparator(),
                    // const CustomSeparator(),
                    // const CustomSeparator(),
                    CustomStatus(
                        context: context,
                        title: manager.orderStatusList?.isNotEmpty ?? false
                            ? manager.orderStatusList![4]['name']
                            : 'Completed',
                        currentStatus: order.status!),
                    const CustomSeparator(),
                    // const CustomSeparator(),
                    // const CustomSeparator(),
                    CustomStatus(
                        context: context,
                        title: manager.orderStatusList?.isNotEmpty ?? false
                            ? manager.orderStatusList![4]['name']
                            : 'Canceled',
                        currentStatus: order.status!),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
