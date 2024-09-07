import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../common_vieiws/policy_terms/policy_terms_components/loading_animation.dart';

class CountDown extends StatefulWidget {
  final String platform;
  const CountDown({super.key, required this.platform});

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  int waitTime = 30;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    // timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   if (waitTime > 0) {
    //     if (mounted) {
    //       setState(() {
    //         waitTime--;
    //       });
    //     }
    //   } else {
    //     timer.cancel();
    //     // Replace this with the action to "pop off"
    //     Navigator.pop(context); // Example action to pop the current widget
    //     // You can replace Navigator.pop(context) with the specific action you want to perform after 60 seconds
    //     EasyLoading.showError('Failed to Connect Payment Store',
    //         duration: const Duration(seconds: 3));
    //   }
    // });
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
            const SizedBox(
              height: 50,
            ),
            LoadingAnimation(
              // text: widget.platform,
              text: '${AppLocalizations.of(context)!.connecting}...',
            ),
            const SizedBox(
              height: 50,
            ),
            //DisplayTimer()
          ],
        ),
      ),
    );
  }

  SizedBox DisplayTimer() {
    double square = 200;
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
