import 'package:bulkers/providers/worker_provider.dart';
import 'package:bulkers/utils/styles/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../auth/common_widget/auth_input.dart';

// Import other necessary packages here if required.

class PersonalInformationPage extends StatefulWidget {
  PersonalInformationPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    return SizedBox(
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Personal Information",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ebGaramond(
                        color: Colors.deepOrangeAccent,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AuthInput(
                      child: TextFormField(
                        controller: firstNameController,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        validator: (value) =>
                            value!.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "First Name",
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
                    AuthInput(
                      child: TextFormField(
                        controller: middleNameController,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        validator: (value) =>
                            value!.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "Middle Name",
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
                    AuthInput(
                      child: TextFormField(
                        controller: lastNameController,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        validator: (value) =>
                            value!.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "Last Name",
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
                      "Birthdate",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ebGaramond(
                        color: Colors.blueGrey,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
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
                                  return "Required";
                                }
                                final int? day = int.tryParse(value);
                                if (day == null || day < 1 || day > 31) {
                                  return "Enter a valid day (1-31)";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Day",
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: AuthInput(
                            child: TextFormField(
                              controller: birthMonthController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required";
                                }
                                final int? month = int.tryParse(value);
                                if (month == null || month < 1 || month > 12) {
                                  return "Enter a valid month (1-12)";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Month",
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: AuthInput(
                            child: TextFormField(
                              controller: birthYearController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required";
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
                                hintText: "Year",
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
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Go to the previous page
                          },
                          child: Text("Previous"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ThemeColors.secondaryThemeColor),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
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
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ThemeColors.secondaryThemeColor),
                          ),
                          child: const Text("Next"),
                        ),
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
