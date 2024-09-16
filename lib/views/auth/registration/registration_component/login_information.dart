import 'package:blukers/views/auth/common_widget/auth_field_wrapper.dart';
import 'package:blukers/views/auth/registration/registration_component/timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../services/validation.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../services/responsive.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../common_widget/label_button.dart';
import '../../common_widget/submit_button.dart';
import '../../login/components/sign_in_options.dart';

class LoginInformation extends StatefulWidget {
  const LoginInformation({super.key});

  @override
  State<LoginInformation> createState() => _LoginInformationState();
}

class _LoginInformationState extends State<LoginInformation> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String groupValue = '';

  bool isPasswordVisible = true;

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

    return Container(
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 59),
              Container(
                padding: Responsive.isDesktop(context)
                    ? EdgeInsets.zero
                    : const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/person_login.svg",
                      height: 75,
                      width: 75,
                    ),
                    const SizedBox(height: 21),
                    Text(
                     AppLocalizations.of(context)!.signupMessage,
                      style: GoogleFonts.montserrat(
                        color: ThemeColors.black1ThemeColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),
              if (!Responsive.isDesktop(context))
                const Timeline(currentStep: 0),
              if (!Responsive.isDesktop(context)) const SizedBox(height: 35),
              AuthTextFieldWrapper(
                label: AppLocalizations.of(context)!.emailAddress,
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
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ThemeColors.black1ThemeColor.withOpacity(.30),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          width: 0, color: ThemeColors.red1ThemeColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          width: 0, color: ThemeColors.secondaryThemeColor),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    hintText: AppLocalizations.of(context)!.enterEmailAddress,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          width: 0.5, color: Color.fromRGBO(227, 238, 246, 1)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          width: 0.5, color: Color.fromRGBO(227, 238, 246, 1)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: height * 0.010),
              AuthTextFieldWrapper(
                label: AppLocalizations.of(context)!.password,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: isPasswordVisible,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    setState(() {
                      isFormComplete();
                      node.unfocus();
                    });
                  },
                  validator: ((value) {
                    if (value!.length < 4) {
                      return "Enter More Than 6 Characters";
                    } else {
                      return null;
                    }
                  }),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.password,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey[300],
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ThemeColors.black1ThemeColor.withOpacity(.30),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          width: 0, color: ThemeColors.red1ThemeColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          width: 0, color: ThemeColors.secondaryThemeColor),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          width: 0.5, color: Color.fromRGBO(227, 238, 246, 1)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          width: 0.5, color: Color.fromRGBO(227, 238, 246, 1)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.identifyAs,
                style: GoogleFonts.montserrat(
                  color: ThemeColors.black1ThemeColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: ThemeColors.black1ThemeColor.withOpacity(.20),
                          width: 1,
                        ),
                      ),
                      child: RadioListTile(
                        visualDensity: const VisualDensity(horizontal: -4),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          "A ${AppLocalizations.of(context)!.worker}",
                          style: GoogleFonts.montserrat(
                            color: ThemeColors.black1ThemeColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
                        activeColor: ThemeColors.primaryThemeColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: ThemeColors.black1ThemeColor.withOpacity(.20),
                          width: 1,
                        ),
                      ),
                      child: RadioListTile(
                        visualDensity: const VisualDensity(horizontal: -4),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          "A ${AppLocalizations.of(context)!.company}",
                          style: GoogleFonts.montserrat(
                            color: ThemeColors.black1ThemeColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
                        activeColor: ThemeColors.secondaryThemeColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                child: SubmitButton(
                  onTap: () {
                    if (isFormComplete()) {
                      up.registerUser(
                        context: context,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                text:AppLocalizations.of(context)!.continueStr,
                  isDisabled: !isFormComplete(),
                ),
              ),
              const SizedBox(height: 30),
              const SignInOptions(),
              const SizedBox(height: 20),
              LabelButton(
                titleColor: ThemeColors.black1ThemeColor,
                subTitleColor: ThemeColors.secondaryThemeColorDark,
                onTap: () {
                  context.go("/login");
                },
                title: AppLocalizations.of(context)!.alreadyHaveAnAccount,
                subTitle: AppLocalizations.of(context)!.signIn,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
