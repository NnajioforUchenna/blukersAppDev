import 'package:blukers/utils/styles/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/create_worker_profile_provider.dart';

class ResumeProfilePhoto extends StatelessWidget {
  const ResumeProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    CreateWorkerProfileProvider cwpp =
        Provider.of<CreateWorkerProfileProvider>(context);
    String? logoUrl = cwpp.appUser?.workerResumeDetails?.profilePhotoUrl;

    return InkWell(
      onTap: () {
        cwpp.selectProfilePhoto(context);
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: ThemeColors.primaryThemeColor,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: logoUrl == null || logoUrl.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/user-id-verification.png",
                                  height: 50,
                                  width: 50,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  textAlign: TextAlign.center,
                                  AppLocalizations.of(context)!
                                      .tapToSelectAndUploadAFile,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                              ],
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: logoUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
