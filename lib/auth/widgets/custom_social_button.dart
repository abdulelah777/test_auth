import 'package:auth/auth/widgets/animated_button.dart';
import 'package:auth/auth/widgets/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String icon;
  final double? margin;
  const CustomSocialButton({
    required this.onTap,
    required this.text,
    required this.icon,
    this.margin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onTap: onTap,
      child: PrimaryContainer(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const Spacer(),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
