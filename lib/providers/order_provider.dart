import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/services/order_service.dart';
import 'package:ordering_system_admin/views/home/widgets/changeorderstatus_dialog.dart';
import 'package:ordering_system_admin/views/home/widgets/sort_btn.dart';
import 'package:ordering_system_admin/views/home/widgets/sort_opt.dart';
import 'package:provider/provider.dart';

class OrderProvider extends ChangeNotifier {
  OrderModel? _order;
  List<OrderModel>? _orders;
  List<Map<String, dynamic>>? _orderStatusList;
  final List<String> _paymentMethods = [
    'CASH',
    'CREDIT_CARD',
    'MADA',
    'APPLE',
    'PORTAL',
    'WALLET',
  ];

  final orderService = OrderService();

  // bool showStatusChangeDialog = false;
  // String? _selectedOrderId;
  String? _selectedStatus;
  String? _selectedFilterStatus;
  String? _selectedFilterPayment;
  String? _selectedSort;

  OrderModel? get order => _order;
  List<OrderModel>? get orders => _orders;
  List<Map<String, dynamic>>? get orderStatusList => _orderStatusList;
  List<String> get paymentMethods => _paymentMethods;
  // bool _isLoading = false;
  // String? get selectedOrderId => _selectedOrderId;
  String? get selectedStatus => _selectedStatus;
  String? get selectedFilterStatus => _selectedFilterStatus;
  String? get selectedFilterPayment => _selectedFilterPayment;
  String? get selectedSort => _selectedSort;
  // bool get isLoading => _isLoading;

  void setOrders(List<OrderModel> orders) {
    _orders = orders;
  }

  Future<void> getOrders() async {
    final fetchedOrders = await orderService.getOrders();
    if (fetchedOrders != null || fetchedOrders!.isNotEmpty) {
      _orders = fetchedOrders;
    }
  }

  Future<void> getOrderStatuses() async {
    _orderStatusList = await orderService.getOrderStatuses();
  }

  Future<void> getOrderDetails(int orderId) async {
    try {
      final fetchedOrder = await orderService.getOrderDetails(orderId);
      // print('fetchedOrder $fetchedOrder.]');
      if (fetchedOrder != null) {
        _order = fetchedOrder;
      }
    } catch (e) {
      print(e);
    }
  }

  void sortOrders() {
    if (_selectedSort == 'old_to_new') {
      _orders!.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } else if (_selectedSort == 'new_to_od') {
      _orders!.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }
    notifyListeners();
  }

  void filterOrders() {
    _orders!.where((order) {
      return order.status == _selectedFilterStatus ||
          order.paymentMethod == _selectedFilterPayment;
    }).toList();
    notifyListeners();
  }

  void resetSort() {
    _selectedSort = null;
    notifyListeners();
  }

  void resetFilter() {
    _selectedFilterStatus = null;
    _selectedFilterPayment = null;
    notifyListeners();
  }

  // void updateUI() {
  //   notifyListeners();

  // }

  void showChangeOrderStatusDialog(BuildContext context, int orderId,
      List<Map<String, dynamic>> orderStatusList) {
    // showStatusChangeDialog = true;

    showDialog(
      context: context,
      builder: (context) =>
          Consumer<OrderProvider>(builder: (context, provider, child) {
        return ChangeOrderStatusDialog(
            orderId: orderId,
            selectedStatus: provider.selectedStatus,
            orderStatusList: orderStatusList,
            onStatusUpdated: (newStatus) =>
                provider.updateSelectedStatus(newStatus),
            onStatusChanged: (newStatus) =>
                provider.changeOrderStatus(context, orderId, newStatus));
      }),
    );
  }

  void updateSelectedStatus(String? newSelected) {
    _selectedStatus = newSelected;
    notifyListeners();
  }

  void updateSelectedFilterStatus(String? newSelected) {
    _selectedFilterStatus = newSelected;
    notifyListeners();
  }

  void updateSelectedFilterPayment(String? newSelected) {
    _selectedFilterPayment = newSelected;
    notifyListeners();
  }

  void updateSelectedSort(String? newSort) {
    _selectedSort = newSort;
    notifyListeners();
  }

  Future<void> changeOrderStatus(
      BuildContext context, int orderId, String? newStatus) async {
    final orderIndex = _orders!.indexWhere((o) => o.id == orderId);
    if (orderIndex != -1) {
      _orders![orderIndex].status = newStatus;
      // print('newStatus $newStatus');

      try {
        bool isUpdated = await orderService.changeOrderStatus(
            orderId, getStatusIndex(newStatus!) + 1);
        // print('isUpdated $isUpdated ${getStatusIndex(newStatus) + 1}');
        if (isUpdated) {
          _selectedStatus = null;
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                    'Status is changed to succesfully',
                    style: AppTheme.successText,
                  ),
                  backgroundColor: AppColors.primaryColor),
            );
          }

          notifyListeners();
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                    'Failed to change status',
                    style: AppTheme.errorText,
                  ),
                  backgroundColor: AppColors.primaryColor),
            );
          }
        }
      } catch (e) {
        print(e);
      }
    }
    // showStatusChangeDialog = false;
  }

  int getStatusIndex(String status) {
    for (int i = 0; i < orderStatusList!.length; i++) {
      // print(
      //     'getStatusIndex ${orderStatusList![i]['name'].toString().toLowerCase().trim()}  ||| ${status.toLowerCase().trim()}');
      if (orderStatusList![i]['name']
          .toString()
          .toLowerCase()
          .trim()
          .contains(status.toLowerCase().trim().split('_').join(' '))) {
        // print('getStatusIndex $i');
        return i;
      }
    }

    return -1;
  }

  void showBottomSheetForSort(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Consumer<OrderProvider>(builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sort by', style: AppTheme.sortHead),
                    TextButton(
                        onPressed: () {
                          provider.resetSort();
                        },
                        child: const Text('Clear', style: AppTheme.clearBtn)),
                  ],
                ),
                SortOption(
                    title: 'Date : new to old',
                    value: 'new_to_old',
                    groupValue: provider.selectedSort,
                    onChanged: (value) => updateSelectedSort(value),
                    dy: -8),
                SortOption(
                  title: 'Date : old to new',
                  value: 'old_to_new',
                  groupValue: provider.selectedSort,
                  onChanged: (value) => updateSelectedSort(value),
                  dy: -16,
                ),
                FilterButton(
                  onSaved: () {
                    provider.sortOrders();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }

  void showBottomSheetForFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Consumer<OrderProvider>(builder: (context, provider, child) {
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
                            provider.resetFilter();
                          },
                          child: const Text('Clear', style: AppTheme.clearBtn)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('Order Status', style: AppTheme.orderStatusHead),
                  ListView.builder(
                    itemCount: _orderStatusList!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final orderStatus = _orderStatusList![index];
                      return Transform.translate(
                        offset: Offset(-8, -15.0 * index),
                        child: RadioListTile<String>(
                          title: Transform.translate(
                            offset: const Offset(-16, 0),
                            child: Text(orderStatus['name'],
                                style: AppTheme.orderStatusTitle),
                          ),
                          contentPadding: EdgeInsets.zero,
                          fillColor: WidgetStateProperty.all(Colors.grey),
                          value: orderStatus['name'],
                          groupValue: provider.selectedFilterStatus,
                          onChanged: (value) =>
                              updateSelectedFilterStatus(value),
                        ),
                      );
                    },
                  ),
                  Transform.translate(
                    offset: const Offset(4, -50),
                    child: const Text('Payment method',
                        style: AppTheme.paymentMethodHead),
                  ),
                  ListView.builder(
                    itemCount: paymentMethods.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final paymentMethod = _paymentMethods[index];
                      return Transform.translate(
                        offset: Offset(-8, -55.0 - (15 * index)),
                        child: RadioListTile<String>(
                          title: Transform.translate(
                            offset: const Offset(-16, 0),
                            child: Text(paymentMethod,
                                style: AppTheme.paymentMethodTitle),
                          ),
                          contentPadding: EdgeInsets.zero,
                          fillColor: WidgetStateProperty.all(Colors.grey),
                          value: paymentMethod,
                          groupValue: provider.selectedFilterPayment,
                          onChanged: (value) =>
                              updateSelectedFilterPayment(value),
                        ),
                      );
                    },
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
                            sortOrders();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Save', style: AppTheme.saveBtn)),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}

 // Transform.translate(
                  //   offset: const Offset(-8, 0),
                  //   child: RadioListTile<String>(
                  //     title: Transform.translate(
                  //       offset: const Offset(-16, 0),
                  //       child: Text(_orderStatusList![0]['name'],
                  //           style: AppTheme.orderStatusTitle),
                  //     ),
                  //     contentPadding: EdgeInsets.zero,
                  //     fillColor: WidgetStateProperty.all(Colors.grey),
                  //     value: _orderStatusList![0]['name'],
                  //     groupValue: provider.selectedFilterStatus,
                  //     onChanged: (value) => updateSelectedFilterStatus(value),
                  //   ),
                  // ),
                  // Transform.translate(
                  //   offset: const Offset(-8, -15),
                  //   child: RadioListTile<String>(
                  //     title: Transform.translate(
                  //       offset: const Offset(-16, 0),
                  //       child: Text(_orderStatusList![1]['name'],
                  //           style: AppTheme.orderStatusTitle),
                  //     ),
                  //     contentPadding: EdgeInsets.zero,
                  //     fillColor: WidgetStateProperty.all(Colors.grey),
                  //     value: _orderStatusList![1]['name'],
                  //     groupValue: provider.selectedFilterStatus,
                  //     onChanged: (value) => updateSelectedFilterStatus(value),
                  //   ),
                  // ),
                  // Transform.translate(
                  //   offset: const Offset(-8, -30),
                  //   child: RadioListTile<String>(
                  //     title: Transform.translate(
                  //       offset: const Offset(-16, 0),
                  //       child: Text(_orderStatusList![2]['name'],
                  //           style: AppTheme.orderStatusTitle),
                  //     ),
                  //     contentPadding: EdgeInsets.zero,
                  //     fillColor: WidgetStateProperty.all(Colors.grey),
                  //     value: _orderStatusList![2]['name'],
                  //     groupValue: provider.selectedFilterStatus,
                  //     onChanged: (value) => updateSelectedFilterStatus(value),
                  //   ),
                  // ),
                  // Transform.translate(
                  //   offset: const Offset(-8, -45),
                  //   child: RadioListTile<String>(
                  //     title: Transform.translate(
                  //       offset: const Offset(-16, 0),
                  //       child: Text(_orderStatusList![3]['name'],
                  //           style: AppTheme.orderStatusTitle),
                  //     ),
                  //     contentPadding: EdgeInsets.zero,
                  //     fillColor: WidgetStateProperty.all(Colors.grey),
                  //     value: _orderStatusList![3]['name'],
                  //     groupValue: provider.selectedFilterStatus,
                  //     onChanged: (value) => updateSelectedFilterStatus(value),
                  //   ),
                  // ),
                  // Transform.translate(
                  //   offset: const Offset(-8, -60),
                  //   child: RadioListTile<String>(
                  //     title: Transform.translate(
                  //       offset: const Offset(-16, 0),
                  //       child: Text(_orderStatusList![4]['name'],
                  //           style: AppTheme.orderStatusTitle),
                  //     ),
                  //     contentPadding: EdgeInsets.zero,
                  //     fillColor: WidgetStateProperty.all(Colors.grey),
                  //     value: _orderStatusList![4]['name'],
                  //     groupValue: provider.selectedFilterStatus,
                  //     onChanged: (value) => updateSelectedFilterStatus(value),
                  //   ),
                  // ),
                  // Transform.translate(
                  //   offset: const Offset(-8, -75),
                  //   child: RadioListTile<String>(
                  //     title: Transform.translate(
                  //       offset: const Offset(-16, 0),
                  //       child: Text(_orderStatusList![5]['name'],
                  //           style: AppTheme.orderStatusTitle),
                  //     ),
                  //     contentPadding: EdgeInsets.zero,
                  //     fillColor: WidgetStateProperty.all(Colors.grey),
                  //     value: _orderStatusList![5]['name'],
                  //     groupValue: provider.selectedFilterStatus,
                  //     onChanged: (value) => updateSelectedFilterStatus(value),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                   // Transform.translate(
                  //   offset: const Offset(-8, -55),
                  //   child: RadioListTile<String>(
                  //     title: Transform.translate(
                  //       offset: const Offset(-16, 0),
                  //       child: const Text('CASH',
                  //           style: AppTheme.customOrderStatusTitle),
                  //     ),
                  //     contentPadding: EdgeInsets.zero,
                  //     fillColor: WidgetStateProperty.all(Colors.grey),
                  //     value: 'CASH',
                  //     groupValue: provider.selectedFilterPayment,
                  //     onChanged: (value) => updateSelectedFilterPayment(value),
                  //   ),
                  // ),
                  // Transform.translate(
                  //   offset: const Offset(-8, -70),
                  //   child: RadioListTile<String>(
                  //     title: Transform.translate(
                  //       offset: const Offset(-16, 0),
                  //       child: const Text('CREDIT_CARD',
                  //           style: AppTheme.customOrderStatusTitle),
                  //     ),
                  //     contentPadding: EdgeInsets.zero,
                  //     fillColor: WidgetStateProperty.all(Colors.grey),
                  //     value: 'CREDIT_CARD',
                  //     groupValue: provider.selectedFilterPayment,
                  //     onChanged: (value) => updateSelectedFilterPayment(value),
                  //   ),
                  // ),
                  // Transform.translate(
                  //   offset: const Offset(-8, -90),
                  //   child: RadioListTile<String>(
                  //     title: Transform.translate(
                  //       offset: const Offset(-16, 0),
                  //       child: const Text('MADA',
                  //           style: AppTheme.paymentMethodTitle),
                  //     ),
                  //     contentPadding: EdgeInsets.zero,
                  //     fillColor: WidgetStateProperty.all(Colors.grey),
                  //     value: 'MADA',
                  //     groupValue: provider.selectedFilterPayment,
                  //     onChanged: (value) => updateSelectedFilterPayment(value),
                  //   ),
                  // ),
                  // Transform.translate(
                  //   offset: const Offset(-8, -105),
                  //   child: RadioListTile<String>(
                  //     title: Transform.translate(
                  //       offset: const Offset(-16, 0),
                  //       child: const Text('APPLE',
                  //           style: AppTheme.paymentMethodTitle),
                  //     ),
                  //     contentPadding: EdgeInsets.zero,
                  //     fillColor: WidgetStateProperty.all(Colors.grey),
                  //     value: 'APPLE',
                  //     groupValue: provider.selectedFilterPayment,
                  //     onChanged: (value) => updateSelectedFilterPayment(value),
                  //   ),
                  // ),
                  // Transform.translate(
                  //   offset: const Offset(-8, -120),
                  //   child: RadioListTile<String>(
                  //     title: Transform.translate(
                  //       offset: const Offset(-16, 0),
                  //       child: const Text('PORTAL',
                  //           style: AppTheme.paymentMethodTitle),
                  //     ),
                  //     contentPadding: EdgeInsets.zero,
                  //     fillColor: WidgetStateProperty.all(Colors.grey),
                  //     value: 'PORTAL',
                  //     groupValue: provider.selectedFilterPayment,
                  //     onChanged: (value) => updateSelectedFilterPayment(value),
                  //   ),
                  // ),
                  // Transform.translate(
                  //   offset: const Offset(-8, -135),
                  //   child: RadioListTile<String>(
                  //     title: Transform.translate(
                  //       offset: const Offset(-16, 0),
                  //       child: const Text('WALLET',
                  //           style: AppTheme.paymentMethodTitle),
                  //     ),
                  //     contentPadding: EdgeInsets.zero,
                  //     fillColor: WidgetStateProperty.all(Colors.grey),
                  //     value: 'WALLET',
                  //     groupValue: provider.selectedFilterPayment,
                  //     onChanged: (value) => updateSelectedFilterPayment(value),
                  //   ),
                  // ),