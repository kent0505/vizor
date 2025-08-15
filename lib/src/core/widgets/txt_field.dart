import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class TxtField extends StatelessWidget {
  const TxtField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
  });

  final TextEditingController controller;
  final String hintText;
  final bool readOnly;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      inputFormatters: [
        LengthLimitingTextInputFormatter(60),
        // if (number) FilteringTextInputFormatter.digitsOnly,
      ],
      textCapitalization: TextCapitalization.sentences,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: AppFonts.w500,
      ),
      decoration: InputDecoration(hintText: hintText),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
