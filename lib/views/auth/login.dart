import 'package:bulkers/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../services/responsive.dart';
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
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isFormComplete() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: height,
          width: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width,
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
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            AuthInput(
                              child: FormBuilderTextField(
                                controller: emailController,
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
                                onChanged: (value) {
                                  setState(() {
                                    isFormComplete();
                                  });
                                },
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
                                controller: passwordController,
                                key: const Key('password'),
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                validator: ((value) {
                                  if (value == null) {
                                    return "required";
                                  }
                                }),
                                onChanged: (value) {
                                  setState(() {
                                    isFormComplete();
                                  });
                                },
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
                        onTap: () {
                          Navigator.pushNamed(context, '/forgot-password');
                        },
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
                        isDisabled: !isFormComplete(),
                        key: const Key('loginButton'),
                        onTap: () async {
                          if (isFormComplete()) {
                            // You can submit your form data here.
                            print('Form is valid');
                            await up.loginAppUser(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                                chatProvider: chatProvider);
                            await chatProvider.getGroups(up.appUser?.uid ?? "");
                          }
                        },
                        text: "Sign In",
                      ),
                      const SizedBox(height: 10),
                      LabelButton(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
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
      ),
    );
  }
}
