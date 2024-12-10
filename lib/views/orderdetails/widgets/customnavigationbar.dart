import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';

class CustomNavigationBar extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onChangeStatus;
  const CustomNavigationBar(
      {super.key, required this.order, required this.onChangeStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * .2,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.only(
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
                      order.items[0]['product']['thumbnail'],
                      scale: 15,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const CircularProgressIndicator(
                          strokeWidth: 4,
                          backgroundColor: AppColors.primaryColor,
                        );
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image),
                    ),
                  )),
              const SizedBox(width: 20),
              Text(order.items[0]['product']['name'],
                  style: AppTheme.navigationBarTitle),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: onChangeStatus,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  'Change status',
                  style: AppTheme.navigationBarTitle,
                )),
          )
        ],
      ),
    );
  }
}
