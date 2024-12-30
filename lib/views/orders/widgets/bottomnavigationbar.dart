import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        
      },
        backgroundColor: AppColors.backgroundColor,
        selectedItemColor: AppColors.primaryColor,
        selectedFontSize: 20,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 15,
        items: [
         BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded),
      label: 'Orders',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_rounded),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications_rounded),
      label: 'Notifications',
    ),
        ]);
  }
}
