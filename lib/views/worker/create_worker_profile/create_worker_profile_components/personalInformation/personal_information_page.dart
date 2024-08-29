import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../../services/responsive.dart';
import '../../../../../../utils/styles/theme_colors.dart';
import '../../../../auth/common_widget/auth_input.dart';
import '../timeline_navigation_button.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  @override
  Widget build(BuildContext context) {
    CreateWorkerProfileProvider cwpp =
        Provider.of<CreateWorkerProfileProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);

    return SizedBox(
      height: height,
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  AuthInput(
                    child: TextFormField(
                      controller: cwpp.firstNameController,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                      validator: (value) => value!.isEmpty
                          ? AppLocalizations.of(context)!.required
                          : null,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.firstName,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  AuthInput(
                    child: TextFormField(
                      controller: cwpp.middleNameController,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                      // validator: (value) => value!.isEmpty
                      //     ? AppLocalizations.of(context)!.required
                      //     : null,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.middleName,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  AuthInput(
                    child: TextFormField(
                      controller: cwpp.lastNameController,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                      validator: (value) => value!.isEmpty
                          ? AppLocalizations.of(context)!.required
                          : null,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.lastName,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  // Add birthdate inputs (Day, Month, Year)
                  // You can adjust these fields based on your design preferences.
                  Text(
                    AppLocalizations.of(context)!.birthdate,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ThemeColors.blukersOrangeThemeColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AuthInput(
                          child: TextFormField(
                            controller: cwpp.birthDayController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.required;
                              }
                              final int? day = int.tryParse(value);
                              if (day == null || day < 1 || day > 31) {
                                return "Enter a valid day (1-31)";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.day,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: AuthInput(
                          child: TextFormField(
                            controller: cwpp.birthMonthController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.required;
                              }
                              final int? month = int.tryParse(value);
                              if (month == null || month < 1 || month > 12) {
                                return "Enter a valid month (1-12)";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.month,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: AuthInput(
                          child: TextFormField(
                            controller: cwpp.birthYearController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.required;
                              }
                              final int currentYear = DateTime.now().year;
                              final int? year = int.tryParse(value);
                              if (year == null ||
                                  year < 1900 ||
                                  year > currentYear) {
                                return "Enter a valid year (1900-$currentYear)";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.year,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TimelineNavigationButton(
                        isSelected: true,
                        onPress: () {
                          cwpp.workerProfileBackPage();
                        },
                        navDirection: "back",
                      ),
                      TimelineNavigationButton(
                        isSelected: cwpp.isFormComplete(),
                        onPress: () {
                          if (cwpp.isFormComplete()) {
                            cwpp.addPersonalInformtion();
                          } else {
                            EasyLoading.showError("Please fill all the fields");
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: height * .05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
