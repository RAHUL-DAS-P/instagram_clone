import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController cont;
  final bool isPass;
  final String hintTxt;
  final TextInputType textInputType;

  const TextFieldInput({
    required this.cont,
    required this.hintTxt,
    this.isPass = false,
    required this.textInputType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextField(
      controller: cont,
      decoration: InputDecoration(
          hintText: hintTxt,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          border: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8)),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
