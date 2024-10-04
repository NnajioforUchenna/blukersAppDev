import 'package:blukers/providers/worker_provider.dart';
import 'package:blukers/views/worker/select_job_industry/widgets/choose_language_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/job_posts_provider.dart';
import '../../../../../utils/styles/theme_colors.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';

class SearchHeaderMobile extends StatefulWidget {
  const SearchHeaderMobile({super.key});

  @override
  State<SearchHeaderMobile> createState() => _SearchHeaderMobileState();
}

class _SearchHeaderMobileState extends State<SearchHeaderMobile> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String buttonLabel = 'Search Jobs';
  String searchName = 'Position, work area or company';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    WorkersProvider wp = Provider.of<WorkersProvider>(context, listen: false);
    UserProvider up = Provider.of<UserProvider>(context, listen: false);

    buttonLabel = AppLocalizations.of(context)!.searchJobs;
    searchName = AppLocalizations.of(context)!.workerSearchBarInput1Placeholder;

    if (jp.nameSearch.isNotEmpty || jp.locationSearch.isNotEmpty) {
      controller.text = jp.nameSearch;
      locationController.text = jp.locationSearch;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 24, bottom: 10),
      child: Column(children: [
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: SearchField(
                  controller: controller,
                  searchName: searchName,
                  onDone: () {},
                  icon: Icons.search,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              const Expanded(
                child: ChooseLanguageWidget(),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: SearchField(
                    onDone: () {},
                    controller: locationController,
                    searchName: "city, state or zip code",
                    icon: Icons.location_on_outlined),
              ),
              const SizedBox(
                width: 14,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  String nameRelated = controller.text;
                  String locationRelated = locationController.text;
                  if (up.userRole == 'company') {
                    await wp.searchWorkers(nameRelated, locationRelated);
                    GoRouter.of(context).go('/workerSearchResults');
                    return;
                  }
                  await jp.searchJobPosts(nameRelated, locationRelated);

                  GoRouter.of(context).go('/jobSearchResults');

                  setState(() {
                    _isLoading = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.primaryThemeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 25,
                        child: SpinKitChasingDots(
                          color: Colors.white,
                          size: 12,
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)!.searchJobs,
                        style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField(
      {super.key,
      required this.controller,
      required this.searchName,
      required this.onDone,
      required this.icon});
  final TextEditingController controller;
  final String searchName;
  final IconData icon;
  final Function onDone;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          // showDialog(
          //     context: context, builder: (context) => const SearchJobsUi());
        },
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          onDone();
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
          hintStyle: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(161, 161, 161, 0.7)),
          prefixIcon: Icon(icon, color: ThemeColors.black1ThemeColor),
         
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: const Color(0xFF808080).withOpacity(0.55),
              width: 1.5,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: const Color(0xFF808080).withOpacity(0.55),
              width: 1.5,
            ), 
          ),
        ),
        onTap: () {
         
        },
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ), // Added this for smaller text
      ),
    );
  }
}
