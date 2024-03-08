import 'update_resume.dart';
import 'package:flutter/material.dart';

import '../../profile_menu_button.dart';

class ProfileRowSix extends StatelessWidget {
  const ProfileRowSix({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuButton(
      text: "Resume",
      onPress: () {
        showDialog(
            context: context, builder: (context) => const UpdateResume());
      },
    );
  }
}
