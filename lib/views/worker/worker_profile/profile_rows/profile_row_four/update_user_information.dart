import 'package:blukers/providers/profile_update_provider.dart';
import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/old_common_views/components/profile/info_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/styles/index.dart';

class UpdateUserInformation extends StatefulWidget {
  const UpdateUserInformation({super.key});

  @override
  State<UpdateUserInformation> createState() => _UpdateUserInformationState();
}

class _UpdateUserInformationState extends State<UpdateUserInformation> {
  @override
  Widget build(BuildContext context) {
    ProfileUpdateProvider pup = Provider.of<ProfileUpdateProvider>(context);
    return Container(
      padding: EdgeInsets.only(
        left: Responsive.isMobile(context) ? 25 : 40,
        right: Responsive.isMobile(context) ? 25 : 40,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: Responsive.isMobile(context)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Text(
                  'User Information',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: Responsive.isMobile(context) ? 20 : 29),
                ),
              ],
            ),
            const SizedBox(
              height: 56,
            ),
            Column(
              children: [
                InfoInputWidget(
                  label: 'First Name',
                  controller: pup.firstNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InfoInputWidget(
                  label: 'Middle Name',
                  controller: pup.middleNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InfoInputWidget(
                  label: 'Last Name',
                  controller: pup.lastNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InfoInputWidget(
                  label: 'Description',
                  maxLines: 5,
                  controller: pup.descriptionController,
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            Center(
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    pup.updateAppUserInformation();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.primaryThemeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Update Changes',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: Responsive.isMobile(context) ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
