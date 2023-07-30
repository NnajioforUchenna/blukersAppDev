import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../services/validation.dart';
import 'common_widget/auth_input.dart';
import 'common_widget/company_logo.dart';
import 'common_widget/label_button.dart';
import 'common_widget/submit_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .125),
                    const CompanyLogo(),
                    const SizedBox(height: 30),
                    FormBuilder(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          AuthInput(
                            child: FormBuilderTextField(
                              // key: Key('username'),
                              // name: 'username',
                              key: const Key('email'),
                              name: 'email',
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                              validator: ((value) {
                                if (value == null) {
                                  return "Required";
                                }
                                return Validation().validateEmail(value);
                              }),
                              decoration: InputDecoration(
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
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
                          AuthInput(
                            child: FormBuilderTextField(
                              key: const Key('password'),
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              validator: ((value) {
                                if (value == null) {
                                  return "required";
                                }
                              }),
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      true
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey[300],
                                    ),
                                    onPressed: () {},
                                  )),
                              name: 'password',
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      key: const Key('forgotPasswordButton'),
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color(0xFF8A8A8E),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * .020),
                    SubmitButton(
                      isDisabled: true,
                      key: const Key('loginButton'),
                      onTap: () {},
                      text: "Sign In",
                    ),
                    const SizedBox(height: 10),
                    LabelButton(
                      onTap: () {},
                      title: "Don't have an account?",
                      subTitle: "Register",
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
