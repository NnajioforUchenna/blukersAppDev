import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../utils/styles/theme_colors.dart';

class DifferentPlatformErrorDialog extends StatelessWidget {
  final String initialSubscriptionPlatform;
  final String currentPlatform;

  const DifferentPlatformErrorDialog({
    super.key,
    required this.initialSubscriptionPlatform,
    required this.currentPlatform,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      child: IntrinsicHeight(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      backgroundColor: ThemeColors.blukersOrangeThemeColor,
                      child: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 30.0),
                child: Text(
                  'Platform Mismatch Detected',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'It seems you\'re trying to modify your subscription on a different platform ($currentPlatform) than the one you originally subscribed with ($initialSubscriptionPlatform). Please use the same platform ($initialSubscriptionPlatform) for upgrading or downgrading your current plan.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
