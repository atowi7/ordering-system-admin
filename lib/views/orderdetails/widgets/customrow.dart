import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';

class CustomItem extends StatelessWidget {
  final String title;
  final String text;
  const CustomItem({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * .1,
      // margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTheme.orderDetialsItemTitle,
          ),
          Text(text.length > 30 ? '${text.substring(0, 30)}...' : text, style: AppTheme.orderDetialsItemSubTitle),
        ],
      ),
    );
  }
}
