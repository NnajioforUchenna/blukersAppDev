import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../utils/styles/index.dart';
import '../../../../services/responsive.dart';
import 'info_input_widget.dart';

class UpdateCompanyBasicInformation extends StatefulWidget {
  const UpdateCompanyBasicInformation({super.key});

  @override
  State<UpdateCompanyBasicInformation> createState() =>
      _UpdateCompanyBasicInformationState();
}

class _UpdateCompanyBasicInformationState
    extends State<UpdateCompanyBasicInformation> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserProvider up = Provider.of<UserProvider>(context, listen: false);
      if (up.appUser != null && up.appUser?.company != null) {
        nameController.text = up.appUser?.company?.name ?? '';
        emailController.text = up.appUser?.company?.emails.first ?? '';
        phoneNumberController.text =
            up.appUser?.company?.phoneNumbers.first ?? '';
        descriptionController.text =
            up.appUser?.company?.companyDescription ?? '';
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      padding: EdgeInsets.only(
        top: 56,
        bottom: 56,
        left: Responsive.isMobile(context) ? 25 : 40,
        right: Responsive.isMobile(context) ? 25 : 40,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [SmallPopButtonWidget()],
            // ),
            Row(
              mainAxisAlignment: Responsive.isMobile(context)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Text(
                  'Basic Information',
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
                  label: 'Company Name',
                  controller: nameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InfoInputWidget(
                  label: 'Email',
                  controller: emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InfoInputWidget(
                  textInputType: TextInputType.number,
                  label: 'Phone Number',
                  controller: phoneNumberController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InfoInputWidget(
                  label: 'Description',
                  maxLines: 4,
                  controller: descriptionController,
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
                    UserProvider up =
                        Provider.of<UserProvider>(context, listen: false);
                    up.updateCompanyBasicInformation(
                      name: nameController.text,
                      description: descriptionController.text,
                      email: [emailController.text],
                      phoneNumber: [phoneNumberController.text],
                    );
                    if (Responsive.isMobile(context)) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ThemeColors.secondaryThemeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Update Changes',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: Responsive.isMobile(context) ? 16 : 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
