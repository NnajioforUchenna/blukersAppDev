import '../../../../old_common_views/components/profile/profile_menu_button.dart';
import 'update_resume.dart';
import 'package:flutter/material.dart';



class ProfileRowSix extends StatelessWidget {
  const ProfileRowSix({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuButton(
      text: "Resume",
      onPress: () {
        showDialog(
            context: context, builder: (context) => const UpdateUserInfoDialog(child: UpdateResume()));
      },
    );
  }
}
