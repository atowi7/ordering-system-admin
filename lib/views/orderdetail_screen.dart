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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // height: MediaQuery.of(context).size.height * .1,
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text('Order Details',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontSize: 30,
                              )),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                // height: MediaQuery.of(context).size.height * .13,
                width: double.infinity,
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.translate(
                      offset: const Offset(-38, 0),
                      child: Text('order status',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w900)),
                    ),
                    const SizedBox(height: 8),
                    Consumer<OrderProvider>(
                        builder: (context, provider, child) {
                      return Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatusWidget(context, 'Pending', order.status!),
                          _buildStatusSeparatorWidget(),
                          _buildStatusSeparatorWidget(),
                          _buildStatusSeparatorWidget(),
                          _buildStatusWidget(
                              context, 'Preparing', order.status!),
                          _buildStatusSeparatorWidget(),
                          _buildStatusSeparatorWidget(),
                          _buildStatusSeparatorWidget(),
                          _buildStatusWidget(
                              context, 'Ready for pickup', order.status!),
                          _buildStatusSeparatorWidget(),
                          _buildStatusSeparatorWidget(),
                          _buildStatusSeparatorWidget(),
                          _buildStatusWidget(context, 'Pick up', order.status!),
                        ],
                      );
                    })
                  ],
                ),
              ),
              // const SizedBox(height: 5),
              Container(
                // height: MediaQuery.of(context).size.height * .1,
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order id',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    Text(order.id,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600])),
                  ],
                ),
              ),
              // const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                // height: MediaQuery.of(context).size.height * .1,
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pickup branch',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                )),
                    Text(order.branch,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600])),
                  ],
                ),
              ),
              // const SizedBox(height: 5),
              Container(
                // height: MediaQuery.of(context).size.height * .1,
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment method',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    Text(
                      order.paymentMethod,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 5),
              Container(
                // height: MediaQuery.of(context).size.height * .1,
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pickup date & time',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    Text(
                      order.date,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.only(bottom: 5),

                // height: MediaQuery.of(context).size.height * .12,
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recite',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${order.price} ',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            Text('SAR',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                     const SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Vat',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${order.vat} ',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            Text('SAR',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        Row(
                          children: [
                            Text(
                                '${double.parse(order.price) + double.parse(order.vat)} ',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).primaryColor,
                                    )),
                            Text('SAR',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 5),
              // Container(
              //    margin: const EdgeInsets.only(bottom: 5),

              //   // height: MediaQuery.of(context).size.height * .1,
              //   padding: const EdgeInsets.all(10),
              //   color: Colors.white,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'Total',
              //         style: Theme.of(context).textTheme.displaySmall!.copyWith(
              //               fontSize: 15,
              //               fontWeight: FontWeight.w300,
              //             ),
              //       ),
              //       Row(
              //         children: [
              //           Text(
              //               '${double.parse(order.price) + double.parse(order.vat)} ',
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .displayMedium!
              //                   .copyWith(
              //                     fontSize: 15,
              //                     fontWeight: FontWeight.w700,
              //                     color: Theme.of(context).primaryColor,
              //                   )),
              //           Text('SAR',
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .displaySmall!
              //                   .copyWith(fontWeight: FontWeight.w500)),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 5),
              Container(
                // height: MediaQuery.of(context).size.height * .1,
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tax recite',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    TextButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        icon: Icon(
                          Icons.open_in_new,
                          color: Colors.grey[600],
                        ),
                        iconAlignment: IconAlignment.end,
                        label: Text(
                          'View document',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                        )),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Text('View document',
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .displayMedium!
                    //             .copyWith(color: Colors.grey[600])),
                    //     Icon(Icons.open_in_new, color: Colors.grey[600]),
                    //   ],
                    // )
                  ],
                ),
              ),
              // const SizedBox(height: 5),
              Container(
                // height: MediaQuery.of(context).size.height * .1,
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Meals',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    Text(
                      'Meals ${order.mealnum}',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          // height: MediaQuery.of(context).size.height * .2,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        width: 60,
                        height: 30,
                        child: Image.network(
                          AppLinks.meal,
                          scale: 15,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image),
                        ),
                      )),
                  const SizedBox(width: 20),
                  Text(order.mealname,
                      style: Theme.of(context).textTheme.displayMedium),
                ],
              ),
              const SizedBox(height: 10),
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
          width: 25,
          height: 25,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Colors.green : Colors.grey),
          child: const Icon(Icons.check, color: Colors.white,size: 18),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.green : Colors.grey),
        ),
      ],
    );
  }

  Widget _buildStatusSeparatorWidget() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0.5),
        child: const Divider(
          color: Colors.grey,
          thickness: 1.5,
          height: 1,
        ),
      ),
    );
  }
}
