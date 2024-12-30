import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';
import 'package:ordering_system_admin/design_system/app_images.dart';
import 'package:ordering_system_admin/design_system/app_text.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/views/profile/manager/manager.dart';
import 'package:ordering_system_admin/views/profile/widgets/customprofilecard.dart';
import 'package:ordering_system_admin/shared/heading.dart';
import 'package:ordering_system_admin/views/profile/widgets/profile_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileManager manager = ProfileManager(context: context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Heading(title: AppText.profileTitle),
              Flexible(child: ProfileAppBar(onLogout: manager.logout)),
            ],
          ),
          FutureBuilder(
            future: manager.loadUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Lottie.asset(
                        AppImages.loading,
                        delegates: LottieDelegates(values: [
                          ValueDelegate.color(
                              const ['Shape Layer 1', 'Rectangle', 'Fill 1'],
                              value: AppColors.primaryColor),
                        ]),
                      ),
                    ),
                    // Text('Please wait ...',
                    //     style: AppTheme.loadText)
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    CustomProfileCard(
                        title: 'User Name', text: manager.username),
                    CustomProfileCard(title: 'Email', text: manager.email),
                    CustomProfileCard(
                        title: 'You joined on', text: manager.createdAt),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error ${snapshot.error}',
                    style: AppTheme.errorText);
              }

              return const Center(
                child: Text(
                  'No order found',
                  style: AppTheme.errorText,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
