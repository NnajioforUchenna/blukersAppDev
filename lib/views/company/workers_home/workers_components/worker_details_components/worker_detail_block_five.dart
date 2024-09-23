import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../services/responsive.dart';


class WorkerDetailBlockFive extends StatelessWidget {
  final List<String> skills;

  const WorkerDetailBlockFive({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Responsive.isMobile(context) ? 16 : 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Skills",
            style: GoogleFonts.montserrat(
                fontSize: Responsive.isMobile(context) ? 14 : 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: skills
                .map((skill) => SkillContainer(
                      label: skill,
                    ))
                .toList(),
          ),
           SizedBox(height: Responsive.isMobile(context) ? 150 :30),
        ],
      ),
    );
  }
}

class SkillContainer extends StatelessWidget {
  final String label;
  const SkillContainer({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 5 : 10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(241, 101, 34, 0.02),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ThemeColors.secondaryThemeColorDark,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.montserrat(
          color: ThemeColors.secondaryThemeColorDark,
          fontSize:Responsive.isMobile(context) ? 12 : 16,
        ),
      ),
    );
  }
}
