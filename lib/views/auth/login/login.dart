import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/auth/common_widget/auth_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../services/responsive.dart';
import '../../../services/validation.dart';
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
      backgroundColor: Colors.white,
      body: ResponsiveAuth(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (Responsive.isMobile(context))
                          SizedBox(height: height * .1),
                        Container(
                          padding: Responsive.isDesktop(context)
                              ? EdgeInsets.zero
                              : const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset("assets/icons/person_login.svg"),
                              const SizedBox(height: 21),
                              Text(
                                "Please Login or register to continue or to Access this content",
                                style: GoogleFonts.montserrat(
                                  color: ThemeColors.black1ThemeColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                        Responsive.isMobile(context)
                            ? const SizedBox(height: 59)
                            : const SizedBox(height: 35),
                        FormBuilder(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              AuthTextFieldWrapper(
                                label: AppLocalizations.of(context)!.email,
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
                                    hintStyle: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: ThemeColors.black1ThemeColor
                                          .withOpacity(.30),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          width: 0,
                                          color: ThemeColors.red1ThemeColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          width: 0,
                                          color:
                                              ThemeColors.secondaryThemeColor),
                                    ),
                                    contentPadding: const EdgeInsets.all(20),
                                    hintText:
                                        AppLocalizations.of(context)!.email,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          width: 0.5,
                                          color:
                                              Color.fromRGBO(227, 238, 246, 1)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          width: 0.5,
                                          color:
                                              Color.fromRGBO(227, 238, 246, 1)),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              AuthTextFieldWrapper(
                                label: AppLocalizations.of(context)!.password,
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
                                      hintStyle: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: ThemeColors.black1ThemeColor
                                            .withOpacity(.30),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                            width: 0.5,
                                            color: Color.fromRGBO(
                                                227, 238, 246, 1)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                            width: 0,
                                            color: ThemeColors.red1ThemeColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                            width: 0,
                                            color: ThemeColors
                                                .secondaryThemeColor),
                                      ),
                                      contentPadding: const EdgeInsets.all(20),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                            width: 0.5,
                                            color: Color.fromRGBO(
                                                227, 238, 246, 1)),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          isPasswordVisible
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: ThemeColors.black1ThemeColor,
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
                              style: GoogleFonts.montserrat(
                                color: ThemeColors.secondaryThemeColorDark,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * .020),
                        SubmitButton(
                          backgroundColor: ThemeColors.secondaryThemeColorDark,
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
                            print(up.appUser?.uid ?? 'No user');
                          },
                          text: AppLocalizations.of(context)!.signIn,
                          // print the uid
                        ),
                        const SizedBox(height: 30),
                        const SignInOptions(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  LabelButton(
                    titleColor: ThemeColors.black1ThemeColor,
                    subTitleColor: ThemeColors.secondaryThemeColorDark,
                    onTap: () {
                      context.go('/register');
                    },
                    title: AppLocalizations.of(context)!.dontHaveAnAccount,
                    subTitle: AppLocalizations.of(context)!.register,
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ResponsiveAuth extends StatelessWidget {
  const ResponsiveAuth({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Desktop layout
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .85,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/icons/login_desk.png',
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            left: 51,
                            bottom: 58,
                            child: SizedBox(
                              width: 337,
                              child: Text(
                                "Start searching for jobs in different Industries",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 58,
                    ),
                    Expanded(
                      child: child,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          // Mobile layout
          return child;
        }
      },
    );
  }
}
