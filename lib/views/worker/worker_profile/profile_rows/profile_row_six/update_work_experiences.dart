import '../../../../../providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/styles/theme_colors.dart';
import '../../../../old_common_views/small_pop_button_widget.dart';
import 'update_work_experience_components/update_work_experience_form.dart';

class UpdateWorkExperiences extends StatefulWidget {
  const UpdateWorkExperiences({super.key});

  @override
  State<UpdateWorkExperiences> createState() => _UpdateWorkExperiencesState();
}

class _UpdateWorkExperiencesState extends State<UpdateWorkExperiences> {
  @override
  void initState() {
    UserProvider up = Provider.of<UserProvider>(context, listen: false);
    up.workExperiences = up.getWorkExperiences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
    List<UpdateWorkExperienceForm> workExperienceForms = [];
    for (int i = 0; i < up.workExperiences.length; i++) {
      workExperienceForms.add(UpdateWorkExperienceForm(index: i));
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
            margin: EdgeInsets.only(top: height * 0.02, bottom: height * 0.05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: height * 0.02, bottom: height * 0.03),
                    child: Text(
                      'Work Experience',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  ...workExperienceForms,
                  Tooltip(
                    message:
                        AppLocalizations.of(context)!.addMoreWorkExperience,
                    child: InkWell(
                      onTap: () {
                        up.addWorkExperience();
                      },
                      child: Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              up.addWorkExperience();
                            },
                          ),
                          const SizedBox(width: 10),
                          Text(
                            AppLocalizations.of(context)!.addMoreWorkExperience,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.03,
                    width: width * 0.23,
                    margin: EdgeInsets.only(top: height * 0.03, bottom: 30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        up.updateWorkExperiences();
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
}
