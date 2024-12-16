import 'package:flutter/material.dart';
import 'package:ordering_system_admin/providers/order_provider.dart';
import 'package:provider/provider.dart';

class Update extends StatelessWidget {
  final Widget child;
  const Update({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (_, __, ___) {
        return child;
      },
    );
  }
}
