import 'package:flutter/material.dart';
import 'package:samy/core/style/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool? obsecureText;

  final void Function()? onTap;
  const CustomTextField(
      {super.key,
      this.hintText,
      required this.prefixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.maxLength,
      this.obsecureText,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      obscureText: obsecureText ?? false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          prefixIconColor: Colors.grey,
          suffixIcon: GestureDetector(onTap: onTap, child: Icon(suffixIcon)),
          border: defoutlineborder(),
          disabledBorder: defoutlineborder(),
          focusedBorder: outlineborder()),
    );
  }

  OutlineInputBorder defoutlineborder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 2),
      borderRadius: BorderRadius.circular(10),
    );
  }

  OutlineInputBorder outlineborder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.defColor, width: 2),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
