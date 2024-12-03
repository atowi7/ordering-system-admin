import 'package:flutter/material.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:ordering_system_admin/views/home/widgets/changeorderstatus_diaog.dart';
import 'package:ordering_system_admin/views/orderdetail_screen.dart';
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
                Text(order.id,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w900)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(order.status ?? 'Pendng',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.w900,
                                color: Colors.grey[400])),
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
                      child: Text('Change',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.blue,
                                height: 1,
                                decoration: TextDecoration.underline,
                              )),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Username',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                Text(order.username,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w800, color: Colors.grey[400])),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Phone number',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                Text(order.phoneNumber,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w800, color: Colors.grey[400])),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Branch',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                Text(order.branch,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w800, color: Colors.grey[400])),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payment method',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                Text(order.paymentMethod,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w800, color: Colors.grey[400])),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Service',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                Text(order.service,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w800, color: Colors.grey[400])),
              ],
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey[400], thickness: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Invoice',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(height: 1, fontWeight: FontWeight.w600)),
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
                    label: Text('View document',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.w800,
                                height: 1,
                                color: Colors.grey[400])),
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