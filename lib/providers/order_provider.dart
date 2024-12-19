import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/services/order_service.dart';
import 'package:ordering_system_admin/views/home/widgets/changeorderstatus_dialog.dart';
import 'package:ordering_system_admin/views/home/widgets/sort_sheet.dart';
import 'package:ordering_system_admin/views/home/widgets/filter_sheet.dart';

class OrderProvider extends ChangeNotifier {
  OrderModel? _order;
  List<OrderModel>? _orders;
  List<Map<String, dynamic>>? _orderStatusList;

  final orderService = OrderService();

  // bool showStatusChangeDialog = false;
  // String? _selectedOrderId;
  String? _selectedStatus;

  // String? _selectedSort;
  // String? _selectedFilterStatus;
  // String? _selectedFilterPayment;

  OrderModel? get order => _order;
  List<OrderModel>? get orders => _orders;
  List<Map<String, dynamic>>? get orderStatusList => _orderStatusList;
  // List<String> get paymentMethods => _paymentMethods;
  // bool _isLoading = false;
  // String? get selectedOrderId => _selectedOrderId;
  String? get selectedStatus => _selectedStatus;
  // String? get selectedFilterStatus => _selectedFilterStatus;
  // String? get selectedFilterPayment => _selectedFilterPayment;
  // String? get selectedSort => _selectedSort;
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

  void onRefresh() {
    notifyListeners();
  }

  void sortOrders(BuildContext context, String? selectedSort) {
    if (_orders != null) {
      if (selectedSort != null) {
        if (selectedSort == 'old_to_new') {
          _orders!.sort((a, b) {
            // print('old_to_new ${ a.createdAt.compareTo(b.createdAt)}');
            return a.createdAt.compareTo(b.createdAt);
          });
        } else if (selectedSort == 'new_to_old') {
          _orders!.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        }
        print('sorted ${orders!.first.id}');
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                'please select option to sort',
                style: AppTheme.successText,
              ),
              backgroundColor: AppColors.primaryColor),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Empty orders can not ne sorted',
              style: AppTheme.successText,
            ),
            backgroundColor: AppColors.primaryColor),
      );
    }
  }

  void filterOrders(BuildContext context, String? selectedFilterStatus,
      String? selectedFilterPayment) {
    if (selectedFilterStatus == null && selectedFilterPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Please choose at least one option to filter',
              style: AppTheme.successText,
            ),
            backgroundColor: AppColors.primaryColor),
      );
    } else {
      _orders!.where((order) {
        // print(
        //     'order.status ${order.status!.toLowerCase().trim()} | ${selectedFilterStatus ?? selectedFilterStatus!.toLowerCase().trim().split('_').join(' ')} order.paymentMethod ${order.paymentMethod.toLowerCase().trim()} | ${selectedFilterPayment ?? selectedFilterPayment!.toLowerCase()} ');
        // print(
        //     'filterOrders ${selectedFilterStatus.toLowerCase().contains(order.status!.toLowerCase().trim().split('_').join(' ')) || order.paymentMethod.toLowerCase().contains(selectedFilterPayment.toLowerCase().trim().split('_').join(' '))}');
        return (selectedFilterStatus != null &&
                selectedFilterStatus.toLowerCase().contains(
                    order.status!.toLowerCase().trim().split('_').join(' '))) ||
            (selectedFilterPayment != null &&
                selectedFilterPayment
                    .toLowerCase()
                    .contains(order.paymentMethod.toLowerCase().trim()));
      }).toList();
      notifyListeners();
    }
  }

  void resetSort() {
    notifyListeners();
  }

  void resetFilter() {
    notifyListeners();
  }

  void showChangeOrderStatusDialog(BuildContext context, int orderId,
      List<Map<String, dynamic>> orderStatusList) {
    // showStatusChangeDialog = true;

    showDialog(
        context: context,
        builder: (context) => ChangeOrderStatusDialog(
            orderId: orderId,
            orderStatusList: orderStatusList,
            onStatusChanged: (newStatus) =>
                changeOrderStatus(context, orderId, newStatus)));
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
        return SortBottomSheet();
      },
    );
  }

  void showBottomSheetForFilter(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FilterBottomSheet(
            orderStatusList: _orderStatusList,
          );
        });
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
                 

  // void updateUI() {
  //   notifyListeners();

  // }
  // void updateSelectedStatus(String? newSelected) {
  //   _selectedStatus = newSelected;
  //   notifyListeners();
  // }

  // void updateSelectedFilterStatus(String? newSelected) {
  //   _selectedFilterStatus = newSelected;
  //   notifyListeners();
  // }

  // void updateSelectedFilterPayment(String? newSelected) {
  //   _selectedFilterPayment = newSelected;
  //   notifyListeners();
  // }

  // void updateSelectedSort(String? newSort) {
  //   _selectedSort = newSort;
  //   notifyListeners();
  // }