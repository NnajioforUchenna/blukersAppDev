import 'package:blukers/providers/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../auth/common_widget/auth_input.dart';

class SocialMediaPage extends StatefulWidget {
  SocialMediaPage({Key? key}) : super(key: key);

  @override
  _SocialMediaPageState createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  TextEditingController websiteController = TextEditingController();
  late List<TextEditingController> platformControllers;
  late List<TextEditingController> linkControllers;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    CompanyProvider cp = Provider.of<CompanyProvider>(context, listen: false);
    websiteController.text = cp.previousParams['website'] ?? '';
    platformControllers =
        cp.previousParams['platformControllers'] ?? [TextEditingController()];
    linkControllers =
        cp.previousParams['linkControllers'] ?? [TextEditingController()];
    super.initState();
  }

  void addSocialMediaField() {
    platformControllers.add(TextEditingController());
    linkControllers.add(TextEditingController());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
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
                    const Text(
                      "Social Media Information",
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
                        controller: websiteController,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        validator: (value) =>
                            value!.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "Website Address",
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
                    ...List.generate(
                      platformControllers.length,
                      (index) => Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AuthInput(
                                  child: TextFormField(
                                    controller: platformControllers[index],
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (value) =>
                                        value!.isEmpty ? "Required" : null,
                                    decoration: InputDecoration(
                                      hintText: "Social Media Platform",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: AuthInput(
                                  child: TextFormField(
                                    controller: linkControllers[index],
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (value) =>
                                        value!.isEmpty ? "Required" : null,
                                    decoration: InputDecoration(
                                      hintText: "Link on Platform",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: addSocialMediaField,
                      child: Row(
                        children: [
                          const Spacer(),
                          IconButton(
                              onPressed: addSocialMediaField,
                              icon: const Icon(
                                Icons.add_circle,
                                color: Colors.deepOrangeAccent,
                                size: 30,
                              )),
                          const Text(
                            "Add More",
                            style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            cp.companyProfileBackPage();
                          },
                          child: const Text("Previous"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ThemeColors.secondaryThemeColor),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // All text fields are filled. You can navigate to the next page or perform your action here
                              cp.addSocialMediaInfo(
                                websiteController.text,
                                platformControllers,
                                linkControllers,
                              );
                            } else {
                              // Validation error
                              EasyLoading.showToast("Please fill all fields");
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
