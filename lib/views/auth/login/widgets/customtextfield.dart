import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.obscureText,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Row(
        children: [
          Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(
                Icons.person_2,
                color: Colors.white,
                size: 20,
              )),
          const VerticalDivider(
            thickness: 1,
            color: Colors.black,
            width: 2,
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(0, 8),
                  child: Text(label, style: AppTheme.logintextFormLabel),
                ),
                TextFormField(
                  controller: controller,
                  validator: validator,
                  style: AppTheme.logintextFormtext,
                  decoration: InputDecoration(
                    hintStyle: AppTheme.logintextFormHint,
                    hintText: hint,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0.0,
                      ),
                      // contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  obscureText: obscureText,
                  obscuringCharacter: obscureText ? '•' : ' ',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
