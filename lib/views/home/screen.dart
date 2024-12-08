import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_text.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/views/home/widgets/heading.dart';
import 'package:ordering_system_admin/views/home/widgets/homeappbar.dart';
import 'package:ordering_system_admin/views/home/widgets/orderlist.dart';
import 'package:ordering_system_admin/views/home/widgets/sort_filter.dart';
import 'package:ordering_system_admin/views/home/manager/manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeManager manager = HomeManager(context: context);
    return SafeArea(
      child: Scaffold(
          appBar: const HomeAppBar(),
          backgroundColor: AppColors.backgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Heading(title: AppText.homeTitle),
              const SizedBox(height: 5),
              FutureBuilder(
                future: manager.getOrders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                          backgroundColor: AppColors.primaryColor),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error ${snapshot.error}',
                        style: AppTheme.errorText);
                  } else if (snapshot.hasData) {
                    return OrderList(orders: manager.orders!);
                  } else {
                    return const Text(
                      'No orders found',
                      style: AppTheme.errorText,
                    );
                  }
                },
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SortFilter(
              onSortPressed: () => manager.showBottomSheetForSort(),
              onFilterPressed: () => manager.showBottomSheetForFilter())),
    );
  }
}
