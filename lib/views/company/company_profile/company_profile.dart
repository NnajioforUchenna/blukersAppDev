import 'package:blukers/providers/company_provider.dart';
import 'package:blukers/views/company/company_profile/components/update_company_basic_information.dart';
import 'package:blukers/views/company/company_profile/components/updatecompanyinformation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../providers/company_chat_provider.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/index.dart';
import '../../auth/common_widget/login_or_register.dart';
import '../../old_common_views/components/app_version_display.dart';
import '../../old_common_views/components/confirmation_dialog.dart';
import '../../old_common_views/components/profile/profile_menu_button.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);

    return up.appUser == null
        ? const LoginOrRegister()
        : Responsive(
            mobile: Padding(
              padding: const EdgeInsets.only(top: 56, left: 24, right: 24),
              child: CompanyInfoWidget(
                index: index,
                onTapDesktop: (int i) {
                  setState(() {
                    index = i;
                  });
                },
              ),
            ),
            desktop: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: Container(
                  padding: const EdgeInsets.only(top: 40),
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            margin: const EdgeInsets.only(right: 34),
                            child: CompanyInfoWidget(
                              index: index,
                              onTapDesktop: (int i) {
                                setState(() {
                                  index = i;
                                });
                              },
                            )),
                      ),
                      Expanded(
                          flex: 8,
                          child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x1A000000),
                                      offset: Offset(0, 2),
                                      blurRadius: 3,
                                    ),
                                    BoxShadow(
                                      color: Color(0x17000000),
                                      offset: Offset(0, 6),
                                      blurRadius: 6,
                                    ),
                                    BoxShadow(
                                      color: Color(0x0D000000),
                                      offset: Offset(0, 14),
                                      blurRadius: 9,
                                    ),
                                    BoxShadow(
                                      color: Color(0x03000000),
                                      offset: Offset(0, 25),
                                      blurRadius: 10,
                                    ),
                                    BoxShadow(
                                      color: Color(0x00F35507),
                                      offset: Offset(0, 39),
                                      blurRadius: 11,
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xFFF35507)
                                          .withOpacity(.10))),
                              child: index == 0
                                  ? const UpdateCompanyBasicInformation()
                                  : const UpdateCompanyInformation()))
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

Widget buildProfilePicAndEdit(context, up, cp) {
  UserProvider up = Provider.of<UserProvider>(context);
  CompanyProvider cp = Provider.of<CompanyProvider>(context);
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
                                      String? imageUrl = await cp
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
                                        borderRadius: BorderRadius.circular(80),
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
                                    String? imageUrl = await cp
                                        .ontapGallery("/profile_images/");
                                    if (imageUrl != "") {
                                      await up.updateUserProfilePic(imageUrl!);
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
                                      color: ThemeColors.blukersBlueThemeColor,
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
                                  style: ThemeTextStyles.headingThemeTextStyle,
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
            backgroundColor: ThemeColors.primaryThemeColor,
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
      shape: BoxShape.circle,
      border: Border.all(
        color: ThemeColors.secondaryThemeColorDark,
        width: 4.0,
      ),
    ),
    width: 160,
    height: 160,
    child: Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 4.0,
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
                  fit: BoxFit.cover,
                )
              : FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset("assets/images/userDefaultProfilePic.png"),
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
    textColor: const Color(0xFFC85E5E),
    trailing: SvgPicture.asset(
      "assets/icons/delete_icon.svg",
      height: 25,
      colorFilter: const ColorFilter.mode(Color(0xFFC85E5E), BlendMode.srcIn),
    ),
    onPress: () {
      if (up.appUser != null) {
        confirmationDialog(
          context: context,
          stringsTemplate: 'deleteAccount',
          onConfirm: () async {
            await up.deleteUser(up.appUser!.uid);
            Navigator.of(context).pushReplacementNamed('/');
          },
        );
      }
    },
  );
}

class CompanyInfoWidget extends StatelessWidget {
  final int index;
  final Function onTapDesktop;
  const CompanyInfoWidget(
      {super.key, required this.index, required this.onTapDesktop});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    CompanyChatProvider chatProvider =
        Provider.of<CompanyChatProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildProfilePicAndEdit(context, up, cp),
          const SizedBox(height: 16),
          Center(
            child: Text(
              up.appUser?.company?.name ?? "",
              style: GoogleFonts.montserrat(
                  fontSize: Responsive.isMobile(context) ? 14 : 18,
                  color: ThemeColors.primaryThemeColor,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: Responsive.isDesktop(context) ? 16 : 35),
          if (Responsive.isDesktop(context))
            DesktopMenuButton(
              selectedBorderColor: ThemeColors.secondaryThemeColor,
                onPressed: () {
                  onTapDesktop(0);
                },
                isSelected: index == 0,
                child: Text(
                  AppLocalizations.of(context)!.basicInformation,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: index == 0 ? Colors.black : const Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                ))
          else
            ProfileMenuButton(
              text: AppLocalizations.of(context)!.basicInformation,
              onPress: () {
                showDialog(
                  context: context,
                  builder: (context) => const UpdateUserInfoDialog(
                      child: UpdateCompanyBasicInformation()),
                );
              },
            ),
          if (Responsive.isMobile(context)) const SizedBox(height: 16),
          if (Responsive.isDesktop(context))
            DesktopMenuButton(
              selectedBorderColor: ThemeColors.secondaryThemeColor,
                onPressed: () {
                  onTapDesktop(1);
                },
                isSelected: index == 1,
                child: Text(
                  AppLocalizations.of(context)!.companyInformation,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: index == 1 ? Colors.black : const Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                ))
          else
            ProfileMenuButton(
              text: AppLocalizations.of(context)!.companyInformation,
              onPress: () {
                showDialog(
                  context: context,
                  builder: (context) => const UpdateUserInfoDialog(
                      child: UpdateCompanyInformation()),
                );
              },
            ),
          const SizedBox(height: 36),
          if (Responsive.isDesktop(context))
            DesktopMenuButton(
              selectedBorderColor: ThemeColors.secondaryThemeColor,
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
                isSelected: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Log out",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: const Color(0xFF757575),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(
                      Icons.logout,
                      size: 30.0,
                      color: Color(0xFF595959),
                    ),
                  ],
                ))
          else
            ProfileMenuButton(
              text: "Log out",
              trailing: const Icon(
                Icons.logout,
                size: 25.0,
                color: Color(0xFF595959),
              ),
              onPress: () {
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
          if (Responsive.isMobile(context)) const SizedBox(height: 16),
          if (Responsive.isDesktop(context))
            DesktopMenuButton(
                onPressed: () {
                  confirmationDialog(
                    context: context,
                    stringsTemplate: 'deleteAccount',
                    onConfirm: () async {
                      // Navigator.of(context).pushReplacementNamed('/');
                      await up.deleteUser(up.appUser!.uid);
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                  );
                },
                isSelected: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.deleteAccount,
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: const Color(0xFFC85E5E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/delete_icon.svg",
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                          Color(0xFFC85E5E), BlendMode.srcIn),
                    ),
                  ],
                ))
          else
            buildDeleteAccountSection(context, up),
          const SizedBox(height: 25),
          const AppVersionDisplay(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
