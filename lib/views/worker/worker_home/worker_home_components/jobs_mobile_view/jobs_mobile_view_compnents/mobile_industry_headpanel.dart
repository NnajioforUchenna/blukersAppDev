import 'package:blukers/providers/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
    AppSettingsProvider ap = Provider.of<AppSettingsProvider>(context);
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
                      widget.industry.name,
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
            ? MobileIndustryBodyPanel(
                jobs: widget.industry.jobs.values.toList())
            : Container(),
      ],
    );
  }
}
