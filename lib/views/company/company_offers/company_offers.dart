import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompanyOffers extends StatelessWidget {
  const CompanyOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.comingSoon,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 30,
        ),
      ),
    );
  }
}
