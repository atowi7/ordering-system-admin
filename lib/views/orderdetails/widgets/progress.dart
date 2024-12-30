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
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: orderStatusList.length,
              itemBuilder: (context, index) {
                bool showStatus = true;

                if (orderStatusList[index]['name'] == 'Canceled' &&
                    order.status != 'CANCELED') {
                  showStatus = false;
                }

                if (order.serviceType != 'Delivery' &&
                    orderStatusList[index]['name'] == 'Out for Delivery') {
                  showStatus = false;
                }

                return showStatus
                    ? CustomStatus(
                        context: context,
                        title: orderStatusList[index]['name'],
                        currentStatus: order.status!,
                        isActive: manager.getStatusIndex(
                                orderStatusList[index]['name']) <=
                            manager.getStatusIndex(order.status!))
                    : SizedBox.shrink();
              },
              separatorBuilder: (context, index) {
                bool showNextStatus = true;

                if (orderStatusList[index + 1]['name'] == 'Canceled' &&
                    order.status != 'CANCELED') {
                  showNextStatus = false;
                }

                if (order.serviceType != 'Delivery' &&
                    orderStatusList[index + 1]['name'] == 'Out for Delivery') {
                  showNextStatus = false;
                }

                return showNextStatus
                    ? const CustomSeparator()
                    : const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
// [
//               CustomStatus(
//                   context: context,
//                   title: orderStatusList[0]['name'],
//                   currentStatus: order.status!,
//                   isActive:
//                       manager.getStatusIndex(orderStatusList[0]['name']) <=
//                           manager.getStatusIndex(order.status!)),
//               const CustomSeparator(),
//               CustomStatus(
//                   context: context,
//                   title: orderStatusList[1]['name'],
//                   currentStatus: order.status!,
//                   isActive:
//                       manager.getStatusIndex(orderStatusList[1]['name']) <=
//                           manager.getStatusIndex(order.status!)),
//               const CustomSeparator(),
//               CustomStatus(
//                   context: context,
//                   title: orderStatusList[2]['name'],
//                   currentStatus: order.status!,
//                   isActive:
//                       manager.getStatusIndex(orderStatusList[2]['name']) <=
//                           manager.getStatusIndex(order.status!)),
//               const CustomSeparator(),
//               CustomStatus(
//                   context: context,
//                   title: orderStatusList[3]['name'],
//                   currentStatus: order.status!,
//                   isActive:
//                       manager.getStatusIndex(orderStatusList[3]['name']) <=
//                           manager.getStatusIndex(order.status!)),
//               const CustomSeparator(),
//               CustomStatus(
//                   context: context,
//                   title: orderStatusList[4]['name'],
//                   currentStatus: order.status!,
//                   isActive:
//                       manager.getStatusIndex(orderStatusList[4]['name']) <=
//                           manager.getStatusIndex(order.status!)),
//               const CustomSeparator(),
//               CustomStatus(
//                   context: context,
//                   title: orderStatusList[5]['name'],
//                   currentStatus: order.status!,
//                   isActive:
//                       manager.getStatusIndex(orderStatusList[5]['name']) <=
//                           manager.getStatusIndex(order.status!)),
//             ],
