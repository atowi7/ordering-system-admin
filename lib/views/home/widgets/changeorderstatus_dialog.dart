import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';

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
              Text('Choose the status that matches the order number $orderId',
                  style: AppTheme.changeOrderStatusSubHead),
              RadioListTile<String>(
                title: Transform.translate(
                  offset: const Offset(-16, 0),
                  child:
                      const Text('Pending', style: AppTheme.orderStatusTitle),
                ),
                value: 'Pending',
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
                    child: const Text('Preparing',
                        style: AppTheme.orderStatusTitle),
                  ),
                  value: 'Preparing',
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
                    child:
                        const Text('Ready', style: AppTheme.orderStatusTitle),
                  ),
                  value: 'Ready',
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
                    child: const Text('Completed',
                        style: AppTheme.orderStatusTitle),
                  ),
                  value: 'Completed',
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
                    child: const Text('Canceled',
                        style: AppTheme.orderStatusTitle),
                  ),
                  value: 'Canceled',
                  groupValue: selectedStatus,
                  fillColor: WidgetStateProperty.all(Colors.grey),
                  onChanged: (value) {
                    onStatusUpdated(value!);
                  },
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -50),
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
                      child: const Text('Change', style: AppTheme.saveBtn)),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -50),
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
