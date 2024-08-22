import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../utils/styles/theme_colors.dart';

class SelectInputProfileImage extends StatelessWidget {
  const SelectInputProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
    return Dialog(
      backgroundColor: ThemeColors.blukersBlueThemeColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      insetPadding: EdgeInsets.only(
          left: 16, right: 16, top: height * 0.27, bottom: height * 0.27),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.05),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SelectButton(
                  leading: Icons.photo_library,
                  title: 'Choose from library',
                  onTap: () async {
                    print("Choose from library");
                    String? imageUrl =
                        await up.ontapGallery("/profile_images/");
                    if (imageUrl != "") {
                      await up.updateUserProfilePic(imageUrl!);
                    }
                    Navigator.of(context).pop();
                    print(imageUrl);
                  },
                ),
                SelectButton(
                  leading: Icons.camera_alt,
                  title: 'Take photo',
                  onTap: (!kIsWeb)
                      ? () async {
                          print("Take photo");
                          String? imageUrl =
                              await up.ontapCamera("/profile_images/");
                          if (imageUrl != "") {
                            await up.updateUserProfilePic(imageUrl!);
                          }
                          Navigator.of(context).pop();
                        }
                      : () async {
                          print('You are on the web');
                        },
                ),
                SelectButton(
                  leading: Icons.delete,
                  title: 'Delete',
                  onTap: () async {
                    print("Delete");
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 10, // Adjust as needed
            left: 15, // Adjust as needed
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text("x",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}

SelectButton(
    {required IconData leading,
    required String title,
    required Future<Null> Function() onTap}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      // margin: const EdgeInsets.all(14.0),
      margin: const EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the container
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25), // Box shadow color
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              leading,
              size: 30.0,
              color: ThemeColors.secondaryThemeColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: GoogleFonts.montserrat(
                color: ThemeColors.grey1ThemeColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
