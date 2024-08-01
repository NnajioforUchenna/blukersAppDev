import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/job_posts_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import 'jobs_search_result_page/Components/job_pop_button_widget.dart';

class SearchJobsUiMobile extends StatefulWidget {
  const SearchJobsUiMobile({super.key});

  @override
  State<SearchJobsUiMobile> createState() => _SearchJobsUiMobileState();
}

class _SearchJobsUiMobileState extends State<SearchJobsUiMobile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  String buttonLabel = 'Search Jobs';

  String searchName = 'Position, work area or company';

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive design
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);

    buttonLabel = AppLocalizations.of(context)!.searchJobs;
    searchName = AppLocalizations.of(context)!.workerSearchBarInput1Placeholder;

    nameController.text = jp.nameSearch;
    locationController.text = jp.locationSearch;

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
      child: SizedBox(
        width: width * 0.95,
        height: height * 0.9,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: height * 0.12),
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), // This rounds the corners of the Card
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 10),
                        hintText: searchName,
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        jp.nameSearch = value;
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), // This rounds the corners of the Card
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 10),
                        hintText: AppLocalizations.of(context)!.cityandzipcode,
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        jp.locationSearch = value;
                      },
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      jp.setSearching(true);
                      jp.searchJobPosts(
                          nameController.text, locationController.text);
                      if (GoRouter.of(context).canPop()) {
                        GoRouter.of(context).pop();
                      }
                      GoRouter.of(context).pushReplacement('/jobSearchResults');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.blukersOrangeThemeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(buttonLabel,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                )
              ],
            ),
            // Circle container with 'X' icon
            const Positioned(
              top: 10, // Adjust as needed
              left: 10, // Adjust as needed
              child: JobPopButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
