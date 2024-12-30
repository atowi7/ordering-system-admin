import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';

class Recite extends StatelessWidget {
  final OrderModel order;
  const Recite({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 5),
      // height: MediaQuery.of(context).size.height * .12,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recite',
            style: AppTheme.orderDetailsReciteHead,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal',
                style: AppTheme.orderDetailsReciteSubTotal,
              ),
              Row(
                children: [
                  Text(
                    '${order.prices?['sub_total']} ',
                    style: AppTheme.orderDetailsReciteSubTotalPrice,
                  ),
                  const Text('SAR', style: AppTheme.orderDetailsReciteCurrency),
                ],
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Vat', style: AppTheme.orderDetailsReciteVat),
              Row(
                children: [
                  Text('${order.prices?['vat_cost']} ',
                      style: AppTheme.orderDetailsReciteVatPrice),
                  const Text('SAR', style: AppTheme.orderDetailsReciteCurrency),
                ],
              ),
            ],
          ),
          const Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total', style: AppTheme.orderDetailsReciteTotal),
              Row(
                children: [
                  Text('${order.prices?['total_price']}',
                      style: AppTheme.orderDetailsReciteTotalPrice),
                  const Text('SAR', style: AppTheme.orderDetailsReciteCurrency),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
