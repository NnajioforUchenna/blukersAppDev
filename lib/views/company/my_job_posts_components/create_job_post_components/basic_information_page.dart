import 'package:blukers/utils/styles/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_posts_provider.dart';
import '../../../auth/common_widget/auth_input.dart';

class BasicInformationPage extends StatefulWidget {
  BasicInformationPage({Key? key}) : super(key: key);

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
    return SizedBox(
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Job Details",
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
                        controller: jobTitleController,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        validator: (value) =>
                            value!.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "Job Title",
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
                        maxLines: 5,
                        controller: jobDescriptionController,
                        textInputAction: TextInputAction.newline,
                        onEditingComplete: () => node.nextFocus(),
                        validator: (value) =>
                            value!.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "Job Description",
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
                        controller: positionsAvailableController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        validator: (value) =>
                            value!.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "Number of Positions Available",
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
                      "Job Urgency Level",
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
                          ? "Low"
                          : urgencyValue == 1
                              ? "Medium"
                              : "High",
                      activeColor: urgencyValue == 0
                          ? Colors.green
                          : urgencyValue == 1
                              ? Colors.blue
                              : Colors.red,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            jp.setJobPostPagePrevious();
                          },
                          child: Text("Previous"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ThemeColors.secondaryThemeColor),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (isFormComplete()) {
                              jp.addBasicInformation(
                                jobTitleController.text,
                                jobDescriptionController.text,
                                positionsAvailableController.text,
                                int.parse(urgencyValue.toString()),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ThemeColors.secondaryThemeColor),
                          ),
                          child: Text("Next"),
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
