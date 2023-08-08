import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
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
    userRole = up.userRole;

    return SizedBox(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -MediaQuery.of(context).size.height * .15,
            right: -MediaQuery.of(context).size.width * .4,
            child: Container(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Basic Information",
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
                              return "Required";
                            } else {
                              return null;
                            }
                          }),
                          onSaved: (name) {
                            nameController.text = name!;
                          },
                          decoration: InputDecoration(
                              hintText: "Name",
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
                              return "Required";
                            } else {
                              return null;
                            }
                          }),
                          onSaved: (lastName) {
                            lastNameController.text = lastName!;
                          },
                          decoration: InputDecoration(
                              hintText: "LastName",
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
                              return "Required";
                            } else {
                              return null;
                            }
                          }),
                          onSaved: (companyName) {
                            companyNameController.text = companyName!;
                          },
                          decoration: InputDecoration(
                              hintText: "Company Name",
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
                        textInputAction: TextInputAction.next,
                        onChanged: (_) {
                          setState(() {
                            isFormComplete();
                          });
                        },
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        }),
                        onSaved: (description) {
                          descriptionController.text = description!;
                        },
                        decoration: InputDecoration(
                          hintText: "Description",
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
                      text: "Save To Profile",
                      isDisabled: !isFormComplete(),
                    ),
                    SizedBox(height: height * .05),
                    // SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          // Positioned(top: 40, left: 0, child: BackButton()),
        ],
      ),
    );
  }
}
