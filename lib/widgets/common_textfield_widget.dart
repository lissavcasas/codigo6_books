import 'package:flutter/material.dart';

class CommonTextFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final int? maxLines;
  final TextEditingController controller;

  const CommonTextFieldWidget({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.label,
    this.maxLines,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " $label:",
          ),
          const SizedBox(
            height: 5.0,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 12,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: TextFormField(
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hintText,
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(icon),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return "Campo obligatorio";
                }
                // if (value != null && value.length < 8) {
                //   return "El campo debe de tener más de 8 caracteres";
                // }

                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
