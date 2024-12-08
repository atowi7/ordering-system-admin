import 'package:flutter/material.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/views/home/manager/manager.dart';
import 'package:ordering_system_admin/views/home/widgets/orderitem.dart';

class OrderList extends StatelessWidget {
  final List<OrderModel> orders;
  const OrderList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    HomeManager manager = HomeManager(context: context);
    return Expanded(
      child: ListView.builder(
        // shrinkWrap: true,
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Column(
            children: [
              OrderItem(
                order: order,
                onShowChangeOrderStatusDialog: () {
                  manager.showChangeOrderStatusDialog(order.id);
                },
              ),
              const Divider(
                color: Colors.black,
                thickness: 0.4,
                height: 2,
              ),
            ],
          );
        },
      ),
    );
  }
}
