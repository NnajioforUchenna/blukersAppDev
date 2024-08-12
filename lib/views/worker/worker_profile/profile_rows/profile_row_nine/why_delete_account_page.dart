import '../../../../../providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/styles/theme_colors.dart';
import '../../../../old_common_views/small_pop_button_widget.dart';
import 'custom_check_box.dart';

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
    double height = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
    selected = up.getWhyDeleteAccount();

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      insetPadding:
          const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 80),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
                top: height * 0.05,
                bottom: height * 0.05,
                right: width * 0.1,
                left: width * 0.1),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.05,
                      bottom: height * 0.025,
                      right: width * 0.1,
                      left: width * 0.1),
                  child: Text(
                    'Why are you deleting your account?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: ThemeColors.secondaryThemeColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                // Display using for loop
                for (var question in questions.keys)
                  QuestionRow(question, questions[question]!, context),

                const Spacer(),
                TextInputWigdet(
                  label: 'If Other, please specify',
                  maxlines: 5,
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
                const Spacer(),
                Container(
                  height: height * 0.03,
                  width: width * 0.23,
                  margin: EdgeInsets.only(top: height * 0.03, bottom: 30.0),
                  child: ElevatedButton(
                    onPressed:
                        otherController.text.length > 20 || selected.length > 20
                            ? () {
                                Navigator.of(context).pop();
                              }
                            : null,
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: ThemeColors.secondaryThemeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Update',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 10, // Adjust as needed
            left: 10, // Adjust as needed
            child: SmallPopButtonWidget(),
          ),
        ],
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
        margin: const EdgeInsets.only(
            bottom: 10.0, top: 10.0, left: 10.0, right: 10.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                question,
                style: GoogleFonts.montserrat(
                    fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            CustomCheckbox(value: selected == question),
          ],
        ),
      ),
    );
  }

  TextInputWigdet(
      {required String label,
      required int maxlines,
      required TextEditingController controller,
      required Null Function(dynamic value) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: (value) =>
              value!.isEmpty ? AppLocalizations.of(context)!.required : null,
          onChanged: onChanged,
          maxLines: maxlines,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        )
      ],
    );
  }
}
