import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../utils/styles/theme_colors.dart';
import 'select_input_profile_image.dart';

class ProfileRowTwo extends StatelessWidget {
  const ProfileRowTwo({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    String imageContent =
        up.appUser!.photoUrl != null && up.appUser!.photoUrl != ""
            ? up.appUser!.photoUrl!
            : "assets/images/userDefaultProfilePic.png";
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => const SelectInputProfileImage());
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              // color: ThemeColors.blukersBlueThemeColor,
              shape: BoxShape.circle, // Make the container circular
              border: Border.all(
                color: ThemeColors.blukersBlueThemeColor,
                width: 4.0, // Set the border width
              ),
            ),
            width: 160,
            height: 160,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  // color: ThemeColors.blukersBlueThemeColor,
                  shape: BoxShape.circle, // Make the container circular
                  border: Border.all(
                    color: Colors.white,
                    width: 4.0, // Set the border width
                  ),
                ),
                width: 150,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  // child: imageContent.isNotEmpty
                  //     ? FadeInImage.assetNetwork(
                  //         placeholder: "assets/images/loading.jpeg",
                  //         image: imageContent,
                  //         fit: BoxFit.fitWidth,
                  //       )
                  //     : Image.asset(
                  //         "assets/images/userDefaultProfilePic.png",
                  //         fit: BoxFit.fill,
                  //       ),
                  child: up.appUser!.photoUrl != null &&
                          up.appUser!.photoUrl != ""
                      ? FadeInImage.assetNetwork(
                          placeholder: "assets/images/loading.jpeg",
                          image: up.appUser!.photoUrl!,
                          //width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )
                      // : Image.asset("assets/images/userDefaultProfilePic.png"),
                      : FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset(
                              "assets/images/userDefaultProfilePic.png"),
                        ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: ThemeColors.secondaryThemeColor,
              child: Icon(
                UniconsLine.pen,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
