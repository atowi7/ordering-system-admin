import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';
import 'package:ordering_system_admin/views/home/manager/manager.dart';
import 'package:ordering_system_admin/views/home/widgets/sort_btn.dart';
import 'package:ordering_system_admin/views/home/widgets/sort_opt.dart';

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  String? _selectedSort;

  @override
  Widget build(BuildContext context) {
    HomeManager manager = HomeManager(context: context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Sort by', style: AppTheme.sortHead),
              TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedSort = null;
                      manager.resetSort();
                    });
                  },
                  child: const Text('Clear', style: AppTheme.clearBtn)),
            ],
          ),
          SortOption(
              title: 'Date : new to old',
              value: 'new_to_old',
              groupValue: _selectedSort,
              onChanged: (value) {
                setState(() {
                  _selectedSort = value;
                });
              },
              dy: -8),
          SortOption(
            title: 'Date : old to new',
            value: 'old_to_new',
            groupValue: _selectedSort,
            onChanged: (value) {
              setState(() {
                _selectedSort = value;
              });
            },
            dy: -16,
          ),
          FilterButton(
            onSaved: () {
              manager.sortOrders(_selectedSort);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
