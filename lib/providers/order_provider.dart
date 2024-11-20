import 'package:flutter/material.dart';
import 'package:ordering_system_admin/models/order_model.dart';
import 'package:provider/provider.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> _orders = [
    OrderModel(
        id: '101010',
        username: 'Atowi',
        phoneNumber: '+966555555555',
        branch: 'Madinah',
        paymentMethod: 'cash',
        service: 'Pickup',
        price: '28.5',
        vat: '1.5',
        mealname: 'Solo Light Meal - Meat Awsal',
        mealnum: '2',
        mealImage:
            'https://www.google.com/imgres?q=Solo%20Light%20Meal%20-%20Meat%20Awsal&imgurl=https%3A%2F%2Fdashboard-ennabi.golyv.co%2Fuploads%2Fimages%2Fproducts%2Ffede2b19-5548-449e-befa-3419b021917b.jpg&imgrefurl=https%3A%2F%2Fennabi.golyv.co%2Fcategories%2F16&docid=UvohPqj8AbbbjM&tbnid=MW9jJ237wkr8-M&vet=12ahUKEwiep868y-aJAxVgRKQEHYpPDX0QM3oECBUQAA..i&w=512&h=512&hcb=2&ved=2ahUKEwiep868y-aJAxVgRKQEHYpPDX0QM3oECBUQAA',
        status: 'Preparing',
        date: '2024-11-1 23:22:00'),
    OrderModel(
        id: '101010',
        username: 'Atowi',
        phoneNumber: '+966555555555',
        branch: 'Madinah',
        paymentMethod: 'cash',
        service: 'Pickup',
        price: '28.5',
        vat: '1.5',
        mealname: 'Solo Light Meal - Meat Awsal',
        mealnum: '2',
        mealImage:
            'https://www.google.com/imgres?q=Solo%20Light%20Meal%20-%20Meat%20Awsal&imgurl=https%3A%2F%2Fdashboard-ennabi.golyv.co%2Fuploads%2Fimages%2Fproducts%2Ffede2b19-5548-449e-befa-3419b021917b.jpg&imgrefurl=https%3A%2F%2Fennabi.golyv.co%2Fcategories%2F16&docid=UvohPqj8AbbbjM&tbnid=MW9jJ237wkr8-M&vet=12ahUKEwiep868y-aJAxVgRKQEHYpPDX0QM3oECBUQAA..i&w=512&h=512&hcb=2&ved=2ahUKEwiep868y-aJAxVgRKQEHYpPDX0QM3oECBUQAA',
        status: 'Preparing',
        date: '2024-11-2 23:22:00'),
    OrderModel(
        id: '101010',
        username: 'Atowi',
        phoneNumber: '+966555555555',
        branch: 'Madinah',
        paymentMethod: 'cash',
        service: 'Pickup',
        price: '28.5',
        vat: '1.5',
        mealname: 'Solo Light Meal - Meat Awsal',
        mealnum: '2',
        mealImage:
            'https://www.google.com/imgres?q=Solo%20Light%20Meal%20-%20Meat%20Awsal&imgurl=https%3A%2F%2Fdashboard-ennabi.golyv.co%2Fuploads%2Fimages%2Fproducts%2Ffede2b19-5548-449e-befa-3419b021917b.jpg&imgrefurl=https%3A%2F%2Fennabi.golyv.co%2Fcategories%2F16&docid=UvohPqj8AbbbjM&tbnid=MW9jJ237wkr8-M&vet=12ahUKEwiep868y-aJAxVgRKQEHYpPDX0QM3oECBUQAA..i&w=512&h=512&hcb=2&ved=2ahUKEwiep868y-aJAxVgRKQEHYpPDX0QM3oECBUQAA',
        status: 'Preparing',
        date: '2024-11-3 23:22:00'),
    OrderModel(
        id: '101010',
        username: 'Atowi',
        phoneNumber: '+966555555555',
        branch: 'Madinah',
        paymentMethod: 'cash',
        service: 'Pickup',
        price: '28.5',
        vat: '1.5',
        mealname: 'Solo Light Meal - Meat Awsal',
        mealnum: '2',
        mealImage:
            'https://www.google.com/imgres?q=Solo%20Light%20Meal%20-%20Meat%20Awsal&imgurl=https%3A%2F%2Fdashboard-ennabi.golyv.co%2Fuploads%2Fimages%2Fproducts%2Ffede2b19-5548-449e-befa-3419b021917b.jpg&imgrefurl=https%3A%2F%2Fennabi.golyv.co%2Fcategories%2F16&docid=UvohPqj8AbbbjM&tbnid=MW9jJ237wkr8-M&vet=12ahUKEwiep868y-aJAxVgRKQEHYpPDX0QM3oECBUQAA..i&w=512&h=512&hcb=2&ved=2ahUKEwiep868y-aJAxVgRKQEHYpPDX0QM3oECBUQAA',
        status: 'Preparing',
        date: '2024-11-4 23:22:00'),
    OrderModel(
        id: '101010',
        username: 'Atowi',
        phoneNumber: '+966555555555',
        branch: 'Madinah',
        paymentMethod: 'cash',
        service: 'Pickup',
        price: '28.5',
        vat: '1.5',
        mealname: 'Solo Light Meal - Meat Awsal',
        mealnum: '2',
        mealImage:
            'https://www.google.com/imgres?q=Solo%20Light%20Meal%20-%20Meat%20Awsal&imgurl=https%3A%2F%2Fdashboard-ennabi.golyv.co%2Fuploads%2Fimages%2Fproducts%2Ffede2b19-5548-449e-befa-3419b021917b.jpg&imgrefurl=https%3A%2F%2Fennabi.golyv.co%2Fcategories%2F16&docid=UvohPqj8AbbbjM&tbnid=MW9jJ237wkr8-M&vet=12ahUKEwiep868y-aJAxVgRKQEHYpPDX0QM3oECBUQAA..i&w=512&h=512&hcb=2&ved=2ahUKEwiep868y-aJAxVgRKQEHYpPDX0QM3oECBUQAA',
        status: 'Preparing',
        date: '2024-11-5 23:22:00'),
    OrderModel(
        id: '101010',
        username: 'Atowi',
        phoneNumber: '+966555555555',
        branch: 'Madinah',
        paymentMethod: 'cash',
        service: 'Pickup',
        price: '28.5',
        vat: '1.5',
        mealname: 'Solo Light Meal - Meat Awsal',
        mealnum: '2',
        mealImage:
            'https://www.google.com/imgres?q=Solo%20Light%20Meal%20-%20Meat%20Awsal&imgurl=https%3A%2F%2Fdashboard-ennabi.golyv.co%2Fuploads%2Fimages%2Fproducts%2Ffede2b19-5548-449e-befa-3419b021917b.jpg&imgrefurl=https%3A%2F%2Fennabi.golyv.co%2Fcategories%2F16&docid=UvohPqj8AbbbjM&tbnid=MW9jJ237wkr8-M&vet=12ahUKEwiep868y-aJAxVgRKQEHYpPDX0QM3oECBUQAA..i&w=512&h=512&hcb=2&ved=2ahUKEwiep868y-aJAxVgRKQEHYpPDX0QM3oECBUQAA',
        status: 'Preparing',
        date: '2024-11-6 23:22:00'),
  ];
  final List<String> _orderStatusList = [
    'Pending',
    'Preparing',
    'Ready for pickup',
    'pickup'
  ];
  bool showStatusChangeDialog = false;
  // String? _selectedOrderId;
  String? _selectedStatus;
  String? _selectedFilterStatus;
  String? _selectedFilterPayment;
  String? _selectedSort;

  List<OrderModel> get orders => _orders;
  List<String> get orderStatus => _orderStatusList;
  // String? get selectedOrderId => _selectedOrderId;
  String? get selectedStatus => _selectedStatus;
  String? get selectedFilterStatus => _selectedFilterStatus;
  String? get selectedFilterPayment => _selectedFilterPayment;
  String? get selectedSort => _selectedSort;

  void sortOrders() {
    if (_selectedSort == 'old_to_new') {
      _orders.sort((a, b) => a.date.compareTo(b.date));
    } else if (_selectedSort == 'new_to_od') {
      _orders.sort((a, b) => b.date.compareTo(a.date));
    }
    notifyListeners();
  }

  void filterOrders() {
    List<OrderModel> filterList = _orders.where((order) {
      return order.status == _selectedFilterStatus ||
          order.paymentMethod == _selectedFilterPayment;
    }).toList();
    _orders = filterList;
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

  void showChangeOrderStatusDialog(String orderId) {
    showStatusChangeDialog = true;
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

  void changeOrderStatus(String? orderId, String? newStatus) {
    final orderIndex = _orders.indexWhere((o) => o.id == orderId);
    if (orderIndex != -1) {
      _orders[orderIndex].status = newStatus;

      _selectedStatus=null;
      notifyListeners();
    }
    showStatusChangeDialog = false;
  }

  int getStatusIndex(String status) {
    switch (status) {
      case 'Pending':
        return 0;
      case 'Preparing':
        return 1;
      case 'Ready for pickup':
        return 2;
      case 'Pick up':
        return 3;
    }
    return -1;
  }

  void showBottomSheetForSort(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Consumer<OrderProvider>(builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sort by',
                        style: Theme.of(context).textTheme.displayMedium),
                    TextButton(
                        onPressed: () {
                          provider.resetSort();
                        },
                        child: Text('Clear',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                ))),
                  ],
                ),
                RadioListTile<String>(
                  title: Text('Date : old to new',
                      style: Theme.of(context).textTheme.displaySmall),
                  value: 'old_to_new',
                  groupValue: provider.selectedSort,
                  onChanged: (value) => updateSelectedSort(value),
                ),
                RadioListTile<String>(
                  title: Text('Date : new to old',
                      style: Theme.of(context).textTheme.displaySmall),
                  value: 'new_to_old',
                  groupValue: provider.selectedSort,
                  onChanged: (value) => updateSelectedSort(value),
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        provider.sortOrders();
                        Navigator.of(context).pop();
                      },
                      child: Text('Save',
                          style: Theme.of(context).textTheme.displayMedium)),
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
      builder: (context) {
        return Consumer<OrderProvider>(builder: (context, provider, child) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            padding: const EdgeInsets.all(10),
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
                      Text('Filter',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w900)),
                      TextButton(
                          onPressed: () {
                            provider.resetFilter();
                          },
                          child: Text('Clear',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Order Status',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.w900)),
                  RadioListTile<String>(
                    title: Text('Pending',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.grey)),
                    value: 'pending',
                    groupValue: provider.selectedFilterStatus,
                    onChanged: (value) => updateSelectedFilterStatus(value),
                  ),
                  RadioListTile<String>(
                    title: Text('preparing',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.grey)),
                    value: 'preparing',
                    groupValue: provider.selectedFilterStatus,
                    onChanged: (value) => updateSelectedFilterStatus(value),
                  ),
                  RadioListTile<String>(
                    title: Text('Ready',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.grey)),
                    value: 'Ready',
                    groupValue: provider.selectedFilterStatus,
                    onChanged: (value) => updateSelectedFilterStatus(value),
                  ),
                  RadioListTile<String>(
                    title: Text('Completed',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.grey)),
                    value: 'Completed',
                    groupValue: provider.selectedFilterStatus,
                    onChanged: (value) => updateSelectedFilterStatus(value),
                  ),
                  RadioListTile<String>(
                    title: Text('Canceled',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.grey)),
                    value: 'Canceled',
                    groupValue: provider.selectedFilterStatus,
                    onChanged: (value) => updateSelectedFilterStatus(value),
                  ),
                  const SizedBox(height: 10),
                  Text('Payment method',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.w900)),
                  RadioListTile<String>(
                    title: Text('CASH',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.grey)),
                    value: 'CASH',
                    groupValue: provider.selectedFilterPayment,
                    onChanged: (value) => updateSelectedFilterPayment(value),
                  ),
                  RadioListTile<String>(
                    title: Text('CREDIT_CARD',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.grey)),
                    value: 'CREDIT_CARD',
                    groupValue: provider.selectedFilterPayment,
                    onChanged: (value) => updateSelectedFilterPayment(value),
                  ),
                  RadioListTile<String>(
                    title: Text('MADA',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.grey)),
                    value: 'MADA',
                    groupValue: provider.selectedFilterPayment,
                    onChanged: (value) => updateSelectedFilterPayment(value),
                  ),
                  RadioListTile<String>(
                    title: Text('APPLE',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.grey)),
                    value: 'APPLE',
                    groupValue: provider.selectedFilterPayment,
                    onChanged: (value) => updateSelectedFilterPayment(value),
                  ),
                  RadioListTile<String>(
                    title: Text('PORTAL',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.grey)),
                    value: 'PORTAL',
                    groupValue: provider.selectedFilterPayment,
                    onChanged: (value) => updateSelectedFilterPayment(value),
                  ),
                  RadioListTile<String>(
                    title: Text('WALLET',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.grey)),
                    value: 'WALLET',
                    groupValue: provider.selectedFilterPayment,
                    onChanged: (value) => updateSelectedFilterPayment(value),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          sortOrders();
                          Navigator.of(context).pop();
                        },
                        child: Text('Save',
                            style: Theme.of(context).textTheme.displayMedium)),
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
