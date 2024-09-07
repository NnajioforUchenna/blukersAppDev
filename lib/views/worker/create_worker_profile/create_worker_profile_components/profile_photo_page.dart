import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../services/responsive.dart';
import 'resume_profile_photo.dart';
import 'timeline_navigation_button.dart';

class ProfilePhotoPage extends StatefulWidget {
  const ProfilePhotoPage({super.key});

  @override
  _ProfilePhotoPageState createState() => _ProfilePhotoPageState();
}

class _ProfilePhotoPageState extends State<ProfilePhotoPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    CreateWorkerProfileProvider cwpp =
        Provider.of<CreateWorkerProfileProvider>(context);

    return SizedBox(
      height: height * 0.7,
      child: Center(
        child: Container(
          color: Colors.white,
          width: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Column(
                  children: [
                    const ResumeProfilePhoto(),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TimelineNavigationButton(
                          isSelected: true,
                          onPress: () {
                            cwpp.workerProfileBackPage();
                          },
                          navDirection: "back",
                        ),
                        TimelineNavigationButton(
                          isSelected: true,
                          onPress: () {
                            if (cwpp.appUser?.photoUrl != null) {
                              cwpp.updateWorkerProfilePhoto(
                                  cwpp.appUser!.photoUrl!);
                              cwpp.workerProfileNextPage();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
