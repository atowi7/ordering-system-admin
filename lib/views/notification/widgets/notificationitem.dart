import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/models/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Text('${notification.id}', style: AppTheme.orderItemId),
                  Text(notification.title, style: AppTheme.orderItemId),
                  Text(notification.text, style: AppTheme.orderItemId),
                  Text(notification.createdAt, style: AppTheme.orderItemId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
