import 'dart:async';

import 'package:flutter/material.dart';

import '../landing_page_components/landing_page.dart';
import 'splash_screen_page.dart';

class SplashScreen extends StatefulWidget {
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
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LandingPage()));
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
                _startTimer();
              },
              children: const [
                SplashScreenPage(
                  workerTitle: 'Search',
                  workerSubtitle:
                      'Explore Opportunities and find the perfect job that matches your skills and ambitions.',
                  companyTitle: 'Post',
                  companySubtitle:
                      'Post your job and connect with qualified candidates today.',
                ),
                SplashScreenPage(
                  workerTitle: 'Apply',
                  workerSubtitle:
                      'Submit Your Application to Take the first leap towards your career.',
                  companyTitle: 'Review',
                  companySubtitle:
                      'Review Candidates easily and make informed decisions.',
                ),
                SplashScreenPage(
                  workerTitle: 'Get Hired',
                  workerSubtitle: 'Ace The Interview and Showcase your Skills.',
                  companyTitle: 'Hire',
                  companySubtitle:
                      'Make the right hire with confidence and choose the perfect Candidate.',
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(3, (index) => _buildDot(index == _currentPage)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFFf06523) : Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
