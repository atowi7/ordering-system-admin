import 'package:flutter/material.dart';
import 'package:ordering_system_admin/models/notification_model.dart';
import 'package:ordering_system_admin/services/notification_services.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationModel? _notification;
  List<NotificationModel>? _notifications;

  NotificationModel? get notification => _notification;
  List<NotificationModel>? get notifications => _notifications;

  final notificationService = NotificationServices();

  Future<void> getNotifiations() async {
    final fetchedData = await notificationService.getNotifiations();
    if (fetchedData != null || fetchedData!.isNotEmpty) {
      _notifications = fetchedData;
    }
  }

  void onRefresh() {
    notifyListeners();
  }
}
