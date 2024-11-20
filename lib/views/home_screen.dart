import 'package:flutter/material.dart';
import 'package:ordering_system_admin/constant/app_routes.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:ordering_system_admin/views/orderdetail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                },
                icon: const Icon(Icons.logout_sharp, size: 20)),
          ],
        ),
        backgroundColor: Colors.grey[350],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IconButton(
            //     onPressed: () {},
            //     icon: const Icon(Icons.logout_sharp, size: 20)),
            Text('Order List', style: Theme.of(context).textTheme.displayLarge),
            Expanded(
              child: ListView.builder(
                // shrinkWrap: true,
                itemCount: orderProvider.orders.length,
                itemBuilder: (context, index) {
                  final order = orderProvider.orders[index];
                  return OrderItem(order: order);
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 40,
          // padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                  onPressed: () {
                    orderProvider.showBottomSheetForSort(context);
                  },
                  icon: const Icon(
                    Icons.unfold_more,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: Text('Sort',
                      style: Theme.of(context).textTheme.displaySmall)),
              const VerticalDivider(
                  thickness: 1, width: 1, color: Colors.white),
              TextButton.icon(
                  onPressed: () {
                    orderProvider.showBottomSheetForFilter(context);
                  },
                  icon: const Icon(
                    Icons.filter_alt,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: Text('Filter',
                      style: Theme.of(context).textTheme.displaySmall)),
            ],
          ),
        ),
      ),
    );
  }
}

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
        padding: const EdgeInsets.all(10),
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
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.w700)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(order.status ?? 'Pendng',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Colors.grey[400])),
                    TextButton(
                        onPressed: () {
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
                                .displayMedium!
                                .copyWith(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ))),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Username',
                    style: Theme.of(context).textTheme.displayMedium),
                Text(order.username,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.grey[400])),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Phone number',
                    style: Theme.of(context).textTheme.displayMedium),
                Text(order.phoneNumber,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.grey[400])),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Branch',
                    style: Theme.of(context).textTheme.displayMedium),
                Text(order.branch,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.grey[400])),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payment method',
                    style: Theme.of(context).textTheme.displayMedium),
                Text(order.paymentMethod,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.grey[400])),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Service',
                    style: Theme.of(context).textTheme.displayMedium),
                Text(order.service,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.grey[400])),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.black, thickness: 1),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Invoice',
                    style: Theme.of(context).textTheme.displayMedium!),
                // const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.open_in_new,
                    color: Colors.grey[400],
                  ),
                  iconAlignment: IconAlignment.end,
                  label: Text('View document',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.grey[400])),
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

class ChangeOrderStatusDialog extends StatelessWidget {
  final String? orderId;
  final String? selectedStatus;
  final Function(String?) onStatusChanged;
  final Function(String) onStatusUpdated;
  const ChangeOrderStatusDialog(
      {super.key,
      required this.orderId,
      required this.selectedStatus,
      required this.onStatusUpdated,
      required this.onStatusChanged});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Change Order Status',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge),
      content: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Choose the status that matches the order number $orderId',
                style: Theme.of(context).textTheme.displayMedium),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: Text('Pending',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.grey[400])),
                  value: 'Pending',
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    if (value != null) {
                      onStatusUpdated(value);
                    }
                  },
                ),
                RadioListTile<String>(
                  title: Text('Preparing',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.grey[400])),
                  value: 'Preparing',
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    if (value != null) {
                      onStatusUpdated(value);
                    }
                  },
                ),
                RadioListTile<String>(
                  title: Text('Ready',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.grey[400])),
                  value: 'Ready',
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    if (value != null) {
                      onStatusUpdated(value);
                    }
                  },
                ),
                RadioListTile<String>(
                  title: Text('Completed',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.grey[400])),
                  value: 'Completed',
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    if (value != null) {
                      onStatusUpdated(value);
                    }
                  },
                ),
                RadioListTile<String>(
                  title: Text('Canceled',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.grey[400])),
                  value: 'Canceled',
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    onStatusUpdated(value!);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                if (selectedStatus != null) {
                  onStatusChanged(selectedStatus);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Change',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.white))),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.grey[400]))),
        ),
      ],
    );
  }
}
