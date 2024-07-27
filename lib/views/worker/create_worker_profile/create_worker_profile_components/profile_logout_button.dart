import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileLogoutButton extends StatelessWidget {
  Function onTap;

  ProfileLogoutButton({super.key, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap(),
          child: Container(
            // margin: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxWidth: 350),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 24,
            ),
            width: width * .90,
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.logout,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  UniconsLine.sign_out_alt,
                  size: 40,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
