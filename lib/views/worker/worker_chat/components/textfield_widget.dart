
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.label,
    required this.onChange,
    this.isObscureText = false,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final Function(String)? onChange;
  final bool isObscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscureText,
      keyboardType: keyboardType,
      onChanged: onChange,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.orange, fontSize: 12),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 2.0),
        ),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 15)
    );
  }
}
