import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/appbar.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/customnavigationbar.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/customrow.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/progress.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/recite.dart';
import 'package:ordering_system_admin/views/orderdetails/widgets/taxrecite.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Appbar(),
              CustomProgress(order: order),
              CustomItem(title: 'Order id', text: order.id),
              CustomItem(title: 'Pickup branch', text: order.branch),
              CustomItem(title: 'Payment method', text: order.paymentMethod),
              CustomItem(title: 'Pickup date & time', text: order.date),
              Recite(order: order),
              TaxRecite(
                viewDoc: () {},
              ),
              CustomItem(title: 'Meals', text: 'Meals ${order.mealnum}'),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavigationBar(order: order),
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