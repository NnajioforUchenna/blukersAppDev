import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../utils/styles/index.dart';
import '../../../../services/responsive.dart';
import '../../../old_common_views/small_pop_button_widget.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      insetPadding:
          const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 80),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: height * 0.05, bottom: height * 0.06),
                    child: Text(
                      'Basic Information',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Column(
                      children: [
                        TextInputWigdet(
                          label: 'Company Name',
                          maxlines: 1,
                          controller: nameController,
                        ),
                        TextInputWigdet(
                          label: 'Email',
                          maxlines: 1,
                          controller: emailController,
                        ),
                        TextInputWigdet(
                          label: 'Phone Number',
                          maxlines: 1,
                          controller: phoneNumberController,
                        ),
                        const SizedBox(height: 10),
                        TextInputWigdet(
                          label: 'Description',
                          maxlines: 5,
                          controller: descriptionController,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.03,
                    width: width * 0.30,
                    margin: EdgeInsets.only(top: height * 0.03, bottom: 30.0),
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
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: ThemeColors.secondaryThemeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: Responsive.isMobile(context) ? 9.sp : 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 10, // Adjust as needed
            left: 10, // Adjust as needed
            child: SmallPopButtonWidget(),
          ),
        ],
      ),
    );
  }

  TextInputWigdet(
      {required String label,
      required int maxlines,
      required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          maxLines: maxlines,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        )
      ],
    );
  }
}
