import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/worker_provider.dart';
import '../../../../../services/responsive.dart';
import 'timeline_navigation_button.dart';
import 'yourProfilePhoto.dart';

class ProfilePhotoPage extends StatefulWidget {
  const ProfilePhotoPage({super.key});

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
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
                            wp.updateWorkerProfilePhoto(wp.appUser!.photoUrl!);
                            wp.workerProfileNextPage();
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
    );
  }
}
