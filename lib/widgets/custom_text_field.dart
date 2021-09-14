import 'package:flutter/material.dart';
import 'package:the_social/constants/constant_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;

  CustomTextField({required this.textEditingController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: ConstantColors().whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        style: TextStyle(
          color: ConstantColors().whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
