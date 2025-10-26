import 'package:flutter/material.dart';
import '../../styles/app_colors.dart';

Widget CustomTextFieldPassword({
  required String label,
  required String hintText,
  required bool isObscure,
  required String? Function(String?) validator,
  required void Function(String? value) onChanged,
  required void Function() onTapSuffixIcon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsetsGeometry.only(left: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.blue,
          ),
        ),
      ),

      TextFormField(
        validator: validator,

        obscureText: isObscure,

        onChanged: (String? value) => onChanged(value),

        keyboardType: TextInputType.visiblePassword,

        style: TextStyle(
          color: AppColors.blue,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),

        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: IconButton(
            icon: Icon(
              isObscure ? Icons.visibility : Icons.visibility_off,
              color: AppColors.blue,
            ),
            onPressed: () => onTapSuffixIcon(),
          ),
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
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
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
            fontSize: 10,
          ),

          errorMaxLines: 2
        ),
      ),

      SizedBox(height: 8),
    ],
  );
}
