import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/customseparator.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/customstatus.dart';
import 'package:provider/provider.dart';

class CustomProgress extends StatelessWidget {
  final OrderModel order;
  const CustomProgress({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
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
          Consumer<OrderProvider>(builder: (context, provider, child) {
            return Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomStatus(
                    context: context,
                    title: 'Pending',
                    currentStatus: order.status!),
                const CustomSeparator(),
                const CustomSeparator(),
                const CustomSeparator(),
                CustomStatus(
                    context: context,
                    title: 'Preparing',
                    currentStatus: order.status!),
                const CustomSeparator(),
                const CustomSeparator(),
                const CustomSeparator(),
                CustomStatus(
                    context: context,
                    title: 'Ready for pickup',
                    currentStatus: order.status!),
                const CustomSeparator(),
                const CustomSeparator(),
                const CustomSeparator(),
                CustomStatus(
                    context: context,
                    title: 'Pick up',
                    currentStatus: order.status!),
              ],
            );
          })
        ],
      ),
    );
  }
}
