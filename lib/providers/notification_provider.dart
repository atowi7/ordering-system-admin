import 'package:flutter/material.dart';
import 'package:ordering_system_admin/models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel>? _notifications;

  List<NotificationModel>? get notifications => _notifications;

  // Future<void> getNotifications() async {
  //   final fetchedData =
  //       await NotificationServices.instance.getSavedNotifications();
  //   _notifications = fetchedData.map((data) {
  //     return NotificationModel(
  //       title: data['title'] ?? '',
  //       text: data['body'] ?? '',
  //       createdAt: DateTime.now().toIso8601String().substring(0, 10),
  //     );
  //   }).toList();
  //   notifyListeners();
  // }

  // Future<void> deleteNotification(int index) async {
  //   await NotificationServices.instance.deleteNotification(index);
  //   await getNotifications();
  // }

  void onRefresh() {
    notifyListeners();
  }
}
