import 'package:blukers/utils/localization/localized_industries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../models/industry.dart';
import '../../../../../../services/on_hover.dart';
import '../../../../../../services/responsive.dart';
import '../../../../../../utils/styles/theme_colors.dart';
import 'mobile_industry_bodypanel.dart';

class MobileIndustryHeadPanel extends StatefulWidget {
  final Industry industry;

  const MobileIndustryHeadPanel({super.key, required this.industry});

  @override
  State<MobileIndustryHeadPanel> createState() =>
      _MobileIndustryHeadPanelState();
}

class _MobileIndustryHeadPanelState extends State<MobileIndustryHeadPanel> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: OnHover(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0XFFE5E5E5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  widget.industry.imageUrl!.contains('.svg')
                      ? SvgPicture.asset(widget.industry.imageUrl!,
                          colorFilter: ColorFilter.mode(
                              isExpanded
                                  ? ThemeColors.secondaryThemeColor
                                  : ThemeColors.black1ThemeColor,
                              BlendMode.srcIn),
                          width: Responsive.isDesktop(context) ? 40 : 28,
                          height: Responsive.isDesktop(context) ? 40 : 28,
                          fit: BoxFit.cover)
                      : Container(
                          width: Responsive.isDesktop(context) ? 40 : 28,
                          height: Responsive.isDesktop(context) ? 40 : 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit
                                  .cover, // This ensures the image covers the circular area
                              image: AssetImage(widget.industry.imageUrl!),
                            ),
                          ),
                        ),
                  SizedBox(width: Responsive.isDesktop(context) ? 25 : 10),
                  Expanded(
                      child: Text(
                    LocalizedIndustries.get(
                        context, widget.industry.industryId),
                    style: TextStyle(
                      fontSize: Responsive.isDesktop(context) ? 25 : 16,
                      color: isExpanded
                          ? ThemeColors.secondaryThemeColor
                          : ThemeColors.black1ThemeColor,
                    ),
                  )),
                  AnimatedRotation(
                    turns: isExpanded ? 0.25 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: isExpanded
                          ? ThemeColors.secondaryThemeColor
                          : ThemeColors.black1ThemeColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        isExpanded
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  AppLocalizations.of(context)!.selectAJobPosition,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: ThemeColors.secondaryThemeColor,
                  ),
                ),
              )
            : Container(),
        isExpanded
            ? IndustryBodyPanel(jobs: widget.industry.jobs.values.toList())
            : Container(),
      ],
    );
  }
}
