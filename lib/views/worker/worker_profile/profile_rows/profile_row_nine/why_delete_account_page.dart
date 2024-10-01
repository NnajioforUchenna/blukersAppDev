import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../services/responsive.dart';
import '../../../../../utils/styles/theme_colors.dart';

class WhyDeleteAccountPage extends StatefulWidget {
  const WhyDeleteAccountPage({super.key});

  @override
  State<WhyDeleteAccountPage> createState() => _WhyDeleteAccountPageState();
}

class _WhyDeleteAccountPageState extends State<WhyDeleteAccountPage> {
  String selected = '';
  TextEditingController otherController = TextEditingController();

  Map<String, bool> questions = {
    'I am not satisfied with the experience': false,
    'I want to delete a duplicated account': false,
    'I do not use Blukers anymore': false,
    'Other': false,
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    UserProvider up = Provider.of<UserProvider>(context);
    selected = up.getWhyDeleteAccount();

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      child: SizedBox(
        width: width * (Responsive.isMobile(context) ? 0.6 : 0.8),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isMobile(context) ? 25 : 40,
          ),
          child: Column(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(
                        'Whty are you deleting you account?',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: Responsive.isMobile(context) ? 20 : 29),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    for (var question in questions.keys)
                      QuestionRow(question, questions[question]!, context),
                    if (selected == "Other")
                      const SizedBox(
                        height: 14,
                      ),
                    if (selected == "Other")
                      TextInputWigdet(
                        maxlines: 4,
                        controller: otherController,
                        onChanged: (value) {
                          setState(() {
                            questions['Other'] = true;
                            selected = value;
                            Provider.of<UserProvider>(context, listen: false)
                                .setWhyDeleteAccount(value);
                          });
                        },
                      ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: otherController.text.length > 20 ||
                                selected.length > 20
                            ? () {
                                Navigator.of(context).pop();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColors.primaryThemeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Update',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: Responsive.isMobile(context) ? 16 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget QuestionRow(
    String question,
    bool value,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          selected = question;
          Provider.of<UserProvider>(context, listen: false)
              .setWhyDeleteAccount(selected);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFFD0D0D5))),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                question,
                style: GoogleFonts.montserrat(
                  color: ThemeColors.black1ThemeColor,
                  fontSize: Responsive.isMobile(context) ? 16 : 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 18,
              width: 18,
              child: Checkbox(
                  side: const BorderSide(color: ThemeColors.ash, width: 1),
                  activeColor: ThemeColors.primaryThemeColor,
                  value: selected == question,
                  onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }

  TextInputWigdet(
      {required int maxlines,
      required TextEditingController controller,
      required Null Function(dynamic value) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          validator: (value) =>
              value!.isEmpty ? AppLocalizations.of(context)!.required : null,
          onChanged: onChanged,
          maxLines: maxlines,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.isMobile(context) ? 13 : 20,
              color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Please specify',
            hintStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: Responsive.isMobile(context) ? 13 : 14,
                color: const Color(0xFF6D7178)),
            filled: true,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: Responsive.isMobile(context) ? 16 : 24),
            fillColor: const Color(0xFFF4F4F4),
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
