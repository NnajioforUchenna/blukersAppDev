import 'package:blukers/providers/worker_provider.dart';
import 'package:blukers/views/common_views/components/timelines/timeline_navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/industry.dart';
import '../../../providers/industry_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/localization/localized_industries.dart';
import '../../../utils/localization/localized_jobs.dart';

class ClassificationPage extends StatefulWidget {
  ClassificationPage({Key? key}) : super(key: key);

  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  late WorkerProvider wp;
  late List<Industry> industries;
  List<String> selectedIndustries = [];
  Map<String, List<String>> selectedJobs = {};
  bool isSelected = false;
  isSelect() {
    setState(() {
      if (selectedJobs.isNotEmpty) {
        isSelected = true;
      } else {
        isSelected = false;
      }
    });
  }

  ScrollController scrollCtrl = ScrollController();
  @override
  void initState() {
    super.initState();
    wp = Provider.of<WorkerProvider>(context, listen: false);
    selectedIndustries = wp.previousParams['industries'] ?? [];
    selectedJobs = wp.previousParams['jobs'] ?? {};
    isSelect(); // Check if something is selected on initialization
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
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    industries = ip.industries.values.toList();
    wp = Provider.of<WorkerProvider>(context);
    return Container(
      color: Colors.white,
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        controller: scrollCtrl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   AppLocalizations.of(context)!.selectYourIndustriesAndJobs,
            //   textAlign: TextAlign.center,
            //   style: const TextStyle(
            //     color: Colors.deepOrangeAccent,
            //     fontSize: 25,
            //     fontWeight: FontWeight.w600,
            //     height: 1.25,
            //   ),
            // ),
            const SizedBox(height: 20),
            if (industries.isEmpty)
              const Center(child: CircularProgressIndicator()),
            ...industries.map((industry) {
              return Container(
                decoration: BoxDecoration(
                  // color: const Color.fromARGB(255, 250, 250, 250),
                  color: Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: Text(
                        LocalizedIndustries.get(context, industry.industryId),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                      ),
                      value: selectedIndustries.contains(industry.industryId),
                      onChanged: (bool? value) {
                        if (value != null && value) {
                          setState(() {
                            selectedIndustries.add(industry.industryId);
                          });
                        } else {
                          setState(() {
                            selectedIndustries.remove(industry.industryId);
                            selectedJobs.remove(industry.industryId);
                          });
                        }
                      },
                    ),
                    if (selectedIndustries.contains(industry.industryId))
                      ...industry.jobs.entries.map((entry) {
                        final jobId = entry.key;
                        final job = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: CheckboxListTile(
                            title: Text(
                              LocalizedJobs.get(context,
                                  jobId), // Assuming this method is correctly implemented to handle job IDs
                              style: TextStyle(
                                color: Colors.blueGrey[700],
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                                height: 1.25,
                              ),
                            ),
                            value: selectedJobs[industry.industryId]
                                    ?.contains(jobId) ??
                                false,
                            onChanged: (bool? value) {
                              if (!selectedJobs
                                  .containsKey(industry.industryId)) {
                                selectedJobs[industry.industryId] = [];
                              }
                              setState(() {
                                if (value == true) {
                                  selectedJobs[industry.industryId]!.add(jobId);
                                } else {
                                  selectedJobs[industry.industryId]!
                                      .remove(jobId);
                                }
                              });
                              // Call to isSelect() here; ensure it's correctly defined to react to selection changes
                            },
                          ),
                        );
                      }).toList(),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                TimelineNavigationButton(
                  isSelected: isSelected,
                  onPress: !isSelected
                      ? () => print('nothin to do')
                      : () {
                          wp.createWorkerProfile(
                            context,
                            selectedIndustries,
                            selectedJobs,
                          );
                        },
                ),
                // ElevatedButton(
                //   onPressed: !isSelected
                //       ? null
                //       : () {
                //           wp.createWorkerProfile(
                //               context, selectedIndustries, selectedJobs);
                //         },
                //   style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all<Color>(
                //         isSelected ? Colors.deepOrangeAccent : Colors.grey),
                //   ),
                //   child: Text(
                //     AppLocalizations.of(context)!.next,
                //     style: TextStyle(
                //       fontFamily: "Montserrat",
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
