import 'package:flutter/material.dart';
import 'package:ordering_system_admin/models/notification_model.dart';
import 'package:ordering_system_admin/providers/notification_provider.dart';
import 'package:ordering_system_admin/views/notification/widgets/customnotificationcard.dart';
import 'package:provider/provider.dart';

class NotificationList extends StatelessWidget {
  final List<NotificationModel> notifications;
  const NotificationList({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, _) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(
            // shrinkWrap: true,
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Column(
                children: [
                  CustomNotificationCard(
                    title: notification.title,
                    text: notification.text,
                    createdAt: notification.createdAt,
                    onDelete: () async {
                      await provider.deleteNotification(index);
                    },
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.4,
                    height: 2,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
