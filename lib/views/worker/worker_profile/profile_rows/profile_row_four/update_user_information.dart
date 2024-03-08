import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../old_common_views/small_pop_button_widget.dart';

class UpdateUserInformation extends StatefulWidget {
  const UpdateUserInformation({super.key});

  @override
  State<UpdateUserInformation> createState() => _UpdateUserInformationState();
}

class _UpdateUserInformationState extends State<UpdateUserInformation> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserProvider up = Provider.of<UserProvider>(context, listen: false);
      if (up.appUser != null && up.appUser?.worker != null) {
        firstNameController.text = up.appUser?.worker?.firstName ?? '';
        lastNameController.text = up.appUser?.worker?.lastName ?? '';
        middleNameController.text = up.appUser?.worker?.middleName ?? '';
        descriptionController.text =
            up.appUser?.worker?.workerBriefDescription ?? '';
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
                      'User Information',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Column(
                      children: [
                        TextInputWigdet(
                          label: 'First Name',
                          maxlines: 1,
                          controller: firstNameController,
                        ),
                        const SizedBox(height: 10),
                        TextInputWigdet(
                          label: 'Middle Name',
                          maxlines: 1,
                          controller: middleNameController,
                        ),
                        const SizedBox(height: 10),
                        TextInputWigdet(
                          label: 'Last Name',
                          maxlines: 1,
                          controller: lastNameController,
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
                    width: width * 0.23,
                    margin: EdgeInsets.only(top: height * 0.03, bottom: 30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        UserProvider up =
                            Provider.of<UserProvider>(context, listen: false);
                        up.updateUserInformation(
                          firstName: firstNameController.text,
                          middleName: middleNameController.text,
                          lastName: lastNameController.text,
                          description: descriptionController.text,
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
                          fontSize: 12.0,
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
