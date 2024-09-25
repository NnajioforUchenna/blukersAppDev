import 'package:blukers/views/company/company_profile/components/info_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../utils/styles/index.dart';
import '../../../../services/responsive.dart';

class UpdateCompanyInformation extends StatefulWidget {
  const UpdateCompanyInformation({super.key});

  @override
  State<UpdateCompanyInformation> createState() =>
      _UpdateCompanyInformationState();
}

class _UpdateCompanyInformationState extends State<UpdateCompanyInformation> {
  TextEditingController yearFoundedController = TextEditingController();
  TextEditingController totalEmployeesController = TextEditingController();
  TextEditingController companyJobs = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserProvider up = Provider.of<UserProvider>(context, listen: false);
      if (up.appUser != null && up.appUser?.company != null) {
        yearFoundedController.text =
            up.appUser?.company?.yearFounded.toString() ?? '';
        totalEmployeesController.text =
            up.appUser?.company?.totalEmployees.toString() ?? '';
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
            Row(
              mainAxisAlignment: Responsive.isMobile(context)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Text(
                  'Company Information',
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
                  label: 'Year Founded',
                  textInputType: TextInputType.number,
                  controller: yearFoundedController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InfoInputWidget(
                  textInputType: TextInputType.number,
                  label: 'Total Number Of Employees',
                  controller: totalEmployeesController,
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
                    up.updateCompanyInformation(
                      yearFounded: int.parse(yearFoundedController.text),
                      totalEmployees: int.parse(totalEmployeesController.text),
                    );
                    if (Responsive.isMobile(context)) {
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
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
                      fontWeight: FontWeight.w700,
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
