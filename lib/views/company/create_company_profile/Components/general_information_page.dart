import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/company_provider.dart';
import '../../../../services/responsive.dart';
import '../../../auth/common_widget/auth_input.dart';
import '../../../worker/create_worker_profile/create_worker_profile_components/timeline_navigation_button.dart';

class GeneralInformationPage extends StatefulWidget {
  const GeneralInformationPage({super.key});

  @override
  State<GeneralInformationPage> createState() => _GeneralInformationPageState();
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CompanyProvider cp = Provider.of<CompanyProvider>(context, listen: false);
      companyNameController.text = cp.previousParams["companyName"] ?? "";
      companySloganController.text = cp.previousParams["companySlogan"] ?? "";
      shortDescriptionController.text =
          cp.previousParams["shortDescription"] ?? "";
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
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                        const Spacer(),
                        TimelineNavigationButton(
                          isSelected: true,
                          onPress: () {
                            if (_formKey.currentState!.validate() &&
                                isFormComplete()) {
                              FocusScope.of(context).unfocus();
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
