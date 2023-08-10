import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/utils/styles/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/company_provider.dart';
import '../../../services/responsive.dart';
import '../../auth/common_widget/auth_input.dart';

class CompanyCharacteristicsPage extends StatefulWidget {
  CompanyCharacteristicsPage({Key? key}) : super(key: key);

  @override
  _CompanyCharacteristicsPageState createState() =>
      _CompanyCharacteristicsPageState();
}

class _CompanyCharacteristicsPageState
    extends State<CompanyCharacteristicsPage> {
  TextEditingController companySizeController = TextEditingController();
  TextEditingController industryController = TextEditingController();
  TextEditingController yearFoundedController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isFormComplete() {
    return companySizeController.text.isNotEmpty &&
        industryController.text.isNotEmpty &&
        yearFoundedController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    return SizedBox(
      height: height,
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
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
                    Text(
                      "Company Characteristics",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AuthInput(
                      child: TextFormField(
                        controller: companySizeController,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        validator: (value) =>
                            value!.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "Company Size",
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
                    SizedBox(height: height * 0.05),
                    AuthInput(
                      child: TextFormField(
                        controller: industryController,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        validator: (value) =>
                            value!.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "Industry",
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
                    SizedBox(height: height * 0.05),
                    AuthInput(
                      child: TextFormField(
                        controller: yearFoundedController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          }
                          final int currentYear = DateTime.now().year;
                          final int? year = int.tryParse(value);
                          if (year == null || year > currentYear) {
                            return "Enter a valid year (up to $currentYear)";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Year Founded",
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
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Go to the previous page
                          },
                          child: Text("Previous"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ThemeColors.secondaryThemeColor),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                isFormComplete()) {
                              bool result = await cp.addCompanyCharacteristics(
                                companySizeController.text,
                                industryController.text,
                                yearFoundedController.text,
                              );
                              if (result) {
                                up.companyTimelineStep = 2;
                              }
                              print("Company Characteristics Added");
                            } else {
                              EasyLoading.showError(
                                  "Please fill all the fields");
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ThemeColors.secondaryThemeColor),
                          ),
                          child: const Text("Next"),
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
