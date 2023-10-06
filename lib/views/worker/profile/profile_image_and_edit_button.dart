import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';

class ProfileImageAndEditButton extends StatelessWidget {
  Function onTapCamera;
  Function onTapGallery;
  Widget imageContent;

  ProfileImageAndEditButton({
    required this.onTapCamera,
    required this.onTapGallery,
    required this.imageContent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          width: 150,
          height: 150,
          child: Container(
            margin: const EdgeInsets.all(3.0),
            child: Center(
              child: imageContent,
              // child: up.appUser!.photoUrl != null &&
              //         up.appUser!.photoUrl != ""
              //     ? FadeInImage.assetNetwork(
              //         placeholder: "assets/images/loading.jpeg",
              //         image: up.appUser!.photoUrl!,
              //         fit: BoxFit.fitWidth,
              //       )
              //     : Image.asset(
              //         "assets/images/userDefaultProfilePic.png",
              //         fit: BoxFit.fill,
              //       ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    //  height: 450,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 30),
                          Text(
                            AppLocalizations.of(context)!.changeProfilePicture,
                            style: ThemeTextStyles.headingThemeTextStyle,
                          ),
                          // const SizedBox(height: 20),
                          if (!kIsWeb)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 18),
                              child: Container(
                                //  height: 170,
                                width: 500,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffF3ECFF),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: onTapCamera(),
                                      // onTap: () async {
                                      //   String? imageUrl =
                                      //       await up.ontapCamera(
                                      //           "/profile_images/");
                                      //   if (imageUrl != "") {
                                      //     await up
                                      //         .updateUserProfilePic(
                                      //             imageUrl!);
                                      //   }
                                      //   Navigator.of(context)
                                      //       .pop();
                                      // },
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 100, vertical: 10),
                                        decoration: BoxDecoration(
                                          color:
                                              ThemeColors.blukersBlueThemeColor,
                                          borderRadius:
                                              BorderRadius.circular(80),
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.takePhoto,
                                      style:
                                          ThemeTextStyles.headingThemeTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Container(
                              //   height: 120,
                              width: 500,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffF3ECFF),
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: onTapGallery(),
                                    // onTap: () async {
                                    //   String? imageUrl =
                                    //       await up.ontapGallery(
                                    //           "/profile_images/");
                                    //   if (imageUrl != "") {
                                    //     await up
                                    //         .updateUserProfilePic(
                                    //             imageUrl!);
                                    //   }
                                    //   Navigator.of(context).pop();
                                    //   print(imageUrl);
                                    // },
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 100, vertical: 10),
                                      decoration: BoxDecoration(
                                        color:
                                            ThemeColors.blukersBlueThemeColor,
                                        borderRadius: BorderRadius.circular(80),
                                      ),
                                      child: const Image(
                                        image: AssetImage(
                                            "assets/images/galleryImage.png"),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.fromGallery,
                                    style:
                                        ThemeTextStyles.headingThemeTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: ThemeColors.secondaryThemeColor,
              child: Icon(
                UniconsLine.pen,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
