import 'package:flutter/material.dart';
import 'package:ordering_system_admin/providers/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationManager {
  final BuildContext context;
  late final NotificationProvider _notificationProvider;
  // late List<NotificationModel>? notifications;

  NotificationManager({required this.context}) {
    _notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
  }

  Future<void> loadData() async {
    await _notificationProvider.getNotifiations();
  }

  Future<void> onRefresh() async {
    _notificationProvider.onRefresh();
  }
}
