import '../../../providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import 'search_page.dart';

class MobileSearchBar extends StatefulWidget {
  const MobileSearchBar({super.key});

  @override
  State<MobileSearchBar> createState() => _MobileSearchBarState();
}

class _MobileSearchBarState extends State<MobileSearchBar> {
  final TextEditingController controller = TextEditingController();
  String buttonLabel = 'Search Jobs';
  String searchName = 'Position, work area or company';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    if (up.userRole == 'Company') {
      buttonLabel = AppLocalizations.of(context)!.searchWorkers;
      searchName =
          AppLocalizations.of(context)!.companySearchBarInput1Placeholder;
    } else {
      buttonLabel = AppLocalizations.of(context)!.searchJobs;
      searchName =
          AppLocalizations.of(context)!.workerSearchBarInput1Placeholder;
    }

    controller.text = "${jp.nameSearch} ${jp.locationSearch}";

    return Container(
      height: screenHeight * 0.17,
      decoration: const BoxDecoration(
        color: ThemeColors.searchBarPrimaryThemeColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  showDialog(
                      context: context,
                      builder: (context) => const SearchPage());
                },
                decoration: InputDecoration(
                  isDense: true, // Added this
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10), // Adjust padding
                  filled: true,
                  fillColor: Colors.white,
                  hintText: searchName,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: controller.text.isEmpty
                          ? null
                          : () {
                              controller.clear();
                              jp.clearSearchParameters();
                            }),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ThemeColors
                            .blukersOrangeThemeColor), // Make sure to define ThemeColors.blukersOrangeThemeColor
                  ),
                ),
                onTap: () {
                  // Put your function here
                  showDialog(
                      context: context,
                      builder: (context) => const SearchPage());
                },
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500), // Added this for smaller text
              ),
            ),
          ),
        ],
      ),
    );
  }
}
