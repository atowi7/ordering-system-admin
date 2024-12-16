import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_images.dart';
import 'package:ordering_system_admin/design_system/app_text.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:ordering_system_admin/views/home/widgets/heading.dart';
import 'package:ordering_system_admin/views/home/widgets/homeappbar.dart';
import 'package:ordering_system_admin/views/home/widgets/orderlist.dart';
import 'package:ordering_system_admin/views/home/widgets/sort_filter.dart';
import 'package:ordering_system_admin/views/home/manager/manager.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeManager manager = HomeManager(context: context);
    return SafeArea(
      child: Scaffold(
          appBar: const HomeAppBar(),
          backgroundColor: AppColors.backgroundColor,
          body: Consumer<OrderProvider>(builder: (_, __, ___) {
            return RefreshIndicator(
              onRefresh: () async {
                manager.onRefresh();
              },
              child: FutureBuilder(
                  future: manager.loadData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                          Text('Please wait ...', style: AppTheme.loadText)
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Heading(title: AppText.homeTitle),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          OrderList(
                              orders: manager.orders!,
                              orderStatusList: manager.orderStatusList!),
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
                  }),
            );
          }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SortFilter(
              onSortPressed: () => manager.showBottomSheetForSort(),
              onFilterPressed: () => manager.showBottomSheetForFilter())),
    );
  }
}
