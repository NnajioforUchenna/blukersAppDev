import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../services/responsive.dart';
import '../../../../../utils/styles/theme_colors.dart';
import '../../../../old_common_views/small_pop_button_widget.dart';
import 'update_reference_form.dart';

class UpdateReferences extends StatefulWidget {
  const UpdateReferences({super.key});

  @override
  State<UpdateReferences> createState() => _UpdateReferencesState();
}

class _UpdateReferencesState extends State<UpdateReferences> {
  @override
  void initState() {
    UserProvider up = Provider.of<UserProvider>(context, listen: false);
    up.references = up.getReferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
    List<UpdateReferenceForm> referenceForms = [];

    for (int i = 0; i < up.references.length; i++) {
      referenceForms.add(UpdateReferenceForm(index: i));
    }

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
            margin: EdgeInsets.only(top: height * 0.04, bottom: height * 0.05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: height * 0.01),
                    child: Text(
                      'References',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  ...referenceForms,
                  Tooltip(
                    message:
                        AppLocalizations.of(context)!.addMorePersonalReferences,
                    child: InkWell(
                      onTap: () {
                        up.addReference();
                      },
                      child: Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              up.addReference();
                            },
                          ),
                          const SizedBox(width: 10),
                          Text(
                            AppLocalizations.of(context)!
                                .addMorePersonalReferences,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.03,
                    width: width * 0.30,
                    margin: EdgeInsets.only(top: height * 0.03, bottom: 30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        up.updateReferences();
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
}
