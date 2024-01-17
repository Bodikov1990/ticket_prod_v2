import 'package:flutter/material.dart';

class FixedWidthColumn extends StatelessWidget {
  final double width;
  final double? height;
  final Widget child;

  const FixedWidthColumn(
      {super.key, required this.width, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }
}
