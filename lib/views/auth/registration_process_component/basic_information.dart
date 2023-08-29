import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../providers/user_provider.dart';
import '../../../services/responsive.dart';
import '../common_widget/auth_input.dart';
import '../common_widget/submit_button.dart';

class BasicInformation extends StatefulWidget {
  BasicInformation({super.key});

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  TextEditingController descriptionController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController companyNameController = TextEditingController();

  String userRole = "";

  bool isFormComplete() {
    if (userRole == "worker") {
      return nameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty;
    } else if (userRole == "company") {
      return companyNameController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);
    UserProvider up = Provider.of<UserProvider>(context);
    userRole = up.userRole!;

    return Container(
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.7),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.basicInformation,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (userRole == "worker") ...[
                    AuthInput(
                      child: TextFormField(
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
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.name,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    AuthInput(
                      child: TextFormField(
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
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.lastName,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    // SizedBox(height: 15),
                  ],
                  if (userRole == "company") ...[
                    AuthInput(
                      child: TextFormField(
                        controller: companyNameController,
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
                        onSaved: (companyName) {
                          companyNameController.text = companyName!;
                        },
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.companyName,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                  ],
                  const SizedBox(height: 20),
                  AuthInput(
                    child: TextFormField(
                      maxLines: 5,
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
                      decoration: InputDecoration(
                        hintText: userRole == "worker"
                            ? AppLocalizations.of(context)!
                                .writeSomethingAboutYou
                            : AppLocalizations.of(context)!
                                .writeSomethingAboutYourCompany,
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

                  const SizedBox(height: 40),
                  SubmitButton(
                    onTap: () {
                      if (isFormComplete()) {
                        if (userRole == "worker") {
                          up.updateWorker(
                            name: nameController.text,
                            lastName: lastNameController.text,
                            description: descriptionController.text,
                          );
                        } else if (userRole == "company") {
                          up.updateCompany(
                            companyName: companyNameController.text,
                            description: descriptionController.text,
                          );
                        }
                      }
                    },
                    text: AppLocalizations.of(context)!.saveProfile,
                    isDisabled: !isFormComplete(),
                  ),
                  SizedBox(height: height * .05),
                  // SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
