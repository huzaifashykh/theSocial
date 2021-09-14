import 'package:flutter/material.dart';

class SocialBtn extends StatelessWidget {
  const SocialBtn({required this.color, required this.icon});
  final Color color;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 40.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: icon,
    );
  }
}
