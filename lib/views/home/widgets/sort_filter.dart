import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';

class SortFilter extends StatelessWidget {
  final VoidCallback onSortPressed;
  final VoidCallback onFilterPressed;
  const SortFilter(
      {super.key, required this.onSortPressed, required this.onFilterPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: onSortPressed,
              icon: Transform.translate(
                offset: const Offset(8, 0),
                child: const Icon(
                  Icons.unfold_more,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              label: const Text('Sort',
                  style: AppTheme.floatBtnHead)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: VerticalDivider(thickness: 1, width: 1, color: Colors.white),
          ),
          TextButton.icon(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: onFilterPressed,
              icon: const Icon(
                Icons.filter_alt,
                size: 16,
                color: Colors.white,
              ),
              label: Transform.translate(
                offset: const Offset(-8, 0),
                child: const Text('Filter',
                    style: AppTheme.floatBtnHead),
              )),
        ],
      ),
    );
  }
}
