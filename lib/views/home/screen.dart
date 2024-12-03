import 'package:flutter/material.dart';
import 'package:ordering_system_admin/constant/app_routes.dart';
import 'package:ordering_system_admin/views/home/widgets/order_item.dart';
import 'package:ordering_system_admin/views/home/widgets/sort_filter.dart';
import 'package:ordering_system_admin/views/manager/manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Manager manager = Manager();
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
                  itemCount: manager.orders.length,
                  itemBuilder: (context, index) {
                    final order = manager.orders[index];
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SortFilter(
              onSortPressed: () => manager.showBottomSheetForSort,
              onFilterPressed: () => manager.showBottomSheetForFilter)),
    );
  }
}
