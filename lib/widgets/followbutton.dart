import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? func;
  final String text;

  final Color bgcolor;
  final Color borderColor;
  final Color textcolor;

  const FollowButton(
      {super.key,
      required this.bgcolor,
      required this.borderColor,
      required this.text,
      required this.textcolor,
      this.func});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: func,
        child: Container(
          decoration: BoxDecoration(
            color: bgcolor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          width: 250,
          height: 27,
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
