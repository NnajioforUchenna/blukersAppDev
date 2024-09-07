import 'package:blukers/views/auth/common_widget/auth_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../services/validation.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../services/responsive.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../common_widget/label_button.dart';
import '../../common_widget/submit_button.dart';

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
      color: Colors.white,
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.6),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10),
                AuthTextFieldWrapper(
                  label: AppLocalizations.of(context)!.email,
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
                      hintText: AppLocalizations.of(context)!.email,
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
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.whatDoYouIdentifyAs,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ThemeColors.secondaryThemeColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
                            "${AppLocalizations.of(context)!.iAmA} ${AppLocalizations.of(context)!.worker}",
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
                          activeColor: ThemeColors.primaryThemeColor,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          dense: true,
                          title: Text(
                            "${AppLocalizations.of(context)!.iAmA2} ${AppLocalizations.of(context)!.company}",
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
                          activeColor: ThemeColors.secondaryThemeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                SubmitButton(
                  onTap: () {
                    if (isFormComplete()) {
                      up.registerUser(
                        context: context,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                  text: AppLocalizations.of(context)!.register,
                  isDisabled: !isFormComplete(),
                ),
                SizedBox(height: height * .01),
                LabelButton(
                  onTap: () {
                    context.go("/login");
                  },
                  title: AppLocalizations.of(context)!.alreadyHaveAnAccount,
                  subTitle: AppLocalizations.of(context)!.signIn,
                ),
              ],
            ),
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
