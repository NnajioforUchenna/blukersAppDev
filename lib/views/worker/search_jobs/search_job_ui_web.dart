import 'package:blukers/views/company/search_workers/workers_search_result_page/components/worker_pop_button_widget.dart';
import 'package:blukers/views/old_common_views/components/animations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/job_posts_provider.dart';
import '../../../providers/worker_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import 'jobs_search_result_page/Components/job_pop_button_widget.dart';

class SearchJobsUiWeb extends StatefulWidget {
  const SearchJobsUiWeb({super.key});

  @override
  State<SearchJobsUiWeb> createState() => _SearchJobsUiWebState();
}

class _SearchJobsUiWebState extends State<SearchJobsUiWeb> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  String buttonLabel = 'Search Jobs';

  String searchName = 'Position, work area or company';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    buttonLabel = AppLocalizations.of(context)!.searchWorkers;
    searchName =
        AppLocalizations.of(context)!.companySearchBarInput1Placeholder;
    nameController.text = jp.nameSearch;
    locationController.text = jp.locationSearch;


    final List<ListTile> recentSearchItems = [
      ListTile(
        leading: Icon(Icons.search, color: Colors.grey,),
        title: Text('Plumber',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),),
        trailing: Icon(Icons.close),
        onTap: () {
          print('Tapped on Map');
        },
      ),
      ListTile(
        leading: Icon(Icons.search, color: Colors.grey,),
        title: Text('Plumber',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),),
        trailing: Icon(Icons.close),
        onTap: () {
          print('Tapped on Map');
        },
      ),
      ListTile(
        leading: Icon(Icons.search, color: Colors.grey,),
        title: Text('Plumber',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),),
        trailing: Icon(Icons.close),
        onTap: () {
          print('Tapped on Map');
        },
      ),
      ListTile(
        leading: Icon(Icons.search, color: Colors.grey,),
        title: Text('Plumber',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),),
        trailing: Icon(Icons.close),
        onTap: () {
          print('Tapped on Map');
        },
      ),
      ListTile(
        leading: Icon(Icons.search, color: Colors.grey,),
        title: Text('Plumber',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),),
        trailing: Icon(Icons.close),
        onTap: () {
          print('Tapped on Map');
        },
      ),
    ];

    return Center(
      child: Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        insetPadding: const EdgeInsets.all(16),
        child: SizedBox(
          width: width * 0.95,
          height: height * 0.9,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 389),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.12),

                        // NEW TEXT FIELDS
                        TextField(
                          controller: nameController,
                          onChanged: (value) {
                            jp.nameSearch = value;
                          },
                          decoration: InputDecoration(
                            hintText: searchName,
                            hintStyle: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                            ),
                            // Hint text
                            prefixIcon: const Icon(Icons.search,
                                size: 20, color: Colors.grey),
                            // Icon at the start
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)), // Rounded border
                              borderSide: BorderSide(
                                  color:
                                  Color(0xFFDEDEDE)), // Outline color and width
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              // Rounded border on focus
                              borderSide: BorderSide(
                                  color: Colors
                                      .orange), // Outline color and width on focus
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: locationController,
                          onChanged: (value) {
                            jp.locationSearch = value;
                          },
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.cityandzipcode,
                            hintStyle: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                            ),
                            // Hint text
                            prefixIcon: const Icon(Icons.location_on_outlined,
                                size: 20, color: Colors.grey),
                            // Icon at the start
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)), // Rounded border
                              borderSide: BorderSide(
                                  color:
                                  Color(0xFFDEDEDE)), // Outline color and width
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              // Rounded border on focus
                              borderSide: BorderSide(
                                  color: Colors
                                      .orange), // Outline color and width on focus
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              jp.setSearching(true);
                              jp.searchJobPosts(
                                  nameController.text, locationController.text);
                              if (GoRouter.of(context).canPop()) {
                                GoRouter.of(context).pop();
                              }
                              GoRouter.of(context)
                                  .pushReplacement('/jobSearchResults');
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
                        SizedBox(height: height * 0.05),

                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Recent Searches',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Clear',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                itemCount: recentSearchItems.length,

                                itemBuilder: (context, index) {
                                  return recentSearchItems[index];
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (_isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: MyAnimation(name: 'blukersLoadingDots'),
                    ),
                  ),
                ),
              const Positioned(
                top: 10,
                left: 10,
                child: WorkerPopButtonWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
