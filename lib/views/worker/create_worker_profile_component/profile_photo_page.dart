import 'package:blukers/providers/worker_provider.dart';
import 'package:blukers/utils/styles/theme_colors.dart';
import 'package:blukers/views/worker/create_worker_profile_component/yourProfilePhoto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/responsive.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:blukers/views/common_views/components/timelines/timeline_navigation_button.dart';

class ProfilePhotoPage extends StatefulWidget {
  ProfilePhotoPage({Key? key}) : super(key: key);

  @override
  _ProfilePhotoPageState createState() => _ProfilePhotoPageState();
}

class _ProfilePhotoPageState extends State<ProfilePhotoPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    WorkerProvider wp = Provider.of<WorkerProvider>(context);

    return SizedBox(
      height: height * 0.7,
      child: Center(
        child: Container(
          color: Colors.white,
          width: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Text(
              //   AppLocalizations.of(context)!.uploadProfilePhoto,
              //   textAlign: TextAlign.center,
              //   style: const TextStyle(
              //     color: Colors.deepOrangeAccent,
              //     fontSize: 25,
              //     fontWeight: FontWeight.w600,
              //     height: 1.25,
              //   ),
              // ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const YourProfilePhoto(),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TimelineNavigationButton(
                        isSelected: true,
                        onPress: () {
                          wp.workerProfileBackPage();
                        },
                        navDirection: "back",
                      ),
                      TimelineNavigationButton(
                        isSelected: true,
                        onPress: () {
                          if (wp.appUser?.photoUrl != null) {
                            wp.workerProfileNextPage();
                          }
                          ;
                        },
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     wp.workerProfileBackPage();
                      //   },
                      //   child: Text(
                      //     AppLocalizations.of(context)!.previous,
                      //     style: TextStyle(
                      //       fontFamily: "Montserrat",
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      //   style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.all<Color>(
                      //         ThemeColors.secondaryThemeColor),
                      //   ),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     if (wp.appUser?.photoUrl != null) {
                      //       wp.workerProfileNextPage();
                      //     }
                      //     ;
                      //   },
                      //   style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.all<Color>(
                      //         ThemeColors.secondaryThemeColor),
                      //   ),
                      //   child: Text(
                      //     AppLocalizations.of(context)!.next,
                      //     style: TextStyle(
                      //       fontFamily: "Montserrat",
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
