import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_images.dart';
import 'package:ordering_system_admin/design_system/app_text.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:ordering_system_admin/shared/heading.dart';
import 'package:ordering_system_admin/views/orders/widgets/orderlist.dart';
import 'package:ordering_system_admin/views/orders/widgets/sort_filter.dart';
import 'package:ordering_system_admin/views/orders/manager/manager.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrdersManager manager = OrdersManager(context: context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<OrderProvider>(builder: (_, provider, ___) {
        return RefreshIndicator(
            onRefresh: () async {
              manager.onRefresh();
            },
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Heading(title: AppText.homeTitle),
                    ],
                  ),
                ),
                provider.isRefresh
                    ? FutureBuilder(
                        future: manager.loadData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: Lottie.asset(
                                    AppImages.loading,
                                    delegates: LottieDelegates(values: [
                                      ValueDelegate.color(const [
                                        'Shape Layer 1',
                                        'Rectangle',
                                        'Fill 1'
                                      ], value: AppColors.primaryColor),
                                    ]),
                                  ),
                                ),
                                Text('Please wait ...',
                                    style: AppTheme.loadText)
                              ],
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return provider.orders != null
                                ? OrderList(
                                    orders: provider.orders!,
                                    orderStatusList: provider.orderStatusList!)
                                : Center(
                                    child: Lottie.asset(AppImages.nodata),
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
                        })
                    : OrderList(
                        orders: provider.sortedOrders ?? provider.orders!,
                        orderStatusList: provider.orderStatusList!),
              ],
            ));
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SortFilter(
        onSortPressed: () => manager.showBottomSheetForSort(),
        onFilterPressed: () => manager.showBottomSheetForFilter(),
      ),
    );
  }
}
