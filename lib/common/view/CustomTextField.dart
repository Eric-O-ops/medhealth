import 'package:flutter/material.dart';
import '../../styles/app_colors.dart';

// ⭐️ ПРЕОБРАЗОВАНО В StatelessWidget
class CustomTextFuild extends StatelessWidget {
  final String label;
  final String hintText;
  final int? maxLines;
  final String? Function(String?) validator;
  final void Function(String? value)? onChanged; // Сделаем опциональным
  final TextInputType? keyboardType;
  final TextEditingController? controller; // ⭐️ ДОБАВЛЕНО: Контроллер

  const CustomTextFuild({
    super.key,
    required this.label,
    required this.hintText,
    this.maxLines = 1,
    required this.validator,
    this.onChanged, // Теперь может быть null
    this.keyboardType,
    this.controller, // ⭐️ ДОБАВЛЕНО: Принимаем контроллер
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.blue,
            ),
          ),
        ),

        TextFormField(
          controller: controller, // ⭐️ ИСПОЛЬЗУЕМ КОНТРОЛЛЕР ВНУТРИ
          validator: validator,

          // onChanged используем только если не передан контроллер
          onChanged: onChanged != null && controller == null ? (String? value) => onChanged!(value) : null,

          minLines: 1,
          maxLines: maxLines,
          keyboardType:
          keyboardType ??
              ((maxLines == null || maxLines! > 1)
                  ? TextInputType.multiline
                  : TextInputType.text),

          style: const TextStyle(
            color: AppColors.blue,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),

          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.hintBlue,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.lightBlue, width: 1.5),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
            ),

            errorStyle: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),

        const SizedBox(height: 8),
      ],
    );
  }
}