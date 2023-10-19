import 'package:blukers/providers/company_provider.dart';
import 'package:blukers/utils/styles/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../services/responsive.dart';
import '../../auth/common_widget/auth_input.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:blukers/views/common_views/components/timelines/timeline_navigation_button.dart';

class GeneralInformationPage extends StatefulWidget {
  GeneralInformationPage({Key? key}) : super(key: key);

  @override
  _GeneralInformationPageState createState() => _GeneralInformationPageState();
}

class _GeneralInformationPageState extends State<GeneralInformationPage> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companySloganController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isFormComplete() {
    return companyNameController.text.isNotEmpty &&
        companySloganController.text.isNotEmpty &&
        shortDescriptionController.text.isNotEmpty;
  }

  ScrollController scrollCtrl = ScrollController();
  @override
  void initState() {
    super.initState();
    CompanyProvider cp = Provider.of<CompanyProvider>(context, listen: false);
    companyNameController.text = cp.previousParams["companyName"] ?? "";
    companySloganController.text = cp.previousParams["companySlogan"] ?? "";
    shortDescriptionController.text =
        cp.previousParams["shortDescription"] ?? "";
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      //added this listner to dismiss keyboard when scroll
      scrollCtrl.addListener(() {
        print('scrolling');
      });
      scrollCtrl.position.isScrollingNotifier.addListener(() {
        if (!scrollCtrl.position.isScrollingNotifier.value) {
          print('scroll is stopped');
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          print('scroll is started');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    return SizedBox(
      height: height,
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              controller: scrollCtrl,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Text(
                    //   AppLocalizations.of(context)!.generalInformation,
                    //   textAlign: TextAlign.center,
                    //   style: const TextStyle(
                    //     color: Colors.deepOrangeAccent,
                    //     fontSize: 25,
                    //     fontWeight: FontWeight.w600,
                    //     height: 1.25,
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    AuthInput(
                      child: TextFormField(
                        controller: companyNameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) => value!.isEmpty
                            ? AppLocalizations.of(context)!.required
                            : null,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.companyName,
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
                    SizedBox(height: height * 0.015),
                    AuthInput(
                      child: TextFormField(
                        controller: companySloganController,
                        maxLines: 2,
                        textInputAction: TextInputAction.newline,
                        validator: (value) => value!.isEmpty
                            ? AppLocalizations.of(context)!.required
                            : null,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.companySlogan,
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
                    SizedBox(height: height * 0.015),
                    AuthInput(
                      child: TextFormField(
                        controller: shortDescriptionController,
                        maxLines: 10,
                        textInputAction: TextInputAction.newline,
                        validator: (value) => value!.isEmpty
                            ? AppLocalizations.of(context)!.required
                            : null,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .companyShortDescription,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        TimelineNavigationButton(
                          isSelected: true,
                          onPress: () {
                            if (_formKey.currentState!.validate() &&
                                isFormComplete()) {
                              cp.addGeneralInformation(
                                  companyNameController.text,
                                  companySloganController.text,
                                  shortDescriptionController.text);
                            } else {
                              EasyLoading.showError(
                                  "Please fill all the fields");
                            }
                          },
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     if (_formKey.currentState!.validate() &&
                        //         isFormComplete()) {
                        //       cp.addGeneralInformation(
                        //           companyNameController.text,
                        //           companySloganController.text,
                        //           shortDescriptionController.text);
                        //     } else {
                        //       EasyLoading.showError(
                        //           "Please fill all the fields");
                        //     }
                        //   },
                        //   style: ButtonStyle(
                        //     backgroundColor: MaterialStateProperty.all<Color>(
                        //         ThemeColors.secondaryThemeColor),
                        //   ),
                        //   child: const Text("Next"),
                        // ),
                      ],
                    ),
                    SizedBox(height: height * .05),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
