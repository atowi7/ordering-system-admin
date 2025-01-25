import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_images.dart';
import 'package:ordering_system_admin/design_system/app_text.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/shared/heading.dart';
import 'package:ordering_system_admin/views/notification/widgets/notificationlist.dart';
import 'package:ordering_system_admin/views/notification/manager/manager.dart';
import 'package:ordering_system_admin/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = NotificationManager(context: context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder(
        future: manager.loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<NotificationProvider>(
              builder: (context, provider, _) {
                final notifications = provider.notifications ?? [];
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Heading(title: AppText.notificationTitle),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    notifications.isEmpty
                        ? Center(
                            child: Lottie.asset(AppImages.nodata),
                          )
                        : NotificationList(notifications: notifications),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'Error loading notifications',
                style: AppTheme.errorText,
              ),
            );
          }
        },
      ),
    );
  }
}
