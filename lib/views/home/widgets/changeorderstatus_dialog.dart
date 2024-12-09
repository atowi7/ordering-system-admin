import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/views/home/manager/manager.dart';

class ChangeOrderStatusDialog extends StatelessWidget {
  final int? orderId;
  final String? selectedStatus;
  final Function(String?) onStatusChanged;
  final Function(String) onStatusUpdated;
  const ChangeOrderStatusDialog(
      {super.key,
      required this.orderId,
      required this.selectedStatus,
      required this.onStatusUpdated,
      required this.onStatusChanged});

  @override
  Widget build(BuildContext context) {
    HomeManager manager = HomeManager(context: context);
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Change Order Status',
          textAlign: TextAlign.center, style: AppTheme.changeOrderStatusHead),
      content: SizedBox(
        height: 350,
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: manager.getOrderStatuses(),
              builder: (context, snapshot) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        'Choose the status that matches the order number $orderId',
                        style: AppTheme.changeOrderStatusSubHead),
                    // for (final status in manager.orderStatusList!)
                    //   RadioListTile<String>(
                    //     title: Text(status['name'],
                    //         style: AppTheme.orderStatusTitle),
                    //     value: status['value'].toString(),
                    //     groupValue: selectedStatus,
                    //     fillColor: WidgetStateProperty.all(Colors.grey),
                    //     onChanged: (value) {
                    //       if (value != null) {
                    //         onStatusUpdated(value);
                    //       }
                    //     },
                    //   ),
                    RadioListTile<String>(
                      title: Transform.translate(
                        offset: const Offset(-16, 0),
                        child: Text(
                            '${manager.orderStatusList?.isNotEmpty ?? false ? manager.orderStatusList![0]['name'] : 'Pending'}',
                            style: AppTheme.orderStatusTitle),
                      ),
                      value:
                          '${manager.orderStatusList?.isNotEmpty ?? false ? manager.orderStatusList![0]['name'] : 'Pending'}',
                      groupValue: selectedStatus,
                      fillColor: WidgetStateProperty.all(Colors.grey),
                      onChanged: (value) {
                        if (value != null) {
                          onStatusUpdated(value);
                        }
                      },
                    ),
                    Transform.translate(
                      offset: const Offset(0, -15),
                      child: RadioListTile<String>(
                        title: Transform.translate(
                          offset: const Offset(-16, 0),
                          child: Text(
                              '${manager.orderStatusList?.isNotEmpty ?? false ? manager.orderStatusList![1]['name'] : 'Preparing'}',
                              style: AppTheme.orderStatusTitle),
                        ),
                        value:
                            '${manager.orderStatusList?.isNotEmpty ?? false ? manager.orderStatusList![1]['name'] : 'Preparing'}',
                        groupValue: selectedStatus,
                        fillColor: WidgetStateProperty.all(Colors.grey),
                        onChanged: (value) {
                          if (value != null) {
                            onStatusUpdated(value);
                          }
                        },
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -30),
                      child: RadioListTile<String>(
                        title: Transform.translate(
                          offset: const Offset(-16, 0),
                          child: Text(
                              '${manager.orderStatusList?.isNotEmpty ?? false ? manager.orderStatusList![2]['name'] : 'Ready For Pickup'}',
                              style: AppTheme.orderStatusTitle),
                        ),
                        value:
                            '${manager.orderStatusList?.isNotEmpty ?? false ? manager.orderStatusList![2]['name'] : 'Ready For Pickup'}',
                        groupValue: selectedStatus,
                        fillColor: WidgetStateProperty.all(Colors.grey),
                        onChanged: (value) {
                          if (value != null) {
                            onStatusUpdated(value);
                          }
                        },
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -45),
                      child: RadioListTile<String>(
                        title: Transform.translate(
                          offset: const Offset(-16, 0),
                          child: Text(
                              '${manager.orderStatusList?.isNotEmpty ?? false ? manager.orderStatusList![3]['name'] : 'Out for Delivery'}',
                              style: AppTheme.orderStatusTitle),
                        ),
                        value:
                            '${manager.orderStatusList?.isNotEmpty ?? false ? manager.orderStatusList![3]['name'] : 'Out for Delivery'}',
                        groupValue: selectedStatus,
                        fillColor: WidgetStateProperty.all(Colors.grey),
                        onChanged: (value) {
                          if (value != null) {
                            onStatusUpdated(value);
                          }
                        },
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -60),
                      child: RadioListTile<String>(
                        title: Transform.translate(
                          offset: const Offset(-16, 0),
                          child: Text(
                              '${manager.orderStatusList?.isNotEmpty ?? false ? manager.orderStatusList![4]['name'] : 'Completed'}',
                              style: AppTheme.orderStatusTitle),
                        ),
                        value:
                            '${manager.orderStatusList?.isNotEmpty ?? false ? manager.orderStatusList![4]['name'] : 'Completed'}',
                        groupValue: selectedStatus,
                        fillColor: WidgetStateProperty.all(Colors.grey),
                        onChanged: (value) {
                          if (value != null) {
                            onStatusUpdated(value);
                          }
                        },
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -75),
                      child: RadioListTile<String>(
                        title: Transform.translate(
                          offset: const Offset(-16, 0),
                          child: Text(
                              '${manager.orderStatusList?.isNotEmpty ?? false ? manager.orderStatusList![5]['name'] : 'Canceled'}',
                              style: AppTheme.orderStatusTitle),
                        ),
                        value:
                            '${manager.orderStatusList?.isNotEmpty ?? false ? manager.orderStatusList![5]['name'] : 'Canceled'}',
                        groupValue: selectedStatus,
                        fillColor: WidgetStateProperty.all(Colors.grey),
                        onChanged: (value) {
                          onStatusUpdated(value!);
                        },
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -75),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              if (selectedStatus != null) {
                                onStatusChanged(selectedStatus);
                                Navigator.of(context).pop();
                              }
                            },
                            child:
                                const Text('Change', style: AppTheme.saveBtn)),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -75),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel',
                                style: AppTheme.cancelBtn)),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
