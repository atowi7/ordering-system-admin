import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';

class FilterButton extends StatelessWidget {
  final void Function()? onSaved;
  const FilterButton({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: onSaved,
            child: const Text('Save', style: AppTheme.saveBtn)),
      ),
    );
  }
}
