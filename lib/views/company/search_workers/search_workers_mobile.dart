import 'package:blukers/views/company/search_workers/workers_search_result_page/components/worker_pop_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/job_posts_provider.dart';
import '../../../providers/worker_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../old_common_views/components/animations/index.dart';

class SearchWorkersUiMobile extends StatefulWidget {
  const SearchWorkersUiMobile({super.key});

  @override
  State<SearchWorkersUiMobile> createState() => _SearchWorkersUiMobileState();
}

class _SearchWorkersUiMobileState extends State<SearchWorkersUiMobile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String buttonLabel = 'Search Jobs';
  String searchName = 'Position, work area or company';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    buttonLabel = AppLocalizations.of(context)!.searchWorkers;
    searchName =
        AppLocalizations.of(context)!.companySearchBarInput1Placeholder;
    nameController.text = jp.nameSearch;
    locationController.text = jp.locationSearch;

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
                builder: (context) => Column(
                  children: [
                    SizedBox(height: height * 0.12),
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
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
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: locationController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            hintText:
                                AppLocalizations.of(context)!.cityandzipcode,
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
                        onPressed: _isLoading
                            ? null
                            : () {
                                wp.searchWorkers(
                                  nameController.text,
                                  locationController.text,
                                );

                                if (GoRouter.of(context).canPop()) {
                                  GoRouter.of(context).pop();
                                }

                                GoRouter.of(context).go('/workerSearchResults');
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
                  ],
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
