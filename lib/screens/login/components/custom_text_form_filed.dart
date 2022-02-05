import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    Key? key,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    required this.hintLabel,
    this.validateMessage,
    this.keyboardType,
    this.isPassword = false,
    this.onFieldSubmitted,
  }) : super(key: key);

  final TextEditingController controller;
  final IconData prefixIcon;
  final IconButton? suffixIcon;
  final String hintLabel;
  final String? validateMessage;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final Function? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (newValue) {
        if (newValue!.isEmpty || newValue == null) {
          return validateMessage;
        }
        return null;
      },
      onFieldSubmitted: (value) =>
          isPassword as bool ? onFieldSubmitted!(value) : (value) {},
      keyboardType: keyboardType,
      obscureText: isPassword as bool,
      decoration: InputDecoration(
        label: Text(hintLabel),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.black,
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );
  }
}
