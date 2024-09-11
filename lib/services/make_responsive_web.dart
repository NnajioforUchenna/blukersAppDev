import 'package:blukers/utils/styles/theme_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MakeResponsiveWeb extends StatelessWidget {
  final ImageProvider image;
  final Widget child;

  const MakeResponsiveWeb({
    super.key,
    required this.image,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Desktop layout
          return Row(
            children: [
              Expanded(
                child: DisplayImage(image: image),
              ),
              Expanded(
                child: Center(child: child),
              ),
            ],
          );
        } else {
          // Mobile layout
          return child;
        }
      },
    );
  }
}

class DisplayImage extends StatelessWidget {
  final ImageProvider image;

  const DisplayImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Image(
                image: image,
                fit: BoxFit.cover,
                height: 400,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                AppLocalizations.of(context)!.workerJourneyTitle,
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.blukersBlueThemeColor,
                  fontFamily: "Montserrat",
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
