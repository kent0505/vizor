import 'package:flutter/material.dart';

import '../constants.dart';
import 'button.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    this.width,
    this.horizontal = 0,
    this.color,
    this.active = true,
    required this.onPressed,
  });

  final String title;
  final double? width;
  final double horizontal;
  final Color? color;
  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: 56,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: horizontal),
      decoration: BoxDecoration(
        color: color ?? (active ? Colors.greenAccent : Colors.redAccent),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: active ? onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: AppFonts.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
