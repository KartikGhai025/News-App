import 'package:flutter/material.dart';

PreferredSizeWidget buildAppBar(
    {required BuildContext context,
    required List<Widget> actions,
    required bool automaticallyImplyLeading,
    required String title}) {
  return AppBar(
    foregroundColor: Colors.white,
    elevation: 0,
    toolbarHeight: kToolbarHeight - 10,
    backgroundColor: const Color(0XFF0C54BE),
    automaticallyImplyLeading: automaticallyImplyLeading,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
      ),
    ),
    actions: actions,
  );
}
