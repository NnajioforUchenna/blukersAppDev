import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../utils/styles/index.dart';
import '../../old_common_views/small_pop_button_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
    UserProvider up = Provider.of<UserProvider>(context);
    if (up.userRole == 'Company') {
      buttonLabel = AppLocalizations.of(context)!.searchWorkers;
      searchName =
          AppLocalizations.of(context)!.companySearchBarInput1Placeholder;
    } else {
      buttonLabel = AppLocalizations.of(context)!.searchJobs;
      searchName =
          AppLocalizations.of(context)!.workerSearchBarInput1Placeholder;
    }

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
                        hintText:  AppLocalizations.of(context)!.cityandzipcode,
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
                      Navigator.pop(context);
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
              child: SmallPopButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
