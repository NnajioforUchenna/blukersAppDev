import 'package:bulkers/providers/worker_provider.dart';
import 'package:bulkers/utils/styles/theme_colors.dart';
import 'package:bulkers/views/worker/create_worker_profile_component/yourProfilePhoto.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../services/responsive.dart';

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
          width: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Upload Profile Photo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const YourProfilePhoto(),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          if (wp.appUser?.photoUrl != null) {
                            wp.workerProfileNextPage();
                          }
                          ;
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ThemeColors.secondaryThemeColor),
                        ),
                        child: const Text("Next"),
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
