import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blukers/views/common_views/components/loading_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountDown extends StatefulWidget {
  final String platform;
  const CountDown({Key? key, required this.platform}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimation(
        // text: widget.platform,
        // text: AppLocalizations.of(context)!.connecting + '...',
        text: '',
      ),
    );
  }
}
