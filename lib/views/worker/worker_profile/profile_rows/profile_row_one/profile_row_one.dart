import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../../providers/company_chat_provider.dart';
import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../utils/styles/theme_colors.dart';
import '../../../../old_common_views/components/confirmation_dialog.dart';

class ProfileRowOne extends StatelessWidget {
  const ProfileRowOne({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    CompanyChatProvider chatProvider =
        Provider.of<CompanyChatProvider>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Center(
              child: Text(
                "Profile",
                style: GoogleFonts.montserrat(
                  color: ThemeColors.primaryThemeColor,
                  fontSize: 23,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              height: 100,
              width: 150,
              padding: const EdgeInsets.only(bottom: 10.0),
              child: IconButton(
                icon: const Icon(
                  UniconsLine.sign_out_alt,
                  size: 50,
                  color: Colors.red,
                ),
                onPressed: () {
                  confirmationDialog(
                    context: context,
                    stringsTemplate: 'logout',
                    onConfirm: () async {
                      chatProvider.clearGroups();
                      await up.signOut();
                      context.go('/');
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
