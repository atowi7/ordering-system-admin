import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/views/home/manager/manager.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<Map<String, dynamic>>? orderStatusList;
  const FilterBottomSheet({super.key, required this.orderStatusList});

  @override
  State<FilterBottomSheet> createState() => _SortFilterBottomSheetState();
}

class _SortFilterBottomSheetState extends State<FilterBottomSheet> {
  final List<String> _paymentMethods = [
    'CASH',
    'CREDIT CARD',
    'MADA',
    'APPLE',
    'PORTAL',
    'WALLET',
  ];
  String? _selectedFilterStatus;
  String? _selectedFilterPayment;
  @override
  Widget build(BuildContext context) {
    HomeManager manager = HomeManager(context: context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                      .map((orderStatus) => Transform.translate(
                            offset: Offset(
                                -8,
                                -15.0 *
                                    widget.orderStatusList!
                                        .indexOf(orderStatus)),
                            child: RadioListTile<String>(
                                title: Transform.translate(
                                  offset: const Offset(-16, 0),
                                  child: Text(orderStatus['name'],
                                      style: AppTheme.orderStatusTitle),
                                ),
                                contentPadding: EdgeInsets.zero,
                                fillColor: WidgetStateProperty.all(Colors.grey),
                                value: orderStatus['name'],
                                groupValue: _selectedFilterStatus,
                                onChanged: (value) {
                                   
                                  setState(() {
                                   
                                    _selectedFilterStatus = value;
                                  });
                                }),
                          ))
                      .toList()
                  : [],
            ),
            Transform.translate(
              offset: const Offset(4, -35),
              child: const Text('Payment method',
                  style: AppTheme.paymentMethodHead),
            ),
            Column(
              children: _paymentMethods
                  .map((paymentMethod) => Transform.translate(
                        offset: Offset(
                            -8,
                            -32.0 -
                                (15 * _paymentMethods.indexOf(paymentMethod))),
                        child: RadioListTile<String>(
                            title: Transform.translate(
                              offset: const Offset(-16, 0),
                              child: Text(paymentMethod,
                                  style: AppTheme.paymentMethodTitle),
                            ),
                            contentPadding: EdgeInsets.zero,
                            fillColor: WidgetStateProperty.all(Colors.grey),
                            value: paymentMethod,
                            groupValue: _selectedFilterPayment,
                            onChanged: (value) {
print('onChanged $value');
                              setState(() {
                                _selectedFilterPayment = value;
                              });
                            }),
                      ))
                  .toList(),
            ),
            Transform.translate(
              offset: const Offset(-8, -130),
              child: Container(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
