import '../../../../../../providers/worker_provider.dart';
import '../../../../../../utils/styles/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../../services/responsive.dart';
import '../../../../../auth/common_widget/auth_input.dart';
import '../../../../../old_common_views/components/timelines/timeline_navigation_button.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  _PersonalInformationPageState createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController birthMonthController = TextEditingController();
  TextEditingController birthYearController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isFormComplete() {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        birthDayController.text.isNotEmpty &&
        birthMonthController.text.isNotEmpty &&
        birthYearController.text.isNotEmpty;
  }

  ScrollController scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WorkerProvider wp = Provider.of<WorkerProvider>(context, listen: false);
      firstNameController.text = wp.previousParams["firstName"] ?? "";
      middleNameController.text = wp.previousParams["middleName"] ?? "";
      lastNameController.text = wp.previousParams["lastName"] ?? "";
      birthDayController.text = wp.previousParams["birthDay"] ?? "";
      birthMonthController.text = wp.previousParams["birthMonth"] ?? "";
      birthYearController.text = wp.previousParams["birthYear"] ?? "";
      //added this listner to dismiss keyboard when scroll
      scrollCtrl.addListener(() {
        print('scrolling');
      });
      scrollCtrl.position.isScrollingNotifier.addListener(() {
        if (!scrollCtrl.position.isScrollingNotifier.value) {
          print('scroll is stopped');
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          print('scroll is started');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
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
              controller: scrollCtrl,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Text(
                    //   AppLocalizations.of(context)!.personalInformation,
                    //   textAlign: TextAlign.center,
                    //   style: const TextStyle(
                    //     color: Colors.deepOrangeAccent,
                    //     fontSize: 25,
                    //     fontWeight: FontWeight.w600,
                    //     height: 1.25,
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    AuthInput(
                      child: TextFormField(
                        controller: firstNameController,
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
                        controller: middleNameController,
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
                        controller: lastNameController,
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
                              controller: birthDayController,
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
                              controller: birthMonthController,
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
                              controller: birthYearController,
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
                            wp.workerProfileBackPage();
                          },
                          navDirection: "back",
                        ),
                        TimelineNavigationButton(
                          isSelected: isFormComplete(),
                          onPress: () {
                            if (_formKey.currentState!.validate() &&
                                isFormComplete()) {
                              wp.addPersonalInformtion(
                                firstNameController.text,
                                middleNameController.text,
                                lastNameController.text,
                                birthDayController.text,
                                birthMonthController.text,
                                birthYearController.text,
                              );
                              print("Personal Information Added");
                            } else {
                              EasyLoading.showError(
                                  "Please fill all the fields");
                            }
                          },
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     wp.workerProfileBackPage();
                        //   },
                        //   child: Text(
                        //     AppLocalizations.of(context)!.previous,
                        //     style: TextStyle(
                        //       fontFamily: "Montserrat",
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        //   style: ButtonStyle(
                        //     backgroundColor: MaterialStateProperty.all<Color>(
                        //         ThemeColors.secondaryThemeColor),
                        //   ),
                        // ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     if (_formKey.currentState!.validate() &&
                        //         isFormComplete()) {
                        //       wp.addPersonalInformtion(
                        //         firstNameController.text,
                        //         middleNameController.text,
                        //         lastNameController.text,
                        //         birthDayController.text,
                        //         birthMonthController.text,
                        //         birthYearController.text,
                        //       );
                        //       print("Personal Information Added");
                        //     } else {
                        //       EasyLoading.showError(
                        //           "Please fill all the fields");
                        //     }
                        //   },
                        //   style: ButtonStyle(
                        //     backgroundColor: MaterialStateProperty.all<Color>(
                        //         ThemeColors.secondaryThemeColor),
                        //   ),
                        //   child: Text(
                        //     AppLocalizations.of(context)!.next,
                        //     style: TextStyle(
                        //       fontFamily: "Montserrat",
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: height * .05),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
