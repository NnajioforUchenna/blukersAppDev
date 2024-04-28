import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/job_posts_provider.dart';
import '../../../../../services/responsive.dart';
import '../../../../../utils/styles/theme_colors.dart';

class WebSearchBar extends StatefulWidget {
  const WebSearchBar({super.key});

  @override
  State<WebSearchBar> createState() => _WebSearchBarState();
}

class _WebSearchBarState extends State<WebSearchBar> {
  final TextEditingController _searchController1 = TextEditingController();
  final TextEditingController _searchController2 = TextEditingController();
  late JobPostsProvider jp;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    jp = Provider.of<JobPostsProvider>(context, listen: false);
  }

  String buttonLabel = 'Search Jobs';
  String searchName = 'Company Name, Skill or Job Title';

  void clearAll() {
    _searchController1.clear();
    _searchController2.clear();
    jp.setSearching(false);
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildMobileSearchBar(),
      desktop: _buildDesktopSearchBar(),
    );
  }

  Widget _buildMobileSearchBar() {
    return Container(
      color: ThemeColors.searchBarPrimaryThemeColor,
      height: MediaQuery.of(context).size.height * 0.35,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 8.0.h),
      child: Center(
        child: SingleChildScrollView(
          // Adding SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSearchField(
                  _searchController1,
                  AppLocalizations.of(context)!
                      .workerSearchBarInput2Placeholder),
              SizedBox(height: 15.h),
              _buildSearchField(
                  _searchController2,
                  AppLocalizations.of(context)!
                      .workerSearchBarInput2Placeholder),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSearchButton(),
                  const SizedBox(width: 10.0),
                  Visibility(
                      visible: jp.isWebSearching,
                      child: _buildSmallCircleButton()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopSearchBar() {
    return Container(
      color: ThemeColors.searchBarPrimaryThemeColor,
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSearchField(_searchController1,
              AppLocalizations.of(context)!.workerSearchBarInput2Placeholder),
          const SizedBox(width: 20.0),
          _buildSearchField(_searchController2,
              AppLocalizations.of(context)!.workerSearchBarInput2Placeholder),
          const SizedBox(width: 20.0),
          _buildSearchButton(),
          const SizedBox(width: 10.0),
          _buildSmallCircleButton(),
        ],
      ),
    );
  }

  Widget _buildSearchField(TextEditingController controller, String hintText) {
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
              clearAll();
            });
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          prefixIcon: hintText.contains('company')
              ? const Icon(Icons.search)
              : const Icon(Icons.location_on),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: controller.text.isEmpty
                ? null
                : () {
                    controller.clear();
                    setState(() {
                      clearAll();
                    });
                  },
          ),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    double widthFactor = Responsive.isMobile(context)
        ? 0.60
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

          await jp.getJobsBySearchParameter(nameRelated, locationRelated);

          setState(() {
            _isLoading = false; // End loading
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              ThemeColors.searchBarSecondaryThemeColor, // Red color
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
    return jp.isSearching
        ? SizedBox(
            width: 50, // Fixed width
            height: 50, // Fixed height
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  clearAll();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red color
                shape: const CircleBorder(), // Makes the button circular
              ),
              child: const Icon(Icons.close,
                  color: Colors
                      .white), // Example icon, you can replace with your content
            ),
          )
        : const SizedBox();
  }
}
