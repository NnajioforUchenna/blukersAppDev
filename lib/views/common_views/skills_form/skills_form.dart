import 'package:flutter/material.dart';

import '../../../utils/localization/deviceLocale.dart';
import '../../../utils/styles/index.dart';
import '../../../utils/styles/theme_text_styles.dart';
import 'const_list_skills.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SkillsForm extends StatefulWidget {
  final List<String> selectedSkills;
  const SkillsForm({super.key, required this.selectedSkills});

  @override
  State<SkillsForm> createState() => _SkillsFormState();
}

class _SkillsFormState extends State<SkillsForm> {
  List<String> skills =
      DeviceLocale.get() == 'es' ? SkillsSpanish : SkillsEnglish;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AppLocalizations.of(context)!.selectSkills,
            textAlign: TextAlign.center,
            style: ThemeTextStyles.landingPageBtnThemeTextStyle
                .apply(color: ThemeColors.blukersOrangeThemeColor)),
        const SizedBox(height: 20),
        Container(
            height: MediaQuery.of(context).size.height * 0.4,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Wrap(
                  spacing: 10,
                  children: skills.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String skill = entry.value;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                        label: Text(skill),
                        selected: widget.selectedSkills.contains(skill),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              widget.selectedSkills.add(skill);
                            } else {
                              widget.selectedSkills.remove(skill);
                            }
                          });
                        },
                        backgroundColor: Color.fromARGB(255, 226, 226, 226),
                        selectedColor: Color.fromARGB(255, 255, 174, 137),
                      ),
                    );
                  }).toList(),
                ),
              ],
            )),
      ],
    );
  }
}
