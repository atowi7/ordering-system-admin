import 'package:flutter/material.dart';

class CustomSeparator extends StatelessWidget {
  const CustomSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0.5),
        child: const Divider(
          color: Colors.grey,
          thickness: 1.5,
          height: 1,
        ),
      ),
    );
  }
}
