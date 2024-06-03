import 'package:blukers/providers/worker_provider.dart';
import 'package:blukers/views/common_vieiws/loading_page.dart';
import 'package:blukers/views/company/workers_components/worker_search_result_page.dart';
import 'package:blukers/views/old_common_views/company_small_pop_button_widget.dart';
import 'package:blukers/views/old_common_views/components/animations/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../providers/job_posts_provider.dart';
import '../../../utils/styles/index.dart';

class CompanySearchPage extends StatefulWidget {
  const CompanySearchPage({super.key});

  @override
  State<CompanySearchPage> createState() => _CompanySearchPageState();
}

class _CompanySearchPageState extends State<CompanySearchPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  late WorkerProvider wp;

  void initState() {
    super.initState();
    wp = Provider.of<WorkerProvider>(context, listen: false);
    // jp = Provider.of<JobPostsProvider>(context, listen: false);
    // up = Provider.of<UserProvider>(context, listen: false);
  }

  String buttonLabel = 'Search worker';
  String searchName = 'Position, work area or company';
  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive design
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    buttonLabel = AppLocalizations.of(context)!.searchWorkers;
    searchName =
        AppLocalizations.of(context)!.companySearchBarInput1Placeholder;

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
                    onPressed: () async {
                      String nameRelated = nameController.text;
                      String locationRelated = locationController.text;
                      jp.setSearching(
                          true); // Likely sets a loading indicator (modify if needed)

                      // Show a loading dialog while searching
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // Prevent user from closing the dialog
                        builder: (BuildContext context) => Center(
                          child: Transform.scale(
                            scale: 2.0, // Adjust the scale value as needed
                            child: const MyAnimation(
                              name: 'blukersLoadingDots',
                            ),
                          ),
                        ),
                      );

                      await wp.searchWorkers(nameRelated, locationRelated);

                      // Hide the loading dialog after search completes
                      Navigator.pop(context); // Close the loading dialog

                      GoRouter.of(context).push('/workers');
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
              child: CompanySmallPopButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
