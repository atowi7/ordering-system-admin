import 'package:flutter/material.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:ordering_system_admin/views/orders/manager/manager.dart';
import 'package:ordering_system_admin/views/orders/widgets/orderitem.dart';
import 'package:provider/provider.dart';

class OrderList extends StatelessWidget {
  final List<OrderModel> orders;
  final List<Map<String, dynamic>> orderStatusList;
  const OrderList(
      {super.key, required this.orders, required this.orderStatusList});

  @override
  Widget build(BuildContext context) {
    OrdersManager manager = OrdersManager(context: context);
    return Consumer<OrderProvider>(
      builder: (context, value, _) {
        return SizedBox(
          height: MediaQuery.of(context).size.height*0.75,
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
                      manager.showChangeOrderStatusDialog(
                          order.id, orderStatusList);
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
      },
    );
  }
}
