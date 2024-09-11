import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_posts_provider.dart';
import '../../../auth/common_widget/auth_input.dart';
import '../../../worker/create_worker_profile/create_worker_profile_components/timeline_navigation_button.dart';

class BasicInformationPage extends StatefulWidget {
  const BasicInformationPage({super.key});

  @override
  _BasicInformationPageState createState() => _BasicInformationPageState();
}

class _BasicInformationPageState extends State<BasicInformationPage> {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController positionsAvailableController = TextEditingController();
  double urgencyValue = 1; // default to "medium"

  @override
  void initState() {
    super.initState();
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context, listen: false);
    jobTitleController.text = jp.previousParams['title'] ?? '';
    jobDescriptionController.text = jp.previousParams['description'] ?? '';
    positionsAvailableController.text =
        jp.previousParams['positionsAvailable'] ?? '';
    urgencyValue = jp.previousParams['urgencyValue'] ?? 1;
  }

  bool isFormComplete() {
    return jobTitleController.text.isNotEmpty &&
        jobDescriptionController.text.isNotEmpty &&
        positionsAvailableController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => jp.setJobPostPagePrevious(),
        ),
        title: Text(
          AppLocalizations.of(context)!.createJobPost,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 60),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.jobTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        // Add some space between the title and the TextFormField
                        const SizedBox(height: 20),
                        // Your AuthInput widget with TextFormField
                        AuthInput(
                          child: TextFormField(
                            controller: jobTitleController,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            validator: (value) => value!.isEmpty
                                ? AppLocalizations.of(context)!.required
                                : null,
                            decoration: InputDecoration(
                              hintText: "input job title",
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
                      ],
                    ),
                    SizedBox(height: height * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Title for Job Description
                        Text(
                          AppLocalizations.of(context)!.jobDescription,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(
                            height: 20), // Space between title and text field
                        // AuthInput widget with TextFormField for Job Description
                        AuthInput(
                          child: TextFormField(
                            maxLines: 5,
                            controller: jobDescriptionController,
                            textInputAction: TextInputAction.newline,
                            onEditingComplete: () => node.nextFocus(),
                            validator: (value) => value!.isEmpty
                                ? AppLocalizations.of(context)!.required
                                : null,
                            decoration: InputDecoration(
                              hintText: "input job description",
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

                        // Title for Number of Positions Available
                        Text(
                          AppLocalizations.of(context)!
                              .numberOfPositionsAvailable,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // AuthInput widget with TextFormField for Number of Positions Available
                        AuthInput(
                          child: TextFormField(
                            controller: positionsAvailableController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            validator: (value) => value!.isEmpty
                                ? AppLocalizations.of(context)!.required
                                : null,
                            decoration: InputDecoration(
                              hintText: "input number of positions available",
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
                      ],
                    ),
                    SizedBox(height: height * 0.05),
                    Text(
                      AppLocalizations.of(context)!.jobUrgencyLevel,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    Slider(
                      value: urgencyValue,
                      onChanged: (newValue) {
                        setState(() {
                          urgencyValue = newValue;
                        });
                      },
                      min: 0,
                      max: 2,
                      divisions: 2,
                      label: urgencyValue == 0
                          ? AppLocalizations.of(context)!.lowF
                          : urgencyValue == 1
                              ? AppLocalizations.of(context)!.mediumF
                              : AppLocalizations.of(context)!.highF,
                      activeColor: urgencyValue == 0
                          ? Colors.green
                          : urgencyValue == 1
                              ? Colors.blue
                              : Colors.red,
                    ),
                    const SizedBox(height: 25),
                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () => jp.setJobPostPagePrevious(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:Colors.white, // Background color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80,
                                  vertical: 20), // Increased padding
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8.0), // Rounded corners
                              ),
                          
                              side: const BorderSide(
                                color: Colors.deepOrange, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                            child: FittedBox(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .previous, // Text for the button
                                style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 16, // Increased font size
                                  fontWeight: FontWeight.w600, // Font weight
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 50),
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              if (isFormComplete()) {
                                jp.addBasicInformation(
                                  jobTitleController.text,
                                  jobDescriptionController.text,
                                  positionsAvailableController.text,
                                  urgencyValue.round(),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.deepOrange, // Background color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80,
                                  vertical: 20), // Increased padding
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8.0), // Rounded corners
                              ),
                            ),
                            child: FittedBox(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .next, // Text for the button
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16, // Increased font size
                                  fontWeight: FontWeight.w600, // Font weight
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                     const SizedBox(height: 20),
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
