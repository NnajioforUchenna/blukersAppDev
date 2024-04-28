import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../services/make_responsive_web.dart';
import '../../../services/responsive.dart';
import '../../../services/validation.dart';
import '../common_widget/auth_input.dart';
import '../common_widget/company_logo.dart';
import '../common_widget/label_button.dart';
import '../common_widget/submit_button.dart';
import 'components/sign_in_options.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;

  bool isFormComplete() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
    return Scaffold(
      body: MakeResponsiveWeb(
        image: const AssetImage('assets/images/login.png'),
        child: Center(
          child: SizedBox(
            height: height,
            width: Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width * 0.4
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
                                      return AppLocalizations.of(context)!
                                          .required;
                                    }
                                    return Validation().validateEmail(value);
                                  }),
                                  onChanged: (value) {
                                    setState(() {
                                      isFormComplete();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.email,
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
                                  obscureText: isPasswordVisible,
                                  textInputAction: TextInputAction.done,
                                  validator: ((value) {
                                    if (value == null) {
                                      return AppLocalizations.of(context)!
                                          .required;
                                    }
                                    return null;
                                  }),
                                  onChanged: (value) {
                                    setState(() {
                                      isFormComplete();
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!
                                          .password,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey[300],
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isPasswordVisible =
                                                !isPasswordVisible; // Toggle the password visibility state
                                          });
                                        },
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
                            context.push('/forgot-password');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.centerRight,
                            child: Text(
                              AppLocalizations.of(context)!.forgotPassword,
                              style: const TextStyle(
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
                              await up.loginAppUser(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordController.text);
                              //   await chatProvider.getGroups(up.appUser?.uid ?? "");
                            }
                          },
                          text: AppLocalizations.of(context)!.signIn,
                        ),
                        const SizedBox(height: 30),
                        const SignInOptions(),
                        LabelButton(
                          onTap: () {
                            context.go('/register');
                          },
                          title:
                              AppLocalizations.of(context)!.dontHaveAnAccount,
                          subTitle: AppLocalizations.of(context)!.register,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
