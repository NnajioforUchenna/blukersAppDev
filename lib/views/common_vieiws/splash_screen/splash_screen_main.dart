import 'dart:async';

import '../../../utils/styles/index.dart';
import 'splash_screen_components/splash_2/splash_screen_page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < 2) {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      } else {
        context.go('/landing');
        _timer?.cancel();
      }
    });
  }

  void _nextPage() {
    if (_currentPage < 2) {
      // Assuming there are 3 pages in the PageView
      setState(() {
        _currentPage++;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      // If it's the last page, navigate to '/landing' or perform another action
      context.go('/landing');
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                  _startTimer();
                },
                children: const [
                  SplashScreenPage2(
                    topLeftText:
                        'Explore Opportunities and find the perfect job that marches your skills and ambitions.',
                    topRightText: 'Worker Search',
                    bottomLeftText: 'Company Post',
                    bottomRightText:
                        'Post Your Job and connect with qualified candidates today.',
                    leftImage: 'assets/splash/companyCharacter.png',
                    rightImage: 'assets/splash/workerCharacter1.png',
                  ),
                  SplashScreenPage2(
                    topLeftText:
                        'Submit Your Application to Take The First Leap Towards Your Career.',
                    topRightText: 'Worker Apply',
                    bottomLeftText: 'Company Review',
                    bottomRightText:
                        'Review Candidates easily and make informed decisions.',
                    leftImage: 'assets/splash/companyCharacter.png',
                    rightImage: 'assets/splash/workerCharacter2.png',
                  ),
                  SplashScreenPage2(
                    topLeftText: 'Ace The Interview And Showcase your skills',
                    topRightText: 'Worker Get Hired',
                    bottomLeftText: 'Company Hire',
                    bottomRightText:
                        'Make the right hire with confidence and choose the perfect candidate',
                    leftImage: 'assets/splash/companyCharacter.png',
                    rightImage: 'assets/splash/workerCharacter3.png',
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.025,
              width: width * 0.25,
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: ThemeColors.primaryThemeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Text(
                  'Next',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.go('/landing');
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  AppLocalizations.of(context)!.skip,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(3, (index) => _buildDot(index == _currentPage)),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFf06523) : Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
