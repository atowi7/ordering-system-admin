import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_images.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:ordering_system_admin/views/orderdetails/manager/manager.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/appbar.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/custombottomnavigation_bar.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/customrow.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/progress.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/recite.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/taxrecite.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailScreen extends StatelessWidget {
  final int orderId;
  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    OrderDetailsManager manager =
        OrderDetailsManager(context: context, orderId: orderId);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<OrderProvider>(builder: (context, provider, child) {
        return FutureBuilder(
            future: manager.loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset(
                    AppImages.loading,
                    delegates: LottieDelegates(values: [
                      ValueDelegate.color([],
                          value: AppColors.primaryColor),
                    ]),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  children: [
                    const Appbar(),
                    SizedBox(
                      height: screenSize.height * 0.14,
                      child: CustomProgress(
                        order: manager.order!,
                        orderStatusList: manager.orderStatusList!,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.07,
                      child: CustomItem(
                          title: 'Order id', text: '${manager.order!.id}'),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.07,
                      child: CustomItem(
                          title: 'Pickup branch',
                          text: manager.order!.branch?['address'] ??
                              'Not available'),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.07,
                      child: CustomItem(
                          title: 'Payment method',
                          text: manager.order!.paymentMethod),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.07,
                      child: CustomItem(
                          title: 'Pickup date & time',
                          text:
                              '${manager.order!.branch?['max_delivery_time']}'),
                    ),
                    SizedBox(
                        height: screenSize.height * 0.15,
                        child: Recite(order: manager.order!)),
                    SizedBox(
                      height: screenSize.height * 0.07,
                      child: TaxRecite(
                        viewDoc: () async {
                          await launchUrl(
                              Uri.parse(manager.order!.invoiceLink));
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.07,
                      child: CustomItem(
                          title: 'Items',
                          text: '${manager.order!.items.length}'),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error ${snapshot.error}',
                    style: AppTheme.errorText);
              }
              return const Center(
                child: Text(
                  'No order found',
                  style: AppTheme.errorText,
                ),
              );
            });
      }),
      bottomNavigationBar: CustomNavigationBar(
        onChangeStatus: () {
          manager.changeOrderStatus(orderId);
        },
      ),
    );
  }
}



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