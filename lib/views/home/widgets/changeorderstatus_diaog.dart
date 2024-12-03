import 'package:flutter/material.dart';

class ChangeOrderStatusDialog extends StatelessWidget {
  final String? orderId;
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
      title: Text('Change Order Status',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontWeight: FontWeight.w700)),
      content: SizedBox(
        height: 350,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Choose the status that matches the order number $orderId',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w500)),
              RadioListTile<String>(
                title: Transform.translate(
                  offset: const Offset(-16, 0),
                  child: Text('Pending',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 16, color: Colors.grey[500])),
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
                    child: Text('Preparing',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 16, color: Colors.grey[500])),
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
                    child: Text('Ready',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 16, color: Colors.grey[500])),
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
                    child: Text('Completed',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 16, color: Colors.grey[500])),
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
                    child: Text('Canceled',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 16, color: Colors.grey[500])),
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
                      child: Text('Change',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.white))),
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
                      child: Text('Cancel',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.grey[400]))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}