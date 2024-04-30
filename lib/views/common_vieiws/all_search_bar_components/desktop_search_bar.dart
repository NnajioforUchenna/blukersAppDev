import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../providers/job_posts_provider.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../providers/worker_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';

class DesktopSearchBar extends StatefulWidget {
  const DesktopSearchBar({super.key});

  @override
  State<DesktopSearchBar> createState() => _DesktopSearchBarState();
}

class _DesktopSearchBarState extends State<DesktopSearchBar> {
  final TextEditingController _searchController1 = TextEditingController();
  final TextEditingController _searchController2 = TextEditingController();
  late WorkerProvider wp;
  late JobPostsProvider jp;
  late UserProvider up;
  bool _isLoading = false;

  bool isMobileSearchBarVisible = false;

  @override
  void initState() {
    super.initState();
    wp = Provider.of<WorkerProvider>(context, listen: false);
    jp = Provider.of<JobPostsProvider>(context, listen: false);
    up = Provider.of<UserProvider>(context, listen: false);
  }

  String buttonLabel = 'Search Jobs';
  String searchName = 'Position, work area or company';

  @override
  Widget build(BuildContext context) {
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

    return Container(
      color: ThemeColors.searchBarPrimaryThemeColor,
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSearchField(_searchController1, searchName, Icons.search),
          const SizedBox(width: 20.0),
          _buildSearchField(
              _searchController2,
              AppLocalizations.of(context)!.workerSearchBarInput2Placeholder,
              Icons.location_on),
          const SizedBox(width: 20.0),
          _buildSearchButton(),
          const SizedBox(width: 10.0),
          _buildSmallCircleButton(),
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
        controller: controller,
        onChanged: (value) {
          if (controller.text.isEmpty) {
            setState(() {
              _searchController1.clear();
              _searchController2.clear();
              wp.setSearching(false);
              jp.setSearching(false);
            });
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          prefixIcon: Icon(icon),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: controller.text.isEmpty
                ? null
                : () {
                    controller.clear();
                    setState(() {
                      _searchController1.clear();
                      _searchController2.clear();
                      wp.setSearching(false);
                      jp.setSearching(false);
                    });
                  },
          ),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColors.blukersOrangeThemeColor),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    double widthFactor = Responsive.isMobile(context)
        ? 0.80
        : 0.15; // 60% for mobile, 15% for desktop
    double heightFactor = Responsive.isMobile(context)
        ? 0.06
        : 0.05; // 8% for mobile, 5% for desktop
    double fontSize =
        Responsive.isMobile(context) ? 14 : 18; // Smaller font size for mobile

    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      height: MediaQuery.of(context).size.height * heightFactor,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            _isLoading = true; // Start loading
          });

          String nameRelated = _searchController1.text;
          String locationRelated = _searchController2.text;

          // Determine which provider to use
          if (up.userRole == 'company') {
            await wp.searchWorkers(nameRelated, locationRelated);
          } else {
            await jp.searchJobPosts(nameRelated, locationRelated);
          }

          setState(() {
            _isLoading = false; // End loading
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 243, 85, 7), // Red color
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _isLoading
              ? const SizedBox(
                  height: 25,
                  child: SpinKitChasingDots(
                    color: Colors.white,
                    size: 20,
                  ),
                )
              : Text(
                  AppLocalizations.of(context)!.searchJobs,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildSmallCircleButton() {
    return wp.isSearching || jp.isSearching
        ? SizedBox(
            width: 25.w, // Fixed width
            height: 25.h, // Fixed height
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _searchController1.clear();
                  _searchController2.clear();
                  wp.setSearching(false);
                  jp.setSearching(false);
                  jp.clearSearchParameters();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red color
                shape: const CircleBorder(), // Makes the button circular
              ),
              child: const Icon(Icons.close,
                  size: 15,
                  color: Colors
                      .white), // Example icon, you can replace with your content
            ),
          )
        : const SizedBox();
  }
}
