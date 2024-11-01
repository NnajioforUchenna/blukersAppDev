import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../models/industry.dart';
import '../../../../services/on_hover.dart';
import '../../../../services/responsive.dart';
import '../../../../utils/localization/localized_industries.dart';
import '../../../../utils/styles/theme_colors.dart';
import 'industry_body_panel.dart';

class IndustryHeadPanel extends StatefulWidget {
  final Industry industry;
  final Function getRecords;
  const IndustryHeadPanel(
      {super.key, required this.industry, required this.getRecords});

  @override
  State<IndustryHeadPanel> createState() => _IndustryHeadPanelState();
}

class _IndustryHeadPanelState extends State<IndustryHeadPanel> {
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
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: Responsive.isDesktop(context) ? 70 : 50,
                        height: Responsive.isDesktop(context) ? 70 : 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit
                                .cover, // This ensures the image covers the circular area
                            image: AssetImage(widget.industry.imageUrl!),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Responsive.isDesktop(context) ? 25 : 10),
                    Expanded(
                        child: Text(
                      LocalizedIndustries.get(
                          context, widget.industry.industryId),
                      style: TextStyle(
                        fontSize: Responsive.isDesktop(context) ? 30 : 20,
                        fontWeight: FontWeight.w700,
                        color: ThemeColors.grey1ThemeColor,
                      ),
                    )),
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: ThemeColors.grey1ThemeColor,
                        ))
                  ],
                ),
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
            ? IndustryBodyPanel(
                jobs: widget.industry.jobs.values.toList(),
                getRecords: widget.getRecords,
              )
            : Container(),
      ],
    );
  }
}
