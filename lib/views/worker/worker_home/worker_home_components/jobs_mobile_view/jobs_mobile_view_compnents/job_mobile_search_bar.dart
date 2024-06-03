import '../../../../../../providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../../utils/styles/theme_colors.dart';
import '../../../../../common_vieiws/all_search_bar_components/worker_search_page.dart';

class JobMobileSearchBar extends StatefulWidget {
  const JobMobileSearchBar({super.key});

  @override
  State<JobMobileSearchBar> createState() => _JobMobileSearchBarState();
}

class _JobMobileSearchBarState extends State<JobMobileSearchBar> {
  final TextEditingController controller = TextEditingController();
  String buttonLabel = 'Search Jobs';
  String searchName = 'Position, work area or company';

  @override
  Widget build(BuildContext context) {
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
    print(searchName);
    if (jp.nameSearch.isNotEmpty || jp.locationSearch.isNotEmpty) {
      controller.text = "${jp.nameSearch} ${jp.locationSearch}";
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.68,
      height: 40,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          showDialog(
              context: context, builder: (context) => const SearchPage());
        },
        decoration: InputDecoration(
          isDense: true,
          // Added this
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          // Adjust padding
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
              context: context, builder: (context) => const SearchPage());
        },
        style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey), // Added this for smaller text
      ),
    );
  }
}
