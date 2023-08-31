import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CountDown extends StatefulWidget {
  final String platform;
  const CountDown({Key? key, required this.platform}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  int waitTime = 30;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (waitTime > 0) {
        if (mounted) {
          // Check if the widget is still in the tree
          setState(() {
            waitTime--;
          });
        }
      } else {
        timer.cancel();
        // Navigator.pushReplacement(
        //    context, MaterialPageRoute(builder: (context) => const Screens()));
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Please give us 30 seconds',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 18.sp,
            ),
            DisplayTimer(),
            SizedBox(
              height: 18.sp,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'We are Connecting ${widget.platform} for Payment...',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 18.sp,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox DisplayTimer() {
    double square = 400;
    return SizedBox(
      width: square,
      height: square,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1 - (waitTime / 30),
            strokeWidth: 10,
            backgroundColor: Colors.grey,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          Center(
            child: Text(
              waitTime.toString(),
              style: GoogleFonts.permanentMarker(
                  fontSize: 120, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
