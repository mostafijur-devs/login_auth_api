import 'package:flutter/material.dart';

class CustomInputTextField extends StatelessWidget {
  const CustomInputTextField({
    super.key,
    this.suffixIcon,
    required this.hintText,
    required this.labelText,
    this.validationError,
    this.suffixTconButton,
    this.obscureTextValue,
    this.keyboardType,
    this.textEditingController,
  });

  final Icon? suffixIcon;
  final String hintText;
  final String labelText;
  final String? Function(String?)? validationError;
  final IconButton? suffixTconButton;
  final bool? obscureTextValue;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: keyboardType ?? TextInputType.name,
      autofocus: false,
      obscureText: obscureTextValue ?? false,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          gapPadding: 10,
          borderSide: BorderSide(width: 4, color: Colors.red),
        ),
        hintText: hintText,
        labelText: labelText,
        suffix: suffixTconButton,
        suffixIcon: suffixIcon,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          gapPadding: 10,
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          gapPadding: 10,
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          gapPadding: 10,
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          gapPadding: 10,
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: validationError,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return validationError;
      //   }
      //   return null;
      // },
    );
  }
}