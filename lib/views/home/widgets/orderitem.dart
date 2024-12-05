import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:ordering_system_admin/views/home/widgets/changeorderstatus_dialog.dart';
import 'package:ordering_system_admin/views/orderdetails/screen.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;
  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // final orderProvider = Provider.of<OrderProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetailScreen(order: order)));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.id, style: AppTheme.orderItemId),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(order.status ?? 'Pendng',
                        style: AppTheme.orderItemPending),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Consumer<OrderProvider>(
                              builder: (context, provider, child) {
                            return ChangeOrderStatusDialog(
                                orderId: order.id,
                                selectedStatus: provider.selectedStatus,
                                onStatusUpdated: (newStatus) =>
                                    provider.updateSelectedStatus(newStatus),
                                onStatusChanged: (newStatus) => provider
                                    .changeOrderStatus(order.id, newStatus));
                          }),
                        );
                      },
                      child:
                          const Text('Change', style: AppTheme.orderItemChange),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Username', style: AppTheme.orderItemtitle),
                Text(order.username, style: AppTheme.orderItemsubtitle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Phone number', style: AppTheme.orderItemtitle),
                Text(order.phoneNumber, style: AppTheme.orderItemsubtitle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Branch', style: AppTheme.orderItemtitle),
                Text(order.branch, style: AppTheme.orderItemsubtitle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Payment method', style: AppTheme.orderItemtitle),
                Text(order.paymentMethod, style: AppTheme.orderItemsubtitle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Service', style: AppTheme.orderItemtitle),
                Text(order.service, style: AppTheme.orderItemsubtitle),
              ],
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey[400], thickness: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Invoice', style: AppTheme.orderItemsInvoice),
                // const Spacer(),
                SizedBox(
                  height: 20,
                  child: TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    icon: Icon(
                      Icons.open_in_new,
                      size: 20,
                      color: Colors.grey[400],
                    ),
                    iconAlignment: IconAlignment.end,
                    label: const Text('View document',
                        style: AppTheme.orderItemsViewDoc),
                  ),
                )
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                // Text('View document',
                //     style: Theme.of(context)
                //         .textTheme
                //         .displayMedium!
                //         .copyWith(color: Colors.grey[400])),
                // Icon(
                //       Icons.open_in_new,
                //       color: Colors.grey[400],
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
