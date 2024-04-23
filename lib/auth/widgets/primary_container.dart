import 'package:flutter/material.dart';

class PrimaryContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double? width;
  final double? height;
  const PrimaryContainer({
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF329494).withOpacity(0.2),
            blurRadius: 7,
            offset: const Offset(0, 5),
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
