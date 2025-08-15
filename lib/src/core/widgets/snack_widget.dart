import 'package:flutter/material.dart';

import '../constants.dart';

class SnackWidget {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 100),
        behavior: SnackBarBehavior.floating,
        content: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isError ? Colors.redAccent : Colors.greenAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isError ? Colors.white : Colors.black,
                fontSize: 14,
                fontFamily: AppFonts.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
