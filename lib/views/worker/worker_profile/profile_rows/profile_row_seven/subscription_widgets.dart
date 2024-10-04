
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../common_files/constants.dart';
import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../utils/styles/theme_colors.dart';

class SubscriptionWidgetDesktop extends StatefulWidget {
  const SubscriptionWidgetDesktop({super.key});

  @override
  State<SubscriptionWidgetDesktop> createState() =>
      _SubscriptionWidgetDesktopState();
}

class _SubscriptionWidgetDesktopState extends State<SubscriptionWidgetDesktop> {
  String activeSubscriptionId = "";
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    final up = Provider.of<UserProvider>(context, listen: false);
    if (up.appUser != null && up.appUser!.activeSubscription != null) {
      activeSubscriptionId = up.appUser!.activeSubscription!.subscriptionId;
    } else {
      activeSubscriptionId = listSubscriptions[0]['subscriptionId'];
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        isExpanded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 36,
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: SubsciptionDetailsContainerDesktop(
                subscription: listSubscriptions[0],
                activeSubscriptionId: activeSubscriptionId,
              ),
            ),
          ),
          Flexible(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: isExpanded
                  ? (Matrix4.identity()..translate(0, -50, 0))
                  : (Matrix4.identity()..translate(0, 0, 0)),
              child: SubsciptionDetailsContainerDesktop(
                subscription: listSubscriptions[1],
                activeSubscriptionId: activeSubscriptionId,
              ),
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              // color: Colors.blue,
              child: SubsciptionDetailsContainerDesktop(
                subscription: listSubscriptions[2],
                activeSubscriptionId: activeSubscriptionId,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SubscriptionWidgetMobile extends StatefulWidget {
  const SubscriptionWidgetMobile({super.key});

  @override
  State<SubscriptionWidgetMobile> createState() =>
      _SubscriptionWidgetMobileState();
}

class _SubscriptionWidgetMobileState extends State<SubscriptionWidgetMobile> {
  Map<String, dynamic>? selectedSubscription;
  String activeSubscriptionId = "";
  @override
  void initState() {
    super.initState();
    final up = Provider.of<UserProvider>(context, listen: false);
    if (up.appUser != null && up.appUser!.activeSubscription != null) {
      selectedSubscription = listSubscriptions.firstWhere(
          (element) =>
              element['subscriptionId'] ==
              up.appUser!.activeSubscription!.subscriptionId,
          orElse: () => listSubscriptions[0]);
      activeSubscriptionId = up.appUser!.activeSubscription!.subscriptionId;
    } else {
      selectedSubscription = listSubscriptions[0];
      activeSubscriptionId = listSubscriptions[0]['subscriptionId'];
    }
  }

  @override
  Widget build(BuildContext context) {
     Provider.of<UserProvider>(context);
    return Container(
      padding: const EdgeInsets.only(
        top: 56,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Subscriptions',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Expand your reach and find jobs easier and faster.',
              style:
                  GoogleFonts.montserrat(color: ThemeColors.ash, fontSize: 11),
            ),
            const SizedBox(
              height: 48,
            ),
            Row(
              children: [
                for (int i = 0; i < listSubscriptions.length; i++)
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedSubscription = listSubscriptions[i];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: i == 0 ? 24 : 0,
                            right: i < listSubscriptions.length - 1 ? 12 : 24),
                        child: SubcriptionContainer(
                          isSelected:
                              selectedSubscription == listSubscriptions[i],
                          id: listSubscriptions[i]['subscriptionId'],
                          subrcriptionType: listSubscriptions[i]['title'] +
                              listSubscriptions[i]['subtitle'],
                          description: listSubscriptions[i]['description'],
                          icon: listSubscriptions[i]['icon'],
                        ),
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  if (selectedSubscription != null)
                    SubcriptionDetailsContainer(
                      subscription: selectedSubscription!,
                      activeSubscriptionId: activeSubscriptionId,
                    ),
                  const SizedBox(height: 30)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SubsciptionDetailsContainerDesktop extends StatelessWidget {
  final Map<String, dynamic> subscription;
  final String activeSubscriptionId;
  const SubsciptionDetailsContainerDesktop(
      {super.key,
      required this.subscription,
      required this.activeSubscriptionId});

  @override
  Widget build(BuildContext context) {
    final subscriptionType = subscription['title'] + subscription['subtitle'];

    return Container(
      padding: subscriptionType == "Premium"
          ? const EdgeInsets.symmetric(horizontal: 27, vertical: 30)
          : null,
      decoration: BoxDecoration(
          boxShadow: subscriptionType == "Premium"
              ? [
                  BoxShadow(
                    color: const Color(0xFF5243C2).withOpacity(.30),
                    offset: const Offset(0, 42),
                    blurRadius: 34,
                    spreadRadius: 0,
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(26),
          color: subscriptionType == "Premium"
              ? ThemeColors.primaryThemeColor
              : null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          subscription['amount'] == "0"
              ? Text(
                  "Free",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: subscriptionType == "Premium"
                          ? Colors.white
                          : ThemeColors.secondaryThemeColor,
                      fontSize: 30),
                )
              : Row(
                  children: [
                    Text(
                      subscription['amount'],
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: subscriptionType == "Premium"
                              ? Colors.white
                              : const Color(0xFFCC561E),
                          fontSize: 36),
                    ),
                    if (subscriptionType == "Premium")
                      Text(
                        " / Month",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                  ],
                ),
          const SizedBox(
            height: 34,
          ),
          Text(
            subscriptionType,
            style: GoogleFonts.montserrat(
                color: subscriptionType == "Premium"
                    ? Colors.white
                    : const Color(0xFFCC561E),
                fontSize: subscriptionType == "Premium" ? 28 : 24,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            subscription['description'],
            style: GoogleFonts.montserrat(
                color: subscriptionType == "Premium"
                    ? Colors.white
                    : const Color(0xFF848199),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 34,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < 6; i++)
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: TickIcon(
                          size: 20,
                          removeBorder: true,
                          backgroundColor: subscriptionType == "Premium"
                              ? ThemeColors.primaryThemeColor.withOpacity(0.10)
                              : const Color(0xFFE9F1F8),
                          color: subscriptionType == "Premium"
                              ? Colors.white
                              : ThemeColors.primaryThemeColor,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          i < subscription['details'].length
                              ? subscription['details'][i]
                              : '...',
                          textAlign: i < subscription['details'].length
                              ? TextAlign.left
                              : TextAlign.center,
                          style: GoogleFonts.montserrat(
                              color: subscriptionType == "Premium"
                                  ? Colors.white
                                  : const Color(0xFF080D4F),
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 26,
          ),
          activeSubscriptionId == subscription['subscriptionId']
              ? Center(
                  child: Text(
                    "Active Plan",
                    style: GoogleFonts.montserrat(
                        color: ThemeColors.secondaryThemeColor,
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                )
              : Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: subscriptionType == "Premium"
                            ? ThemeColors.secondaryThemeColor
                            : ThemeColors.secondaryThemeColor.withOpacity(.21),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                            side: subscriptionType == "Premium"
                                ? BorderSide.none
                                : const BorderSide(
                                    color: ThemeColors.secondaryThemeColor,
                                  ),
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      "Choose This Plan",
                      style: GoogleFonts.montserrat(
                          color: subscriptionType == "Premium"
                              ? Colors.white
                              : ThemeColors.secondaryThemeColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
          const Spacer(),
        ],
      ),
    );
  }
}

class SubcriptionDetailsContainer extends StatelessWidget {
  final Map<String, dynamic> subscription;
  final String activeSubscriptionId;
  const SubcriptionDetailsContainer(
      {super.key,
      required this.subscription,
      required this.activeSubscriptionId});

  @override
  Widget build(BuildContext context) {
    final subscriptionType = subscription['title'] + subscription['subtitle'];
    Color color = ThemeColors.secondaryThemeColor;
    if (subscriptionType == "Premium") {
      color = ThemeColors.primaryThemeColor;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 38),
      decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subscriptionType,
            style: GoogleFonts.montserrat(
                color: color, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 18,
          ),
          subscription['amount'] == "0"
              ? Text(
                  "Free",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: ThemeColors.black1ThemeColor,
                      fontSize: 30),
                )
              : Row(
                  children: [
                    Text(
                      subscription['amount'],
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: ThemeColors.black1ThemeColor,
                          fontSize: 30),
                    ),
                    Text(
                      "/ Month",
                      style: GoogleFonts.montserrat(
                          color: ThemeColors.black1ThemeColor, fontSize: 14),
                    ),
                  ],
                ),
          const SizedBox(
            height: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < 6; i++)
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: TickIcon(
                          color: color,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          i < subscription['details'].length
                              ? subscription['details'][i]
                              : '...',
                          style: GoogleFonts.montserrat(
                              color: const Color(0xFF454545),
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 26,
          ),
          activeSubscriptionId == subscription['subscriptionId']
              ? Center(
                  child: Text(
                    "Active Plan",
                    style: GoogleFonts.montserrat(
                        color: color,
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                )
              : Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: subscriptionType == "Premium"
                            ? ThemeColors.primaryThemeColor
                            : ThemeColors.secondaryThemeColor.withOpacity(.21),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                            side: subscriptionType == "Premium"
                                ? BorderSide.none
                                : BorderSide(color: color),
                            borderRadius: BorderRadius.circular(6))),
                    child: Text(
                      "Choose This Plan",
                      style: GoogleFonts.montserrat(
                          color: subscriptionType == "Premium"
                              ? Colors.white
                              : color,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class SubcriptionContainer extends StatefulWidget {
  final String subrcriptionType;
  final String description;
  final String icon;
  final String id;
  final bool isSelected;

  const SubcriptionContainer(
      {super.key,
      required this.subrcriptionType,
      required this.description,
      required this.icon,
      required this.isSelected,
      required this.id});

  @override
  State<SubcriptionContainer> createState() => _SubcriptionContainerState();
}

class _SubcriptionContainerState extends State<SubcriptionContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      alignment: Alignment.center,
      scale: widget.isSelected ? 1.1 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: !widget.isSelected
                ? null
                : [
                    BoxShadow(
                      color: widget.subrcriptionType == "Premium"
                          ? ThemeColors.primaryThemeColor.withOpacity(.12)
                          : ThemeColors.secondaryThemeColor.withOpacity(.12),
                      offset: const Offset(0, 9),
                      blurRadius: 16,
                    ),
                  ],
            color: widget.subrcriptionType == 'Premium'
                ? ThemeColors.primaryThemeColor
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: widget.subrcriptionType == 'Premium'
                ? null
                : Border.all(
                    color: widget.isSelected
                        ? ThemeColors.secondaryThemeColorDark
                        : const Color(0xFFD0D0D5))),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                  color: widget.subrcriptionType == 'Premium'
                      ? Colors.white
                      : ThemeColors.secondaryThemeColorDark,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.subrcriptionType == 'Premium')
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: SvgPicture.asset(
                        'assets/icons/fire_icon.svg',
                      ),
                    ),
                  Text(
                    widget.subrcriptionType,
                    style: GoogleFonts.montserrat(
                        color: widget.subrcriptionType == 'Premium'
                            ? ThemeColors.black1ThemeColor
                            : Colors.white,
                        fontSize: 7,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset(
              widget.icon,
              height: 42,
              width: 42,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  color: widget.subrcriptionType == "Premium"
                      ? Colors.white
                      : widget.isSelected
                          ? const Color(0xFf262626)
                          : const Color(0xFF848199),
                  fontSize: 7,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

class TickIcon extends StatelessWidget {
  final Color color;
  final Color? backgroundColor;
  final double size;
  final bool removeBorder;
  const TickIcon(
      {super.key,
      required this.color,
      this.backgroundColor,
      this.size = 16,
      this.removeBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          border: removeBorder ? null : Border.all(color: color),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100)),
      padding: const EdgeInsets.all(5),
      child: SvgPicture.asset(
        'assets/icons/tick_icon.svg',
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
