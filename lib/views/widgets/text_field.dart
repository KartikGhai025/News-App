import 'package:flutter/material.dart';

Widget buildInputField({
  required TextEditingController controller,
  required String hintText,
  bool obscureText = false,
  String? Function(String?)? validator,
}) {
  return SizedBox(
    width: 356,
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        color: Color(0XFF000000),
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0XFF000000),
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFFFFFFF),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      ),
      validator: validator,
    ),
  );
}
