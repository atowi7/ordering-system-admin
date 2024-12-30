import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';

class SortOption extends StatelessWidget {
  final String title;
  final String value;
  final String? groupValue;
  final void Function(String?)? onChanged;
  final double dy;
  const SortOption(
      {super.key,
      required this.title,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.dy});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-8, dy),
      child: RadioListTile<String>(
        title: Transform.translate(
          offset: const Offset(-16, 0),
          child:  Text(title, style: AppTheme.sortOpt),
        ),
        contentPadding: EdgeInsets.zero,
        fillColor: WidgetStateProperty.all(Colors.grey),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
