import 'package:bulkers/providers/chat_provider.dart';
import 'package:bulkers/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../services/validation.dart';
import '../../../providers/user_provider.dart';
import '../common_widget/auth_input.dart';
import '../common_widget/label_button.dart';
import '../common_widget/submit_button.dart';

class LoginInformation extends StatefulWidget {
  const LoginInformation({super.key});

  @override
  State<LoginInformation> createState() => _LoginInformationState();
}

class _LoginInformationState extends State<LoginInformation> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String groupValue = '';
  final _formKey = GlobalKey<FormState>();

  bool isFormComplete() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        groupValue.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);
    UserProvider up = Provider.of<UserProvider>(context);
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);
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
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Create Your Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AuthInput(
                      child: TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          setState(() {
                            isFormComplete();
                            node.nextFocus();
                          });
                        },
                        validator: ((value) {
                          return Validation().validateEmail(value);
                        }),
                        decoration: InputDecoration(
                          hintText: "Email",
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
                    SizedBox(height: height * 0.010),
                    AuthInput(
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          setState(() {
                            isFormComplete();
                            node.unfocus();
                          });
                        },
                        validator: ((value) {
                          if (value!.length < 4) {
                            return "Enter More Than 3 Characters";
                          } else {
                            return null;
                          }
                        }),
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              true ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey[300],
                            ),
                            onPressed: () {},
                          ),
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
                    const SizedBox(height: 20),
                    Text(
                      "Are you registering as a company or an individual? ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // color: Colors.green.shade800,
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(66, 129, 129, 129),
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              contentPadding: const EdgeInsets.all(0),
                              dense: true,
                              title: Text(
                                "Individual",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 1.25,
                                ),
                              ),
                              value: "worker",
                              groupValue: groupValue,
                              onChanged: (value) {
                                setState(() {
                                  up.userRole = value.toString();
                                  groupValue = value.toString();
                                  isFormComplete();
                                });
                              },
                              activeColor: const Color.fromRGBO(0, 130, 66, 1),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              contentPadding: const EdgeInsets.all(0),
                              dense: true,
                              title: Text(
                                "Company",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 1.25,
                                ),
                              ),
                              value: "company",
                              groupValue: groupValue,
                              onChanged: (value) {
                                setState(() {
                                  up.userRole = value.toString();
                                  groupValue = value.toString();
                                  isFormComplete();
                                });
                              },
                              activeColor: const Color.fromRGBO(0, 130, 66, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    SubmitButton(
                      onTap: () {
                        if (isFormComplete()) {
                          print("Form is Complete");
                          up.registerUser(
                            email: emailController.text,
                            password: passwordController.text,
                            userType: groupValue,
                            chatProvider: chatProvider,
                          );
                        }
                      },
                      text: "Register Now",
                      isDisabled: !isFormComplete(),
                    ),
                    SizedBox(height: height * .01),
                    LabelButton(
                      onTap: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      title: "Already Have An Account?",
                      subTitle: "Sign In",
                    ),
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
