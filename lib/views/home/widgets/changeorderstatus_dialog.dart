import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';

class ChangeOrderStatusDialog extends StatefulWidget {
  final int? orderId;
  // final String? _selectedStatus;
  final List<Map<String, dynamic>> orderStatusList;

  final Function(String?) onStatusChanged;
  // final Function(String) onStatusUpdated;
  const ChangeOrderStatusDialog(
      {super.key,
      required this.orderId,
      required this.orderStatusList,
      required this.onStatusChanged});

  @override
  State<ChangeOrderStatusDialog> createState() =>
      _ChangeOrderStatusDialogState();
}

class _ChangeOrderStatusDialogState extends State<ChangeOrderStatusDialog> {
  String? _selectedStatus;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Change Order Status',
          textAlign: TextAlign.center, style: AppTheme.changeOrderStatusHead),
      content: SizedBox(
        height: 350,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Choose the status that matches the order number ${widget.orderId}',
                  style: AppTheme.changeOrderStatusSubHead),
              // for (final status in  orderStatusList!)
              //   RadioListTile<String>(
              //     title: Text(status['name'],
              //         style: AppTheme.orderStatusTitle),
              //     value: status['value'].toString(),
              //     groupValue: _selectedStatus,
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
                  child: Text(widget.orderStatusList[0]['name'],
                      style: AppTheme.orderStatusTitle),
                ),
                value: widget.orderStatusList[0]['name'],
                groupValue: _selectedStatus,
                fillColor: WidgetStateProperty.all(Colors.grey),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  }
                },
              ),
              Transform.translate(
                offset: const Offset(0, -15),
                child: RadioListTile<String>(
                  title: Transform.translate(
                    offset: const Offset(-16, 0),
                    child: Text(widget.orderStatusList[1]['name'],
                        style: AppTheme.orderStatusTitle),
                  ),
                  value: widget.orderStatusList[1]['name'],
                  groupValue: _selectedStatus,
                  fillColor: WidgetStateProperty.all(Colors.grey),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -30),
                child: RadioListTile<String>(
                  title: Transform.translate(
                    offset: const Offset(-16, 0),
                    child: Text(widget.orderStatusList[2]['name'],
                        style: AppTheme.orderStatusTitle),
                  ),
                  value: widget.orderStatusList[2]['name'],
                  groupValue: _selectedStatus,
                  fillColor: WidgetStateProperty.all(Colors.grey),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    }
                  },
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -45),
                child: RadioListTile<String>(
                  title: Transform.translate(
                    offset: const Offset(-16, 0),
                    child: Text(widget.orderStatusList[3]['name'],
                        style: AppTheme.orderStatusTitle),
                  ),
                  value: widget.orderStatusList[3]['name'],
                  groupValue: _selectedStatus,
                  fillColor: WidgetStateProperty.all(Colors.grey),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    }
                  },
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -60),
                child: RadioListTile<String>(
                  title: Transform.translate(
                    offset: const Offset(-16, 0),
                    child: Text(widget.orderStatusList[4]['name'],
                        style: AppTheme.orderStatusTitle),
                  ),
                  value: widget.orderStatusList[4]['name'],
                  groupValue: _selectedStatus,
                  fillColor: WidgetStateProperty.all(Colors.grey),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    }
                  },
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -75),
                child: RadioListTile<String>(
                  title: Transform.translate(
                    offset: const Offset(-16, 0),
                    child: Text(widget.orderStatusList[5]['name'],
                        style: AppTheme.orderStatusTitle),
                  ),
                  value: widget.orderStatusList[5]['name'],
                  groupValue: _selectedStatus,
                  fillColor: WidgetStateProperty.all(Colors.grey),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    }
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
                        if (_selectedStatus != null) {
                          widget.onStatusChanged(_selectedStatus);
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Change', style: AppTheme.saveBtn)),
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
                      child: const Text('Cancel', style: AppTheme.cancelBtn)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
