import 'package:flutter/material.dart';

class CustomProfileCard extends StatelessWidget {
  final String title;
  final String text;
  const CustomProfileCard({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      // width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(text),
        ],
      ),
    );
  }
}
