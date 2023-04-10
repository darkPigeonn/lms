import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms/app/core/values/colors.dart';

class SocialLoginButton extends StatelessWidget {
  final String text, iconAsset;
  final Color textColor, backgroundColor;
  final Color? outline;
  final VoidCallback onPressed;

  const SocialLoginButton(
      {super.key,
      required this.text,
      required this.iconAsset,
      this.textColor = AppColors.black,
      this.backgroundColor = AppColors.white,
      this.outline,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(25),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(25),
            border:
                outline != null ? Border.all(color: outline!, width: 1) : null,
          ),
          child: Row(
            children: [
              Image.asset(
                iconAsset,
                height: 26,
                width: 26,
              ),
              const SizedBox(width: 24),
              Text(
                text,
                style: TextStyle(
                  fontSize: 17,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
