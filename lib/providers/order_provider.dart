import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:ordering_system_admin/services/order_service.dart';
import 'package:ordering_system_admin/views/orders/widgets/changeorderstatus_dialog.dart';
import 'package:ordering_system_admin/views/orders/widgets/sort_sheet.dart';
import 'package:ordering_system_admin/views/orders/widgets/filter_sheet.dart';

class OrderProvider extends ChangeNotifier {
  OrderModel? _order;
  List<OrderModel>? _orders;
  List<OrderModel>? _sortedOrders;
  List<Map<String, dynamic>>? _orderStatusList;

  final orderService = OrderService();

  // bool showStatusChangeDialog = false;
  // String? _selectedOrderId;
  String? _selectedStatus;

  // String? _selectedSort;
  String? _selectedFilterStatus;
  String? _selectedFilterPayment;

  bool isRefresh = true;

  OrderModel? get order => _order;
  List<OrderModel>? get orders => _orders;
  List<OrderModel>? get sortedOrders => _sortedOrders;
  List<Map<String, dynamic>>? get orderStatusList => _orderStatusList;
  // List<String> get paymentMethods => _paymentMethods;
  // bool _isLoading = false;
  // String? get selectedOrderId => _selectedOrderId;
  String? get selectedStatus => _selectedStatus;
  // String? get selectedSort => _selectedSort;
  String? get selectedFilterStatus => _selectedFilterStatus;
  String? get selectedFilterPayment => _selectedFilterPayment;
  // bool get isLoading => _isLoading;

  void setOrders(List<OrderModel> orders) {
    _orders = orders;
  }

  StreamSubscription<List<OrderModel>>? _orderSubscription;
  final StreamController<List<OrderModel>> _orderStreamController =
      StreamController<List<OrderModel>>.broadcast();

  Stream<List<OrderModel>> get ordersStream => _orderStreamController.stream;

  // Future<void> getOrders(BuildContext context) async {
  //    print('selectedFilterStatus $_selectedFilterStatus');
  //   if (_orderStatusList != null && _orderStatusList!.isNotEmpty) {
  //     _selectedFilterStatus ??= _orderStatusList!.first['name'];
     
  //   }
  //   int statusIndex = _orderStatusList!.firstWhere(
  //       (map) => map['name'] == _selectedFilterStatus,
  //       orElse: () => {'value': 1})['value'] as int;
  //       print('statusIndex $statusIndex');
  //   _orderSubscription?.cancel(); 
  //   _orderSubscription = orderService
  //       .getOrders(context, statusIndex, _selectedFilterPayment)
  //       .listen(
  //     (orders) {
  //       print('StreamstatusIndex $statusIndex');
  //       if (_orders == null || _orders!.length < orders.length) {
  //         FlutterRingtonePlayer().play(
  //           android: AndroidSounds.notification,
  //           ios: IosSounds.glass,
  //           looping: false,
  //           volume: 0.5,
  //           asAlarm: false,
  //         );
       
  //       }
  // //  _orders = orders;
  // //         _sortedOrders = _orders;
  // //         _orderStreamController.add(orders);
  // //         notifyListeners();
        
  //     },
  //   );
  // }

  @override
  void dispose() {
    _orderSubscription?.cancel();
    _orderSubscription = null;
    _orderStreamController.close();

    super.dispose();
  }
  // Future<void> getOrders(BuildContext context) async {
  //   if (_orderStatusList != null && _orderStatusList!.isNotEmpty) {
  //     _selectedFilterStatus ??= _orderStatusList!.first['name'];
  //   }
  //   int statusIndex = _orderStatusList!.firstWhere(
  //       (map) => map['name'] == _selectedFilterStatus,
  //       orElse: () => {'value': 1})['value'] as int;
  //   _orderSubscription?.cancel(); // Cancel previous subscription if any
  //   _orderSubscription = orderService
  //       .getOrders(context, statusIndex, _selectedFilterPayment)
  //       .listen(
  //     (orders) {
  //       _orders = orders;
  //       _sortedOrders = _orders; // Initially set sortedOrders to orders
  //       _orderStreamController.add(orders); // Add orders to stream
  //       notifyListeners(); //
  //       // Play sound on initial data load or updates
  //       if (orders.isNotEmpty) {
  //         FlutterRingtonePlayer().play(
  //           android: AndroidSounds.notification,
  //           ios: IosSounds.glass,
  //           looping: false,
  //           volume: 0.5,
  //           asAlarm: false,
  //         );
  //         // isRefresh = false; // Reset refresh flag after initial load
  //       }
  //     },
  //   );
  // }

  Future<void> getOrders(BuildContext context) async {
  if (_orderStatusList != null && _orderStatusList!.isNotEmpty) {
    _selectedFilterStatus ??= _orderStatusList!.first['name'];
  }
  int statusIndex = _orderStatusList!.firstWhere(
      (map) => map['name'] == _selectedFilterStatus,
      orElse: () => {'value': 1})['value'] as int;

    final fetchedOrders =
        await orderService.getOrders(context,statusIndex, _selectedFilterPayment);
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
        _sortedOrders = List.from(_orders!);
        // if (_sortedOrders!.length < _orders!.length) {
        //   if (selectedSort == 'old_to_new') {
        //     _sortedOrders!.sort((a, b) {
        //       // print('old_to_new ${ a.createdAt.compareTo(b.createdAt)}');
        //       return a.createdAt.compareTo(b.createdAt);
        //     });
        //   } else if (selectedSort == 'new_to_old') {
        //     _sortedOrders!.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        //   }
        // } else {
        if (selectedSort == 'old_to_new') {
          _sortedOrders!.sort((a, b) {
            // print('old_to_new ${ a.createdAt.compareTo(b.createdAt)}');
            return a.createdAt.compareTo(b.createdAt);
          });
        } else if (selectedSort == 'new_to_old') {
          _sortedOrders!.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        }

        // print('sorted ${orders!.first.id}');
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
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return;
    } else {
      _selectedFilterStatus = selectedFilterStatus;
      _selectedFilterPayment = selectedFilterPayment;
      isRefresh = true;
      notifyListeners();
    }
  }

  void resetSort() {
    _sortedOrders = List.from(_orders!);
    notifyListeners();
  }

  void resetFilter() {
    _selectedFilterStatus = null;
    _selectedFilterPayment = null;
    _sortedOrders = List.from(_orders!);

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

  //  final String? filterStatus =
  //       selectedFilterStatus?.toLowerCase().trim().replaceAll('_', ' ');
  //   final String? filterPayment = selectedFilterPayment?.toLowerCase().trim();
  //   _sortedOrders ??= _orders;

  //   final filteredOrders = _orders?.where((order) {
  //     final orderStatus =
  //         order.status?.toLowerCase().trim().replaceAll('_', ' ');
  //     final paymentMethod = order.paymentMethod.toLowerCase().trim();

  //     print(' order.status $orderStatus $filterStatus');

  //     final matchesStatus =
  //         filterStatus == null || filterStatus.contains(orderStatus!);
  //     final matchesPayment =
  //         filterPayment == null || paymentMethod.contains(filterPayment);

  //     return matchesStatus && matchesPayment;
  //   }).toList();

  //   if (filteredOrders != null) {
  //     _sortedOrders = filteredOrders;
  //     notifyListeners();
  //   }