import 'package:blukers/views/auth/common_widget/auth_field_wrapper.dart';
import 'package:blukers/views/auth/common_widget/auth_text_form_field.dart';
import 'package:blukers/views/auth/registration/registration_component/timeline.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../services/responsive.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../common_widget/submit_button.dart';

class AppUserInformation extends StatefulWidget {
  const AppUserInformation({super.key});

  @override
  State<AppUserInformation> createState() => _AppUserInformationState();
}

class _AppUserInformationState extends State<AppUserInformation> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  String ext = '+52';
  bool isValidate = false;

  final _phoneController = TextEditingController();

  void _onCountryChange(CountryCode countryCode) {
    print("New Country selected: $countryCode");
  }

  bool isFormComplete() {
    return nameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);
    UserProvider up = Provider.of<UserProvider>(context);
    String initialSelection = up.userRole == 'company' ? '+1' : '+52';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 100),
                  if (!Responsive.isDesktop(context))
                    const Timeline(currentStep: 1),
                  if (!Responsive.isDesktop(context))
                    const SizedBox(height: 21),
                  Text(
                    up.userRole == "worker"
                        ? "App User Information"
                        : "Company Information",
                    style: GoogleFonts.montserrat(
                      color: ThemeColors.secondaryThemeColorDark,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AuthTextFieldWrapper(
                    label: "Phone Number",
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: ((value) {
                        if (value!.length < 10) {
                          return AppLocalizations.of(context)!
                              .tenDigitsRequired;
                        }
                        if (value.length > 10) {
                          return AppLocalizations.of(context)!
                              .tenDigitsRequired;
                        }
                        return null;
                      }),
                      controller: _phoneController,
                      onChanged: (value) {
                        setState(() {
                          isFormComplete();
                        });
                      },
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                ThemeColors.black1ThemeColor.withOpacity(.30),
                          ),
                          prefixIcon: CountryCodePicker(
                            onChanged: (value) {
                              ext = value.toString();
                              _onCountryChange(value);
                            },
                            initialSelection: initialSelection,
                            favorite: const ['+1', '+52', 'FR'],
                            padding: EdgeInsets.zero,
                            flagWidth: 20,
                            showDropDownButton: true,
                            showFlag: false,
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                          hintText: "Phone Number",
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                width: 0, color: ThemeColors.red1ThemeColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                width: 0,
                                color: ThemeColors.secondaryThemeColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(227, 238, 246, 1)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(227, 238, 246, 1)),
                          ),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: AuthTextFieldWrapper(
                          label: "First Name",
                          child: AuthTextFormField(
                            hintText: "Your First Name",
                            controller: nameController,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              setState(() {
                                node.nextFocus();
                                isFormComplete();
                              });
                            },
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.required;
                              } else {
                                return null;
                              }
                            }),
                            onSaved: (name) {
                              nameController.text = name!;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: AuthTextFieldWrapper(
                          label: "Last Name",
                          child: AuthTextFormField(
                            hintText: "Your Last Name",
                            controller: lastNameController,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              setState(() {
                                node.nextFocus();
                                isFormComplete();
                              });
                            },
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.required;
                              } else {
                                return null;
                              }
                            }),
                            onSaved: (lastName) {
                              lastNameController.text = lastName!;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.005),
                  const SizedBox(height: 20),
                  AuthTextFieldWrapper(
                    label: "Brief Description",
                    child: AuthTextFormField(
                      maxLines: 5,
                      hintText: up.userRole == "worker"
                          ? AppLocalizations.of(context)!.writeSomethingAboutYou
                          : AppLocalizations.of(context)!
                              .writeSomethingAboutYourCompany,
                      controller: descriptionController,
                      textInputAction: TextInputAction.newline,
                      onChanged: (_) {
                        setState(() {
                          isFormComplete();
                        });
                      },
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.required;
                        } else {
                          return null;
                        }
                      }),
                      onSaved: (description) {
                        descriptionController.text = description!;
                      },
                    ),
                  ),

                  const SizedBox(height: 40),
                  SubmitButton(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (isFormComplete()) {
                        up.addingContactInformation(
                            ext, _phoneController.text);
                        up.updateWorker(
                          name: nameController.text,
                          lastName: lastNameController.text,
                          description: descriptionController.text,
                        );
                      }
                    },
                    text: "Continue",
        
                    isDisabled: !isFormComplete(),
                  ),
                  SizedBox(height: height * .1),
                  // SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    descriptionController.dispose();
    nameController.dispose();
    lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
