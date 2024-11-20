import 'package:flutter/material.dart';
import 'package:ordering_system_admin/constant/app_links.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[350],
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .13,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  Text('Order Details',
                      style: Theme.of(context).textTheme.displayLarge),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .13,
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              // height: MediaQuery.of(context).size.height*0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('order status',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 5),
                  Consumer<OrderProvider>(builder: (context, provider, child) {
                    return Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Spacer(
                          flex: 3,
                        ),
                        _buildStatusWidget(context, 'Pending', order.status!),
                        const Spacer(
                          flex: 1,
                        ),
                        _buildStatusSeparatorWidget(),
                        _buildStatusSeparatorWidget(),
                        _buildStatusSeparatorWidget(),
                        const Spacer(
                          flex: 1,
                        ),
                        _buildStatusWidget(context, 'Preparing', order.status!),
                        _buildStatusSeparatorWidget(),
                        _buildStatusSeparatorWidget(),
                        _buildStatusSeparatorWidget(),
                        const Spacer(
                          flex: 1,
                        ),
                        _buildStatusWidget(
                            context, 'Ready for pickup', order.status!),
                        _buildStatusSeparatorWidget(),
                        _buildStatusSeparatorWidget(),
                        _buildStatusSeparatorWidget(),
                        const Spacer(
                          flex: 1,
                        ),
                        _buildStatusWidget(context, 'Pick up', order.status!),
                        const Spacer(
                          flex: 3,
                        ),
                      ],
                    );
                  })
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order id',
                      style: Theme.of(context).textTheme.displayMedium),
                  Text(order.id,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.grey[400])),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pickup branch',
                      style: Theme.of(context).textTheme.displayMedium),
                  Text(order.branch,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.grey[400])),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
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
            ),
            const SizedBox(height: 5),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pickup date & time',
                      style: Theme.of(context).textTheme.displayMedium),
                  Text(order.date,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.grey[400])),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: MediaQuery.of(context).size.height * .12,
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recite',
                      style: Theme.of(context).textTheme.displayMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w300)),
                      Row(
                        children: [
                          Text('${order.price} ',
                              style: Theme.of(context).textTheme.displayMedium),
                          Text('SAR',
                              style: Theme.of(context).textTheme.displaySmall),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Vat',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w300)),
                      Row(
                        children: [
                          Text('${order.vat} ',
                              style: Theme.of(context).textTheme.displayMedium),
                          Text('SAR',
                              style: Theme.of(context).textTheme.displaySmall),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      style: Theme.of(context).textTheme.displayMedium),
                  Row(
                    children: [
                      Text(
                          '${double.parse(order.price) + double.parse(order.vat)} ',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: Theme.of(context).primaryColor,
                              )),
                      Text('SAR',
                          style: Theme.of(context).textTheme.displaySmall),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              padding: const EdgeInsets.only(left: 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tax recite',
                      style: Theme.of(context).textTheme.displayMedium),
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
                              .copyWith(
                                color: Colors.grey[400]))),
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Text('View document',
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .displayMedium!
                  //             .copyWith(color: Colors.grey[400])),
                  //     Icon(Icons.open_in_new, color: Colors.grey[400]),
                  //   ],
                  // )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Meals',
                      style: Theme.of(context).textTheme.displayMedium),
                  Text('Meals ${order.mealnum}',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.grey[400])),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .2,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            AppLinks.meal,
                            scale: 4,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image),
                          )),
                      const SizedBox(width: 5),
                      Text(order.mealname,
                          style: Theme.of(context).textTheme.displayMedium),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          'Change status',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusWidget(
      BuildContext context, String title, String currentStatus) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final isActive = orderProvider.getStatusIndex(title) <=
        orderProvider.getStatusIndex(currentStatus);
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Colors.green : Colors.grey),
          child: const Icon(Icons.check, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.green : Colors.grey),
        )
      ],
    );
  }

  Widget _buildStatusSeparatorWidget() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: const Divider(
          color: Colors.grey,
          thickness: 2,
          height: 0.03,
        ),
      ),
    );
  }
}
