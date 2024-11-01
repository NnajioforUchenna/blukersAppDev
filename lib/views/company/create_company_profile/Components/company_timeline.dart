import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:unicons/unicons.dart';

import '../../../../providers/company_provider.dart';
import '../../../../services/responsive.dart';
import '../../../../utils/styles/theme_colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color highlightColor = ThemeColors.blukersOrangeThemeColor;

const companySteps = [
  'General Information',
  'Company Logo',
  'Contact Details',
  'Social Media',
  'Company Characteristics',
];

const List<Icon> companyIcons = [
  Icon(
    UniconsLine.info_circle,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.image,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.phone,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.link,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
  Icon(
    UniconsLine.building,
    color: ThemeColors.secondaryThemeColor,
    size: 30,
  ),
];

enum _CompanyStatus { done, doing, todo }

class CompanyTimeLine extends StatelessWidget {
  CompanyTimeLine({super.key});
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // Replace with your data provider
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    var currentStep = cp.companyProfileCurrentPageIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(currentStep * 120.0);
    });

    // return Container(
    //   margin: const EdgeInsets.all(8),
    //   constraints: const BoxConstraints(maxHeight: 140),
    //   child: ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     controller: _scrollController,
    //     itemCount: companySteps.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       final step = companySteps[index];
    //       var indicatorSize = 30.0;
    //       var beforeLineStyle = LineStyle(
    //         // color: Colors.white.withOpacity(0.8),
    //         color: ThemeColors.secondaryThemeColor,
    //       );
    //       LineStyle afterLineStyle =
    //           const LineStyle(color: ThemeColors.grey1ThemeColor);

    //       _CompanyStatus status;

    //       if (index < currentStep) {
    //         status = _CompanyStatus.done;
    //         afterLineStyle =
    //             const LineStyle(color: ThemeColors.secondaryThemeColor);
    //       } else if (index > currentStep) {
    //         status = _CompanyStatus.todo;
    //         indicatorSize = 20;
    //         beforeLineStyle =
    //             const LineStyle(color: ThemeColors.grey1ThemeColor);
    //       } else {
    //         status = _CompanyStatus.doing;
    //       }

    //       return SizedBox(
    //         width: Responsive.isDesktop(context)
    //             ? MediaQuery.of(context).size.width / 6
    //             : null,
    //         child: TimelineTile(
    //           axis: TimelineAxis.horizontal,
    //           alignment: TimelineAlign.manual,
    //           lineXY: 0.6,
    //           isFirst: index == 0,
    //           isLast: index == companySteps.length - 1,
    //           beforeLineStyle: beforeLineStyle,
    //           afterLineStyle: afterLineStyle,
    //           indicatorStyle: IndicatorStyle(
    //             width: indicatorSize,
    //             height: indicatorSize,
    //             indicator: _IndicatorCompany(status: status),
    //           ),
    //           startChild: _StartChildCompany(index: index),
    //           endChild: _EndChildCompany(
    //             text: step,
    //             current: index == currentStep,
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );

    List<String> stepsLocalized = [
      AppLocalizations.of(context)!.generalInformation,
      AppLocalizations.of(context)!.uploadCompanyLogo,
      AppLocalizations.of(context)!.contactDetails,
      AppLocalizations.of(context)!.socialMediaInformation,
      AppLocalizations.of(context)!.aboutYourCompany,
    ];

    return Column(
      children: [
        Container(
          color: Colors.white,
          // margin: const EdgeInsets.all(8),
          constraints: const BoxConstraints(maxHeight: 140),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: companySteps.length,
            itemBuilder: (BuildContext context, int index) {
              final step = companySteps[index];
              var indicatorSize = 30.0;
              var beforeLineStyle = const LineStyle(
                // color: Colors.white.withOpacity(0.8),
                color: ThemeColors.secondaryThemeColor,
              );
              LineStyle afterLineStyle =
                  const LineStyle(color: ThemeColors.grey1ThemeColor);

              _CompanyStatus status;

              if (index < currentStep) {
                status = _CompanyStatus.done;
                afterLineStyle =
                    const LineStyle(color: ThemeColors.secondaryThemeColor);
              } else if (index > currentStep) {
                status = _CompanyStatus.todo;
                indicatorSize = 20;
                beforeLineStyle =
                    const LineStyle(color: ThemeColors.grey1ThemeColor);
              } else {
                status = _CompanyStatus.doing;
              }

              return SizedBox(
                width: Responsive.isDesktop(context)
                    ? MediaQuery.of(context).size.width / 6
                    : null,
                child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.manual,
                  lineXY: 0.6,
                  isFirst: index == 0,
                  isLast: index == companySteps.length - 1,
                  beforeLineStyle: beforeLineStyle,
                  afterLineStyle: afterLineStyle,
                  indicatorStyle: IndicatorStyle(
                    width: indicatorSize,
                    height: indicatorSize,
                    indicator: _IndicatorCompany(status: status),
                  ),
                  startChild: _StartChildCompany(index: index),
                  endChild: _EndChildCompany(
                    text: step,
                    current: index == currentStep,
                  ),
                ),
              );
            },
          ),
        ),
        if (currentStep < stepsLocalized.length)
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 15),
            constraints: BoxConstraints(
                maxHeight: 140,
                maxWidth: MediaQuery.of(context).size.width * 1),
            child: Text(
              textAlign: TextAlign.center,
              stepsLocalized[currentStep],
              style: const TextStyle(
                // color: ThemeColors.grey1ThemeColor,
                color: ThemeColors.blukersBlueThemeColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}

class _StartChildCompany extends StatelessWidget {
  const _StartChildCompany({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Center(child: companyIcons[index]);
  }
}

class _EndChildCompany extends StatelessWidget {
  const _EndChildCompany({
    required this.text,
    required this.current,
  });

  final String text;
  final bool current;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Flexible(
              //   child: Text(
              //     text,
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w600,
              //       color: current
              //           ? ThemeColors.secondaryThemeColor
              //           : ThemeColors.grey1ThemeColor,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IndicatorCompany extends StatelessWidget {
  const _IndicatorCompany({required this.status});

  final _CompanyStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _CompanyStatus.done:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.secondaryThemeColor,
          ),
          child: const Center(
            child: Icon(Icons.check, color: Colors.white),
          ),
        );
      case _CompanyStatus.doing:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.secondaryThemeColor,
          ),
          // child: const Center(
          //   child: SizedBox(
          //     height: 15,
          //     width: 15,
          //     // child: CircularProgressIndicator(
          //     //   strokeWidth: 3,
          //     //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          //     // ),
          //   ),
          // ),
        );
      case _CompanyStatus.todo:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.grey1ThemeColor,
          ),
          // child: Center(
          //   child: Container(
          //     width: 10,
          //     height: 10,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Color(0xFF5D6173),
          //     ),
          //   ),
          // ),
        );
    }
    return Container();
  }
}
