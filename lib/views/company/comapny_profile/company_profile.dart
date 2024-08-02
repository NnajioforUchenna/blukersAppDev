import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../providers/company_chat_provider.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../utils/styles/index.dart';
import '../../auth/common_widget/login_or_register.dart';
import '../../old_common_views/components/app_version_display.dart';
import '../../old_common_views/components/confirmation_dialog.dart';
import '../../old_common_views/components/profile/profile_menu_button.dart';
import 'components/update_company_basic_information.dart';
import 'components/updatecompanyinformation.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  bool showBasicInfo = false;

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);

    return up.appUser == null
        ? const LoginOrRegister()
        : LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (constraints.maxWidth >= 600)
                      // Show the image only on larger screens
                      Container(
                        margin: EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            '../../../assets/images/desktopprofilepic.png', // Update path if needed
                            width: 800, // Adjust width as needed
                            height: 1000, // Adjust height as needed
                          ),
                        ),
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildSignoutButton(context),
                          const SizedBox(height: 10),
                          buildProfilePicAndEdit(context, up),
                          const SizedBox(height: 10),
                          Text(
                            up.appUser?.company?.name ?? "",
                            style: ThemeTextStyles.headingThemeTextStyle,
                            textAlign:
                                TextAlign.center, // Center-align the text
                          ),
                          const SizedBox(height: 10),
                          ProfileMenuButton(
                            text:
                                AppLocalizations.of(context)!.basicInformation,
                            onPress: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const UpdateCompanyBasicInformation(),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          ProfileMenuButton(
                            text: AppLocalizations.of(context)!
                                .companyInformation,
                            onPress: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const UpdateCompanyInformation(),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          buildDeleteAccountSection(context, up),
                          const SizedBox(height: 40),
                          const AppVersionDisplay(),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }

  Widget buildProfilePicAndEdit(context, up) {
    return Stack(
      children: [
        buildProfileImage(context, up),
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
                                      onTap: () async {
                                        String? imageUrl = await up
                                            .ontapCamera("/profile_images/");
                                        if (imageUrl != "") {
                                          await up
                                              .updateUserProfilePic(imageUrl!);
                                        }
                                        Navigator.of(context).pop();
                                      },
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
                                    onTap: () async {
                                      String? imageUrl = await up
                                          .ontapGallery("/profile_images/");
                                      if (imageUrl != "") {
                                        await up
                                            .updateUserProfilePic(imageUrl!);
                                      }
                                      Navigator.of(context).pop();
                                      print(imageUrl);
                                    },
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

  Widget buildProfileImage(context, up) {
    return Container(
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
            child: up.appUser!.photoUrl != null && up.appUser!.photoUrl != ""
                ? FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.jpeg",
                    image: up.appUser!.photoUrl!,
                    //width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )
                // : Image.asset("assets/images/userDefaultProfilePic.png"),
                : FittedBox(
                    fit: BoxFit.fill,
                    child:
                        Image.asset("assets/images/userDefaultProfilePic.png"),
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildDeleteAccountSection(context, up) {
    UserProvider up = Provider.of<UserProvider>(context);
    return ProfileMenuButton(
      text: AppLocalizations.of(context)!.deleteAccount,
      textColor: Colors.red,
      onPress: () {
        // print("Section clicked/ Edit Clicked");
        if (up.appUser != null) {
          // print("delete user");
          // chatProvider.clearGroups();
          // up.deleteUser(up.appUser!.uid);
          confirmationDialog(
            context: context,
            stringsTemplate: 'deleteAccount',
            onConfirm: () async {
              // Navigator.of(context).pushReplacementNamed('/');
              await up.deleteUser(up.appUser!.uid);
              Navigator.of(context).pushReplacementNamed('/');
            },
          );
        }
      },
    );
  }

  Widget buildSignoutButton(context) {
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
                AppLocalizations.of(context)!.profile,
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
