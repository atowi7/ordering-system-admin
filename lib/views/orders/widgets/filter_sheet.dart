import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/views/orders/manager/manager.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<Map<String, dynamic>>? orderStatusList;
  const FilterBottomSheet({super.key, required this.orderStatusList});

  @override
  State<FilterBottomSheet> createState() => _SortFilterBottomSheetState();
}

class _SortFilterBottomSheetState extends State<FilterBottomSheet> {
  final List<String> _paymentMethods = [
    'CASH',
    'ONLINE',
  ];
  String? _selectedFilterStatus;
  String? _selectedFilterPayment;
  @override
  Widget build(BuildContext context) {
    OrdersManager manager = OrdersManager(context: context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Filter', style: AppTheme.filterHead),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedFilterStatus = null;
                        _selectedFilterPayment = null;
                        manager.resetFilter();
                      });
                    },
                    child: const Text('Clear', style: AppTheme.clearBtn)),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Order Status', style: AppTheme.orderStatusHead),
            Column(
              children: widget.orderStatusList != null
                  ? widget.orderStatusList!
                      .map((orderStatus) => RadioListTile<String>(
                          title: Text(orderStatus['name'],
                              style: AppTheme.orderStatusTitle),
                          visualDensity: VisualDensity.compact,
                          fillColor: WidgetStateProperty.all(Colors.grey),
                          value: orderStatus['name'],
                          groupValue: _selectedFilterStatus,
                          onChanged: (value) {
                            setState(() {
                              _selectedFilterStatus = value;
                            });
                          }))
                      .toList()
                  : [],
            ),
            const Text('Payment method', style: AppTheme.paymentMethodHead),
            Column(
              children: _paymentMethods
                  .map((paymentMethod) => RadioListTile<String>(
                      title: Text(paymentMethod,
                          style: AppTheme.paymentMethodTitle),
                      visualDensity: VisualDensity.compact,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      value: paymentMethod,
                      groupValue: _selectedFilterPayment,
                      onChanged: (value) {
                        setState(() {
                          _selectedFilterPayment = value;
                        });
                      }))
                  .toList(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    manager.filterOrders(
                        _selectedFilterStatus, _selectedFilterPayment);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save', style: AppTheme.saveBtn)),
            )
          ],
        ),
      ),
    );
  }
}
