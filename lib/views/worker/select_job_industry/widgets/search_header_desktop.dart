import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/job_posts_provider.dart';
import '../../../../../services/responsive.dart';
import '../../../../../utils/styles/theme_colors.dart';
import 'choose_language_widget.dart';

class SearchHeaderDesktop extends StatefulWidget {
  const SearchHeaderDesktop({super.key});

  @override
  State<SearchHeaderDesktop> createState() => _SearchHeaderDesktopState();
}

class _SearchHeaderDesktopState extends State<SearchHeaderDesktop> {
  final TextEditingController _searchController1 = TextEditingController();
  final TextEditingController _searchController2 = TextEditingController();
  late JobPostsProvider jp;

  bool isMobileSearchBarVisible = false;

  @override
  void initState() {
    super.initState();
    jp = Provider.of<JobPostsProvider>(context, listen: false);
  }

  String buttonLabel = 'Search Jobs';
  String searchName = 'Position, work area or company';

  @override
  Widget build(BuildContext context) {
    buttonLabel = AppLocalizations.of(context)!.searchJobs;
    searchName = AppLocalizations.of(context)!.workerSearchBarInput1Placeholder;

    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFF808080).withOpacity(0.55),
                    width: 1.5,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: _buildSearchField(
                          _searchController1, searchName, Icons.search)),
                  VerticalDivider(
                    color: const Color(0xFF808080).withOpacity(0.55),
                    thickness: 1.5,
                    width: 20,
                  ),
                  // const SizedBox(width: 10.0),
                  Expanded(
                    flex: 2,
                    child: _buildSearchField(
                        _searchController2,
                        AppLocalizations.of(context)!
                            .workerSearchBarInput2Placeholder,
                        Icons.location_on),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          const SizedBox(width:100, child: ChooseLanguageWidgetDesktop())
          // const SizedBox(width: 20.0),
          // _buildSmallCircleButton(),
        ],
      ),
    );
  }

  Widget _buildSearchField(
      TextEditingController controller, String hintText, IconData icon) {
    double widthFactor = Responsive.isMobile(context)
        ? 0.80
        : 0.28; // 80% for mobile, 28% for desktop
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      child: TextField(
        textInputAction: TextInputAction.search,
        controller: controller,
        onChanged: (value) {
          if (controller.text.isEmpty) {
            setState(() {
              _searchController1.clear();
              _searchController2.clear();
              jp.setSearching(false);
            });
          }
        },
        onSubmitted: (val) async {
          String nameRelated = _searchController1.text;
          String locationRelated = _searchController2.text;

          // Determine which provider to use
          await jp.searchJobPosts(nameRelated, locationRelated);

          GoRouter.of(context).pushReplacement('/jobSearchResults');
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          hintText: hintText,
          prefixIcon: Icon(icon, color: ThemeColors.black1ThemeColor),
          isDense: true,
          // Added this
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          // Adjust padding

          hintStyle: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(161, 161, 161, 0.7)),

          // suffixIcon: IconButton(
          //   icon: const Icon(Icons.close),
          //   onPressed: controller.text.isEmpty
          //       ? null
          //       : () {
          //           controller.clear();
          //           setState(() {
          //             _searchController1.clear();
          //             _searchController2.clear();
          //             jp.setSearching(false);
          //           });
          //         },
          // ),
          border: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
