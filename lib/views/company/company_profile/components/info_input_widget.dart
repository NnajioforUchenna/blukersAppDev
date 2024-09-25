import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoInputWidget extends StatelessWidget {
  const InfoInputWidget(
      {super.key,
      required this.label,
      required this.controller,
      this.textInputType,
      this.maxLines});
  final String label;
  final int? maxLines;
  final TextEditingController controller;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.isMobile(context) ? 13: 20,
              color: const Color(0xFF8C8C8C)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: textInputType,
          maxLines: maxLines,
          controller: controller,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600, fontSize: Responsive.isMobile(context) ? 13: 20, color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: Responsive.isMobile(context) ? 16: 24),
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Color(0xFFD0D0D5)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Color(0xFFD0D0D5)),
            ),
          ),
        )
      ],
    );
  }
}
