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
          backgroundColor: Colors.grey[300],
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                },
                icon: const Icon(Icons.logout_sharp, size: 20)),
          ],
        ),
        backgroundColor: Colors.grey[300],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IconButton(
            //     onPressed: () {},
            //     icon: const Icon(Icons.logout_sharp, size: 20)),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('Order List',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 28)),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                // shrinkWrap: true,
                itemCount: orderProvider.orders.length,
                itemBuilder: (context, index) {
                  final order = orderProvider.orders[index];
                  return Column(
                    children: [
                      OrderItem(order: order),
                      const Divider(
                        color: Colors.black,
                        thickness: 0.4,
                        height: 2,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 30,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    orderProvider.showBottomSheetForSort(context);
                  },
                  icon: Transform.translate(
                    offset: const Offset(8, 0),
                    child: const Icon(
                      Icons.unfold_more,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  label: Text('Sort',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          height: 1,
                          fontWeight: FontWeight.w700,
                          color: Colors.white))),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: VerticalDivider(
                    thickness: 1, width: 1, color: Colors.white),
              ),
              TextButton.icon(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    orderProvider.showBottomSheetForFilter(context);
                  },
                  icon: const Icon(
                    Icons.filter_alt,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: Transform.translate(
                    offset: const Offset(-8, 0),
                    child: Text('Filter',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                height: 1,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                  )),
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
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontWeight: FontWeight.w700)),
      content: SizedBox(
        height: 350,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Choose the status that matches the order number $orderId',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w500)),
              RadioListTile<String>(
                title: Transform.translate(
                  offset: const Offset(-16, 0),
                  child: Text('Pending',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 16, color: Colors.grey[500])),
                ),
                value: 'Pending',
                groupValue: selectedStatus,
                fillColor: MaterialStateProperty.all(Colors.grey),
                onChanged: (value) {
                  if (value != null) {
                    onStatusUpdated(value);
                  }
                },
              ),
              Transform.translate(
                offset: const Offset(0, -15),
                child: RadioListTile<String>(
                  title: Transform.translate(
                    offset: const Offset(-16, 0),
                    child: Text('Preparing',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 16, color: Colors.grey[500])),
                  ),
                  value: 'Preparing',
                  groupValue: selectedStatus,
                  fillColor: MaterialStateProperty.all(Colors.grey),
                  onChanged: (value) {
                    if (value != null) {
                      onStatusUpdated(value);
                    }
                  },
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -30),
                child: RadioListTile<String>(
                  title: Transform.translate(
                    offset: const Offset(-16, 0),
                    child: Text('Ready',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 16, color: Colors.grey[500])),
                  ),
                  value: 'Ready',
                  groupValue: selectedStatus,
                  fillColor: MaterialStateProperty.all(Colors.grey),
                  onChanged: (value) {
                    if (value != null) {
                      onStatusUpdated(value);
                    }
                  },
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -45),
                child: RadioListTile<String>(
                  title: Transform.translate(
                    offset: const Offset(-16, 0),
                    child: Text('Completed',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 16, color: Colors.grey[500])),
                  ),
                  value: 'Completed',
                  groupValue: selectedStatus,
                  fillColor: MaterialStateProperty.all(Colors.grey),
                  onChanged: (value) {
                    if (value != null) {
                      onStatusUpdated(value);
                    }
                  },
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -60),
                child: RadioListTile<String>(
                  title: Transform.translate(
                    offset: const Offset(-16, 0),
                    child: Text('Canceled',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 16, color: Colors.grey[500])),
                  ),
                  value: 'Canceled',
                  groupValue: selectedStatus,
                  fillColor: MaterialStateProperty.all(Colors.grey),
                  onChanged: (value) {
                    onStatusUpdated(value!);
                  },
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -50),
                child: SizedBox(
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
                              .displayMedium!
                              .copyWith(color: Colors.white))),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -50),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.grey[400]))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
