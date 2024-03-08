import 'package:flutter/material.dart';

import '../../../../../../common_vieiws/policy_terms/policy_terms_components/loading_animation.dart';

class CountDown extends StatefulWidget {
  final String platform;
  const CountDown({super.key, required this.platform});

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
