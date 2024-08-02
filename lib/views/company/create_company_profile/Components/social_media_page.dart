import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/company_provider.dart';
import '../../../../services/responsive.dart';
import '../../../auth/common_widget/auth_input.dart';
import '../../../worker/create_worker_profile/create_worker_profile_components/timeline_navigation_button.dart';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({super.key});

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

  void removeLastSocialMediaField() {
    if (platformControllers.isNotEmpty) {
      platformControllers.removeLast();
      linkControllers.removeLast();
      setState(() {});
    }
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
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.companyWebsite,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    const SizedBox(height: 20),
                    AuthInput(
                      child: TextFormField(
                        controller: websiteController,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        validator: (value) => value!.isEmpty
                            ? AppLocalizations.of(context)!.required
                            : null,
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.websiteAddress,
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
                    Text(
                      AppLocalizations.of(context)!.socialNetworks,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                    ...List.generate(
                      platformControllers.length,
                      (index) => Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Expanded(
                              // child: AuthInput(
                              AuthInput(
                                child: TextFormField(
                                  controller: platformControllers[index],
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () => node.nextFocus(),
                                  validator: (value) => value!.isEmpty
                                      ? AppLocalizations.of(context)!.required
                                      : null,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .socialNetworkPlatformName,
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
                              // ),
                              const SizedBox(height: 5),
                              // Expanded(
                              // child: AuthInput(
                              AuthInput(
                                child: TextFormField(
                                  controller: linkControllers[index],
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () => node.nextFocus(),
                                  validator: (value) => value!.isEmpty
                                      ? AppLocalizations.of(context)!.required
                                      : null,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .socialNetworkPlatformLink,
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
                              // ),
                            ],
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     InkWell(
                    //       onTap: removeLastSocialMediaField,
                    //       child: Text(
                    //         AppLocalizations.of(context)!.removeLast,
                    //         style: const TextStyle(
                    //           color: Colors.red,
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.bold,
                    //           fontFamily: "Montserrat",
                    //         ),
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: addSocialMediaField,
                    //       child: Text(
                    //         AppLocalizations.of(context)!.addMore,
                    //         style: const TextStyle(
                    //           color: Colors.blueAccent,
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.bold,
                    //           fontFamily: "Montserrat",
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    InkWell(
                      onTap: removeLastSocialMediaField,
                      child: Row(
                        children: [
                          const Spacer(),
                          IconButton(
                              onPressed: removeLastSocialMediaField,
                              icon: const Icon(
                                Icons.remove_circle_sharp,
                                color: Colors.red,
                                size: 30,
                              )),
                          Text(
                            AppLocalizations.of(context)!.removeLast,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                            ),
                          ),
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
                                color: Colors.blueAccent,
                                size: 30,
                              )),
                          Text(
                            AppLocalizations.of(context)!.addMore,
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TimelineNavigationButton(
                          isSelected: true,
                          onPress: () => cp.companyProfileBackPage(),
                          navDirection: "back",
                        ),
                        TimelineNavigationButton(
                          isSelected: true,
                          onPress: () {
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
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     cp.companyProfileBackPage();
                        //   },
                        //   child: const Text("Previous"),
                        //   style: ButtonStyle(
                        //     backgroundColor: MaterialStateProperty.all<Color>(
                        //         ThemeColors.secondaryThemeColor),
                        //   ),
                        // ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     if (_formKey.currentState!.validate()) {
                        //       // All text fields are filled. You can navigate to the next page or perform your action here
                        //       cp.addSocialMediaInfo(
                        //         websiteController.text,
                        //         platformControllers,
                        //         linkControllers,
                        //       );
                        //     } else {
                        //       // Validation error
                        //       EasyLoading.showToast("Please fill all fields");
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
