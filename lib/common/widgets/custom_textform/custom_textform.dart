import 'package:flutter/material.dart';

import '../../../Utils/Colors/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final labelText;
  final Color? hintTextColor;
  final initialValue;
  final hintText;
  final prefixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final validator;
  final suffixIcon;
  final border;
  final keyboardType;
  final onChanged;
  final inputFormatters;

  CustomTextFormField(
      {this.inputFormatters,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.isPassword = false,
      required this.controller,
      this.validator,
      this.hintText,
      this.border,
      this.hintTextColor,
      this.keyboardType,
      this.onChanged,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      initialValue: initialValue,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.myblue,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.inputInactive,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red, // Customize the error border color here
          ),
        ),
        prefixIcon: prefixIcon,
        labelText: labelText,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintTextColor ??
              Colors.grey, // Use provided color or default to grey
          fontStyle: FontStyle.italic, // Italicize the hint text (optional)
          // Add more styles as needed
        ),
        border: border,
        floatingLabelStyle: const TextStyle(color: AppColors.myblue),
      ),
    );
  }
}
