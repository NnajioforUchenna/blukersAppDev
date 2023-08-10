import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';

class AllSearchBar extends StatefulWidget {
  const AllSearchBar({super.key});

  @override
  State<AllSearchBar> createState() => _AllSearchBarState();
}

class _AllSearchBarState extends State<AllSearchBar> {
  final TextEditingController _searchController1 = TextEditingController();
  final TextEditingController _searchController2 = TextEditingController();
  late WorkerProvider wp;
  late JobPostsProvider jp;
  late UserProvider up;
  bool _isLoading = false;

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
    if (up.userRole == 'company') {
      buttonLabel = 'Search Workers';
      searchName = 'Position, work area or company';
    } else {
      buttonLabel = 'Search Jobs';
      searchName = 'Company name, skill or job title';
    }
    return Responsive(
      mobile: _buildMobileSearchBar(),
      desktop: _buildDesktopSearchBar(),
    );
  }

  Widget _buildMobileSearchBar() {
    return Container(
      color: ThemeColors.primaryThemeColor,
      height: 250,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Center(
        child: SingleChildScrollView(
          // Adding SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSearchField(_searchController1, searchName),
              const SizedBox(height: 20.0),
              _buildSearchField(_searchController2, 'Location'),
              const SizedBox(height: 20.0),
              _buildSearchButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopSearchBar() {
    return Container(
      color: ThemeColors.primaryThemeColor,
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSearchField(_searchController1, searchName),
          const SizedBox(width: 20.0),
          _buildSearchField(_searchController2, 'Location'),
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
                      _searchController1.clear();
                      _searchController2.clear();
                      wp.setSearching(false);
                      jp.setSearching(false);
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
          primary: ThemeColors.secondaryThemeColor, // Red color
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
                  buttonLabel,
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
            width: 50, // Fixed width
            height: 50, // Fixed height
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _searchController1.clear();
                  _searchController2.clear();
                  wp.setSearching(false);
                  jp.setSearching(false);
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
