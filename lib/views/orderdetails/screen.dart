import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/views/orderdetails/manager/manager.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/appbar.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/customrow.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/progress.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/recite.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/taxrecite.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailScreen extends StatelessWidget {
  final int orderId;
  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    OrderDetailsManager manager = OrderDetailsManager(context: context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: manager.getOrderDetails(orderId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                        backgroundColor: AppColors.primaryColor),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}',
                      style: AppTheme.errorText);
                } 
                // else if (!snapshot.hasData) {
                //   return const Center(
                //     child: Text(
                //       'No order found',
                //       style: AppTheme.errorText,
                //     ),
                //   );
                // }

                return Column(
                  children: [
                    const Appbar(),
                    CustomProgress(order: manager.order!),
                    CustomItem(title: 'Order id', text: '${manager.order!.id}'),
                    CustomItem(
                        title: 'Pickup branch',
                        text: manager.order!.branch?['address'] ??
                            'Not available'),
                    CustomItem(
                        title: 'Payment method',
                        text: manager.order!.paymentMethod),
                    CustomItem(
                        title: 'Pickup date & time',
                        text: '${manager.order!.branch?['max_delivery_time']}'),
                    Recite(order: manager.order!),
                    TaxRecite(
                      viewDoc:  () async {
                      await launchUrl(Uri.parse(manager.order!.invoiceLink));
                    },
                    ),
                    CustomItem(
                        title: 'Meals',
                        text:
                            'Meals ${manager.order!.items[0]['product']['name']}'),
                  ],
                );
              }),
        ),
        // bottomNavigationBar: FutureBuilder(
        //     future: manager.getOrderDetails(orderId),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(
        //           child: CircularProgressIndicator(
        //               backgroundColor: AppColors.primaryColor),
        //         );
        //       } else if (snapshot.hasError) {
        //         return const Text('');
        //       } else if (snapshot.hasData) {
        //         return CustomNavigationBar(order: manager.order!);
        //       } else {
        //         return const Center(
        //           child: Text(''),
        //         );
        //       }
        //     }),
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