import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_images.dart';
import 'package:ordering_system_admin/design_system/app_text.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/providers/notification_provider.dart';
import 'package:ordering_system_admin/shared/heading.dart';
import 'package:ordering_system_admin/views/notification/manager/manager.dart';
import 'package:ordering_system_admin/views/notification/widgets/notificationlist.dart';
import 'package:ordering_system_admin/views/profile/widgets/profile_appbar.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationManager manager = NotificationManager(context: context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          return RefreshIndicator(
              onRefresh: () async {
                manager.onRefresh();
              },
              child: ListView(
                children: [

 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Heading(title: AppText.notificationTitle),
                    ],
                  ),
                ),                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  FutureBuilder(
                      future: manager.loadData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Lottie.asset(
                                  AppImages.loading,
                                  delegates: LottieDelegates(values: [
                                    ValueDelegate.color(const [
                                      'Shape Layer 1',
                                      'Rectangle',
                                      'Fill 1'
                                    ], value: AppColors.primaryColor),
                                  ]),
                                ),
                              ),
                              Text('Please wait ...', style: AppTheme.loadText)
                            ],
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return provider.notification == null
                              ? const Center(
                                  child: Text(
                                  'No data found',
                                  style: AppTheme.errorText,
                                ))
                              : NotificationList(
                                  notifications: provider.notifications!);
                        } else if (snapshot.hasError) {
                          return Text('Error ${snapshot.error}',
                              style: AppTheme.errorText);
                        }

                        return const Center(
                          child: Text(
                            'No data found',
                            style: AppTheme.errorText,
                          ),
                        );
                      })
                ],
              ));
        },
      ),
    );
  }
}
