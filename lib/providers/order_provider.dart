import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:ordering_system_admin/services/order_service.dart';
import 'package:ordering_system_admin/views/home/widgets/changeorderstatus_dialog.dart';
import 'package:provider/provider.dart';

class OrderProvider extends ChangeNotifier {
  OrderModel? _order;
  List<OrderModel>? _orders = [
    OrderModel(
      id: 1,
      status: 'Pending',
      paymentMethod: 'Cash on Delivery',
      paymentStatus: 'Unpaid',
      branch: {'name': 'Main Branch', 'address': '123 Main Street'},
      items: [
        {'Pizza': 2, 'Fries': 1}
      ],
      deliveryAddress: {'address': '456 Elm Street', 'phone': '123-456-7890'},
      promoCode: {},
      prices: {'subtotal': 19.99, 'tax': 1.99, 'total': 21.98},
      invoiceLink: 'https://example.com/invoice/1',
      serviceType: 'Delivery',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    OrderModel(
      id: 2,
      status: 'Completed',
      paymentMethod: 'Credit Card',
      paymentStatus: 'Paid',
      branch: {'name': 'Branch 2', 'address': '789 Oak Street'},
      items: [
        {'Burger': 3, 'Soda': 2}
      ],
      deliveryAddress: {'address': '101 Pine Street', 'phone': '987-654-3210'},
      promoCode: {'code': 'DISCOUNT10', 'discount': 10},
      prices: {'subtotal': 25.99, 'tax': 2.59, 'total': 28.58},
      invoiceLink: 'https://example.com/invoice/2',
      serviceType: 'Pickup',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    OrderModel(
      id: 3,
      status: 'Preparing',
      paymentMethod: 'Apple Pay',
      paymentStatus: 'Paid',
      branch: {'name': 'Main Branch', 'address': '123 Main Street'},
      items: [
        {'Salad': 1, 'Sandwich': 2}
      ],
      deliveryAddress: {'address': '543 Maple Street', 'phone': '555-555-5555'},
      promoCode: {},
      prices: {'subtotal': 15.99, 'tax': 1.59, 'total': 17.58},
      invoiceLink: 'https://example.com/invoice/3',
      serviceType: 'Delivery',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    OrderModel(
      id: 4,
      status: 'Out for Delivery',
      paymentMethod: 'Cash on Delivery',
      paymentStatus: 'Unpaid',
      branch: {'name': 'Branch 2', 'address': '789 Oak Street'},
      items: [
        {'Pizza': 2, 'Fries': 1, 'Soda': 2}
      ],
      deliveryAddress: {'address': '234 Cedar Street', 'phone': '444-444-4444'},
      promoCode: {},
      prices: {'subtotal': 22.99, 'tax': 2.29, 'total': 25.28},
      invoiceLink: 'https://example.com/invoice/4',
      serviceType: 'Delivery',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    OrderModel(
      id: 5,
      status: 'Completed',
      paymentMethod: 'Google Pay',
      paymentStatus: 'Paid',
      branch: {'name': 'Main Branch', 'address': '123 Main Street'},
      items: [
        {'Burger': 2, 'Fries': 1}
      ],
      deliveryAddress: {
        'address': '678 Walnut Street',
        'phone': '333-333-3333'
      },
      promoCode: {'code': 'DISCOUNT5', 'discount': 5},
      prices: {'subtotal': 18.99, 'tax': 1.89, 'total': 20.88},
      invoiceLink: 'https://example.com/invoice/5',
      serviceType: 'Pickup',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];
  List<Map<String, dynamic>>? _orderStatusList = [
    // 'Pending',
    // 'Preparing',
    // 'Ready for pickup',
    // 'pickup'
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
  // bool _isLoading = false;
  // String? get selectedOrderId => _selectedOrderId;
  String? get selectedStatus => _selectedStatus;
  String? get selectedFilterStatus => _selectedFilterStatus;
  String? get selectedFilterPayment => _selectedFilterPayment;
  String? get selectedSort => _selectedSort;
  // bool get isLoading => _isLoading;

  Future<void> getOrders() async {
    final fetchedOrders = await orderService.getOrders();
    if (fetchedOrders != null || fetchedOrders!.isNotEmpty) {
      _orders = fetchedOrders;
    }
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

  Future<void> getOrderStatuses() async {
    _orderStatusList = await orderService.getOrderStatuses();
  }

  void sortOrders() {
    if (_selectedSort == 'old_to_new') {
      _orders!.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } else if (_selectedSort == 'new_to_od') {
      _orders!.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }
  }

  void filterOrders() {
    _orders!.where((order) {
      return order.status == _selectedFilterStatus ||
          order.paymentMethod == _selectedFilterPayment;
    }).toList();
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

  void showChangeOrderStatusDialog(BuildContext context, int orderId) {
    // showStatusChangeDialog = true;

    showDialog(
      context: context,
      builder: (context) =>
          Consumer<OrderProvider>(builder: (context, provider, child) {
        return ChangeOrderStatusDialog(
            orderId: orderId,
            selectedStatus: provider.selectedStatus,
            onStatusUpdated: (newStatus) =>
                provider.updateSelectedStatus(newStatus),
            onStatusChanged: (newStatus) =>
                provider.changeOrderStatus(orderId, newStatus));
      }),
    );
    notifyListeners();
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

  Future<String> changeOrderStatus(int orderId, String? newStatus) async {
    final orderIndex = _orders!.indexWhere((o) => o.id == orderId);
    if (orderIndex != -1) {
      _orders![orderIndex].status = newStatus;

      try {
        bool isUpdated =
            await orderService.changeOrderStatus(orderId, newStatus!);

        if (isUpdated) {
          _selectedStatus = null;
          notifyListeners();
          return 'success';
        }
      } catch (e) {
        return 'failed';
      }
    }
    // showStatusChangeDialog = false;
    return 'failed';
  }

  int getStatusIndex(String status) {
    for (int i = 0; i < orderStatusList!.length; i++) {
      if (orderStatusList![i]['name'] == status) {
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
                Transform.translate(
                  offset: const Offset(-8, -8),
                  child: RadioListTile<String>(
                    title: Transform.translate(
                      offset: const Offset(-16, 0),
                      child: const Text('Date : new to old',
                          style: AppTheme.sortOpt),
                    ),
                    contentPadding: EdgeInsets.zero,
                    fillColor: WidgetStateProperty.all(Colors.grey),
                    value: 'new_to_old',
                    groupValue: provider.selectedSort,
                    onChanged: (value) => updateSelectedSort(value),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(-8, -16),
                  child: RadioListTile<String>(
                    title: Transform.translate(
                      offset: const Offset(-16, 0),
                      child: const Text('Date : old to new',
                          style: AppTheme.sortOpt),
                    ),
                    contentPadding: EdgeInsets.zero,
                    fillColor: WidgetStateProperty.all(Colors.grey),
                    value: 'old_to_new',
                    groupValue: provider.selectedSort,
                    onChanged: (value) => updateSelectedSort(value),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          provider.sortOrders();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Save', style: AppTheme.saveBtn)),
                  ),
                )
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
                  Transform.translate(
                    offset: const Offset(-8, 0),
                    child: RadioListTile<String>(
                      title: Transform.translate(
                        offset: const Offset(-16, 0),
                        child: Text(
                            _orderStatusList?.isNotEmpty ?? false
                                ? _orderStatusList![0]['name']
                                : 'Pending',
                            style: AppTheme.orderStatusTitle),
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      value: _orderStatusList?.isNotEmpty ?? false
                          ? _orderStatusList![0]['name']
                          : 'Pending',
                      groupValue: provider.selectedFilterStatus,
                      onChanged: (value) => updateSelectedFilterStatus(value),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-8, -15),
                    child: RadioListTile<String>(
                      title: Transform.translate(
                        offset: const Offset(-16, 0),
                        child: Text(
                            _orderStatusList?.isNotEmpty ?? false
                                ? _orderStatusList![1]['name']
                                : 'Preparing',
                            style: AppTheme.orderStatusTitle),
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      value: _orderStatusList?.isNotEmpty ?? false
                          ? _orderStatusList![1]['name']
                          : 'Preparing',
                      groupValue: provider.selectedFilterStatus,
                      onChanged: (value) => updateSelectedFilterStatus(value),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-8, -30),
                    child: RadioListTile<String>(
                      title: Transform.translate(
                        offset: const Offset(-16, 0),
                        child: Text(
                            _orderStatusList?.isNotEmpty ?? false
                                ? _orderStatusList![2]['name']
                                : 'Ready For Pickup',
                            style: AppTheme.orderStatusTitle),
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      value: _orderStatusList?.isNotEmpty ?? false
                          ? _orderStatusList![2]['name']
                          : 'Ready For Pickup',
                      groupValue: provider.selectedFilterStatus,
                      onChanged: (value) => updateSelectedFilterStatus(value),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-8, -45),
                    child: RadioListTile<String>(
                      title: Transform.translate(
                        offset: const Offset(-16, 0),
                        child: Text(
                            _orderStatusList?.isNotEmpty ?? false
                                ? _orderStatusList![3]['name']
                                : 'Out for Delivery',
                            style: AppTheme.orderStatusTitle),
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      value: _orderStatusList?.isNotEmpty ?? false
                          ? _orderStatusList![3]['name']
                          : 'Out for Delivery',
                      groupValue: provider.selectedFilterStatus,
                      onChanged: (value) => updateSelectedFilterStatus(value),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-8, -60),
                    child: RadioListTile<String>(
                      title: Transform.translate(
                        offset: const Offset(-16, 0),
                        child: Text(
                            _orderStatusList?.isNotEmpty ?? false
                                ? _orderStatusList![4]['name']
                                : 'Completed',
                            style: AppTheme.orderStatusTitle),
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      value: _orderStatusList?.isNotEmpty ?? false
                          ? _orderStatusList![4]['name']
                          : 'Completed',
                      groupValue: provider.selectedFilterStatus,
                      onChanged: (value) => updateSelectedFilterStatus(value),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-8, -75),
                    child: RadioListTile<String>(
                      title: Transform.translate(
                        offset: const Offset(-16, 0),
                        child: Text(
                            _orderStatusList?.isNotEmpty ?? false
                                ? _orderStatusList![5]['name']
                                : 'Canceled',
                            style: AppTheme.orderStatusTitle),
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      value: _orderStatusList?.isNotEmpty ?? false
                          ? _orderStatusList![5]['name']
                          : 'Canceled',
                      groupValue: provider.selectedFilterStatus,
                      onChanged: (value) => updateSelectedFilterStatus(value),
                    ),
                  ),
                  // const SizedBox(height: 10),
                  Transform.translate(
                    offset: const Offset(4, -50),
                    child: const Text('Payment method',
                        style: AppTheme.paymentMethodHead),
                  ),
                  Transform.translate(
                    offset: const Offset(-8, -55),
                    child: RadioListTile<String>(
                      title: Transform.translate(
                        offset: const Offset(-16, 0),
                        child: const Text('CASH',
                            style: AppTheme.customOrderStatusTitle),
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      value: 'CASH',
                      groupValue: provider.selectedFilterPayment,
                      onChanged: (value) => updateSelectedFilterPayment(value),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-8, -75),
                    child: RadioListTile<String>(
                      title: Transform.translate(
                        offset: const Offset(-16, 0),
                        child: const Text('CREDIT_CARD',
                            style: AppTheme.customOrderStatusTitle),
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      value: 'CREDIT_CARD',
                      groupValue: provider.selectedFilterPayment,
                      onChanged: (value) => updateSelectedFilterPayment(value),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-8, -90),
                    child: RadioListTile<String>(
                      title: Transform.translate(
                        offset: const Offset(-16, 0),
                        child: const Text('MADA',
                            style: AppTheme.paymentMethodTitle),
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      value: 'MADA',
                      groupValue: provider.selectedFilterPayment,
                      onChanged: (value) => updateSelectedFilterPayment(value),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-8, -105),
                    child: RadioListTile<String>(
                      title: Transform.translate(
                        offset: const Offset(-16, 0),
                        child: const Text('APPLE',
                            style: AppTheme.paymentMethodTitle),
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      value: 'APPLE',
                      groupValue: provider.selectedFilterPayment,
                      onChanged: (value) => updateSelectedFilterPayment(value),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-8, -120),
                    child: RadioListTile<String>(
                      title: Transform.translate(
                        offset: const Offset(-16, 0),
                        child: const Text('PORTAL',
                            style: AppTheme.paymentMethodTitle),
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      value: 'PORTAL',
                      groupValue: provider.selectedFilterPayment,
                      onChanged: (value) => updateSelectedFilterPayment(value),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-8, -135),
                    child: RadioListTile<String>(
                      title: Transform.translate(
                        offset: const Offset(-16, 0),
                        child: const Text('WALLET',
                            style: AppTheme.paymentMethodTitle),
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      value: 'WALLET',
                      groupValue: provider.selectedFilterPayment,
                      onChanged: (value) => updateSelectedFilterPayment(value),
                    ),
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
