import 'package:blukers/views/common_vieiws/all_search_bar_components/company_search_page.dart';

import '../../../providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../utils/styles/theme_colors.dart';

class CompanyMobileSearchBar extends StatefulWidget {
  const CompanyMobileSearchBar({super.key});

  @override
  State<CompanyMobileSearchBar> createState() => _CompanyMobileSearchBarState();
}

class _CompanyMobileSearchBarState extends State<CompanyMobileSearchBar> {
  final TextEditingController controller = TextEditingController();
  String buttonLabel = 'Search Workers';
  String searchName = 'Position, work area or company';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    buttonLabel = AppLocalizations.of(context)!.searchWorkers;
    searchName =
        AppLocalizations.of(context)!.companySearchBarInput1Placeholder;

    controller.text = "${jp.nameSearch} ${jp.locationSearch}";
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.68,
      height: 40,
      child: TextField(
        controller: controller,
        // onChanged: (value) {
        //   showDialog(
        //       context: context,
        //       builder: (context) => const CompanySearchPage());
        // },
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
              context: context,
              builder: (context) => const CompanySearchPage());
        },
        style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey), // Added this for smaller text
      ),
    );
  }
}
