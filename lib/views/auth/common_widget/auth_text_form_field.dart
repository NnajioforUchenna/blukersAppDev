import 'package:blukers/utils/styles/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String hintText;
  final TextInputAction? textInputAction;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  const AuthTextFormField({super.key, required this.controller, required this.hintText, this.onEditingComplete, this.validator, this.keyboardType, this.textInputAction, this.onSaved, this.maxLines, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onChanged: onChanged,
        controller: controller,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        validator: validator,
        keyboardType: keyboardType,
        onSaved:onSaved,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: ThemeColors.black1ThemeColor.withOpacity(.30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide:
                  const BorderSide(width: 0, color: ThemeColors.red1ThemeColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                  width: 0, color: ThemeColors.secondaryThemeColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                  width: 0.5, color: Color.fromRGBO(227, 238, 246, 1)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                  width: 0.5, color: Color.fromRGBO(227, 238, 246, 1)),
            ),
            fillColor: Colors.white,
            filled: true));
  }
}
